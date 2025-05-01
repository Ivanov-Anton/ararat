module Entities
  class BooksResponse < Grape::Entity
    expose :data, using: Entities::BookEntity, as: :data, documentation: { type: 'Array', desc: 'Array of books' }

    expose :meta, documentation: { type: 'Hash', desc: 'Metadata' } do
      expose :total_records, documentation: { type: 'Integer', desc: 'Total count of books' }
    end
  end
end
