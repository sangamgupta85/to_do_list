class AddDescriptionIndexToTodos < ActiveRecord::Migration
  def up
  	add_index :todos, :description
  end

  def down
  	remove_index :todos, :description
  end
end
