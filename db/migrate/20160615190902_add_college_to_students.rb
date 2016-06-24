class AddCollegeToStudents < ActiveRecord::Migration
  def change
    add_column :students, :college, :string
  end
end
