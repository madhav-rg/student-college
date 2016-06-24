class ChangeCollegeIdInStudents < ActiveRecord::Migration
  def self.up
  	change_column :students, :college_id, :integer
  end
  def self.down
  	change_column :students , :college_id, :text
  end
end
