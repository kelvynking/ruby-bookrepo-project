class CreateUsers < ActiveRecord::Migration[5.2]
    def change
        create_table :users do |t|
            t.string :username, null: false, unique: true
            t.string :password, null: false
            t.string :email, null: false
            t.boolean :loggedin, null: false, default: false
            t.timestamps 
        end
    end
end