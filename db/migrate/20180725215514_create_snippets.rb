class CreateSnippets < ActiveRecord::Migration[5.2]
  def change
    create_table :snippets do |t|
      t.string :slug
      t.string :code
      t.string :title
      t.string :language
      t.string :stack

      t.timestamps
    end
  end
end
