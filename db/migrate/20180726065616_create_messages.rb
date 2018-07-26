class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :snippet_id
      t.string :author
      t.string :body 
      t.timestamps
    end
  end
end
