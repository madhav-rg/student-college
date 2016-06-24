class AddSNoTo < ActiveRecord::Migration
  def up
  	remove_column :students, :id_no, :integer
  end

  def down
  	add_column :students, :s_id, :integer
  end
end
