class RenameColumnFromStudents < ActiveRecord::Migration
  def change
  	rename_column :students, :college, :college_id
  end
end
