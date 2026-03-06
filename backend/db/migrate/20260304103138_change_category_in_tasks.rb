class ChangeCategoryInTasks < ActiveRecord::Migration[8.0]
  def change
    remove_column :tasks, :category, :string, null: false
    add_reference :tasks, :category, foreign_key: true
  end
end
