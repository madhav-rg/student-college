class AddStuidToStudents < ActiveRecord::Migration
  def change
    add_column :students, :sid, :integer
  end
end
