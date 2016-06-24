class RemoveSidFromStudents < ActiveRecord::Migration
  def up
    remove_column :students, :sid
  end

  def down
    add_column :students, :sid, :integer
  end
end
