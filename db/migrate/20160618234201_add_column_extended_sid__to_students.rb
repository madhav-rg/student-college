class AddColumnExtendedSidToStudents < ActiveRecord::Migration
  def change
    add_column :students, :extended_sid, :string
  end
end
