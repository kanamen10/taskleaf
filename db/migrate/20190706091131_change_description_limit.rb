class ChangeDescriptionLimit < ActiveRecord::Migration[6.0]
  def up
    change_column :tasks, :name, :string, limit: 30
    change_column :tasks, :description, :text, limit: 100
  end
  def down
    change_column :tasks, :name, :string
    change_column :tasks, :description, :text
  end
end
