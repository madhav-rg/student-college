class RemoveIdNoFromStudents < ActiveRecord::Migration
  def up
    remove_column :students, :id_no
  end

  def down
    add_column :students, :id_no, :integer
  end
end
