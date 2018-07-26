class AddThemeToSnippets < ActiveRecord::Migration[5.2]
  def change
    add_column :snippets, :theme, :string
  end
end
