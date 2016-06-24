class RemoveCollegeIdFromColleges < ActiveRecord::Migration
  def up
    remove_column :colleges, :college_id
  end

  def down
    add_column :colleges, :college_id, :integer
  end
end
