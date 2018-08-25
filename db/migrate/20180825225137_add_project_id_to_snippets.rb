class AddProjectIdToSnippets < ActiveRecord::Migration[5.2]
  def change
    add_column :snippets, :project_id, :integer
  end
end
