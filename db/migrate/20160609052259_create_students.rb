class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.integer :id
      t.string :name
      t.integer :maths
      t.integer :physics
      t.integer :chemistry

      t.timestamps
    end
  end
end
