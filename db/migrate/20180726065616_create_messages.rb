class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.integer :snippet_id
      t.string :author
      t.string :message

      t.timestamps
    end
  end
end
