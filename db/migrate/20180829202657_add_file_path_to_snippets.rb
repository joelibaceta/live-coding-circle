class AddFilePathToSnippets < ActiveRecord::Migration[5.2]
  def change
    add_column :snippets, :file_path, :string
  end
end
