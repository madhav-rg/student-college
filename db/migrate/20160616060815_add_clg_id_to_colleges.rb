class AddClgIdToColleges < ActiveRecord::Migration
  def change
  	rename_column :students, :college, :college_id
  end
end
