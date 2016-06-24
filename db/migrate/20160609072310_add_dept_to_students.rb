class AddDeptToStudents < ActiveRecord::Migration
  def change
    add_column :students, :dept, :string
  end
end
