require "#{Rails.application.config.root}/app/models/book"
require "#{Rails.application.config.root}/app/models/application_record"
# require 'active_record'
module Entities
  class BookEntity < Grape::Entity
    format_with(:iso_timestamp) { |dt| dt.iso8601 }

    expose :id, documentation: { type: 'Integer', desc: 'Unique identifier for the book', example: 1 }
    expose :title, documentation: { type: 'String', desc: 'Title of the book', example: 'The Great Gatsby' }
    expose :author, documentation: { type: 'String', desc: 'Author of the book', example: 'F. Scott Fitzgerald' }

    with_options(format_with: :iso_timestamp) do
      expose :created_at, documentation: { type: 'DateTime', desc: 'Date the book was created' }
      expose :updated_at, documentation: { type: 'DateTime', desc: 'Date the book was last updated' }
    end
  end
end
