class RemoveBisibility < ActiveRecord::Migration[8.0]
  def change
    remove_column :tasks, :visibility, :integer
  end
end
