# app/api/books_api.rb
require 'grape'
require 'grape-swagger'
require_relative 'entities/book_entity'
require_relative 'entities/error_entity'
require_relative 'entities/book_response'

class BooksApi < Grape::API
  format :json # API will respond with JSON
  prefix :api

  if Rails.env.prod?
    rescue_from :all do
      error!({ type: :base, error_message: "Internal Server Error" }, 500)
    end
  end

  resource :books do
    # GET /books
    desc 'Return all books' do
      success Entities::BooksResponse
      failure [
        { code: 404, message: 'Not Found' },
        { code: 500, message: 'Server Error' }
      ]
      nickname 'books'
    end

    params do
      optional 'filters[created_at]', type: String, desc: 'Filter by created AT field'
    end

    get do
      books = Book.all
      present(
        {
          data: books,
          meta: { total_records: nil }
        },
        with: Entities::BooksResponse
      )
    end

    # POST /books
    desc 'Create a new book' do
      success Entities::BookEntity
      failure [
        [401, 'KittenBitesError'],
        [500, 'Server Error']
      ]
      nickname :createBook
    end
    params do
      requires :title, type: String, desc: 'Book title'
      requires :author, type: String, desc: 'Book author'
    end
    post do
      book = Book.build(title: params[:title], author: params[:author])
      if book.title.blank?
        # render json: [{ type: :title, message: 'cant be blank' }]
        present type: :title, error_message: 'cant be blank' and return
      elsif book.author.blank?
        present type: :author, error_message: 'cant be blank' and return
      end
      book.created_at = Time.now.utc
      book.updated_at = book.created_at
      book.save
      present book, with: Entities::BookEntity
    end

    # GET /api/books/:id
    desc 'Return a specific book by ID' do
      failure [
        [401, 'KittenBitesError'],
        [404, 'Book not found'],
        [500, 'Server Error']
      ]
      success Entities::BookEntity
      produces ['application/json']
      nickname :book
    end

    params do
      requires :id, type: Integer, desc: 'Book ID'
    end

    # provode present to display example of response in swagger schema
    get ':id' do
      book = Book.find(params[:id])
      present book, with: Entities::BookEntity

    rescue ActiveRecord::RecordNotFound
      error!({ "error" => "Book not found" }, 404)
    end

    desc 'Delete specific book by ID' do
      nickname 'deleteBook'
    end

    delete ':id' do
      book = Book.find(params[:id])
      book.destroy
      present book, with: Entities::BookEntity
    rescue ActiveRecord::RecordNotFound
      error!({ "error" => "Book not found" }, 404)
    end
  end

  add_swagger_documentation \
  info: {
    title: "The API title to be displayed on the API homepage.",
    description: "A description of the API.",
    contact_name: "Contact name",
    contact_email: "anton.i@hey.com",
    contact_url: "https://example.com",
    license: "The name of the license.",
    license_url: "https://example.com",
    terms_of_service_url: "https://example.com",
  }
end
