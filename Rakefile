# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"
require 'grape-swagger/rake/oapi_tasks'
require "#{Rails.application.config.root}/app/api/books_api"

GrapeSwagger::Rake::OapiTasks.new('::BooksApi')

Rails.application.load_tasks
