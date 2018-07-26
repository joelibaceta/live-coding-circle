class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :message do |t|
      t.string :snippet_id
      t.string :author
      t.string :message

      t.timestamps
    end
  end
end
