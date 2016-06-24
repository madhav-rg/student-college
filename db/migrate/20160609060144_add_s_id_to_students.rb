class AddSIdToStudents < ActiveRecord::Migration
  def change
  	add_column :students, :s_id, :integer
  end
end
