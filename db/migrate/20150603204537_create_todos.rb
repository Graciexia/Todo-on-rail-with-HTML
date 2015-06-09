class CreateTodos < ActiveRecord::Migration
  def change
     create_table :todos do |t|
      t.string :todo, null: false, limit: 300
      t.boolean :complete, null: false, default: false
      t.timestamps null: false
    end
  end
end
