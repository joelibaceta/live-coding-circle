class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :hashcode

      t.timestamps
    end
  end
end
