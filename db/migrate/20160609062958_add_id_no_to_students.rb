class AddIdNoToStudents < ActiveRecord::Migration
  def change
  	add column :students, :id_no, :integer
  end
end
