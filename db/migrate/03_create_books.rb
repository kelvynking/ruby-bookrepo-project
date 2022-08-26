class CreateBooks < ActiveRecord::Migration[5.2]
    def change
        create_table :books do |t|
            t.string :title
            t.string :description
            t.decimal :rating
            t.string :author
            t.integer :num_pages
            t.decimal :price
            t.boolean :favorite, default: false
            t.string :url
            t.string :genre
            t.timestamps
        end
    end
end