class Student < ActiveRecord::Base
  attr_accessible :chemistry, :sid, :maths, :name, :physics, :dept, :year, :college_id, :extended_sid
  belongs_to :college  #It's been mentioned in the site that the associations had to be made in singular form,
  # but mine is in singular form, if plural coninciding with coloumn lable.
  #validates :maths, :length=>{:maximum => 100 , :message => "marks too long"} #This isn't working properly.
  #before_update :create_extended_sid_value #This has to be in the college model.
  before_create :create_extended_sid_value

  validates :dept, presence: true
  validates :maths, inclusion: { in: 0..100, message: " :Given integer out of range."}
  validates :physics, inclusion: { in: 0..100, message: " :Given integer out of range."}
  validates :chemistry, inclusion: { in: 0..100, message: ":Given integer out of range."}
  #validates :sid, presence: true, message: "There has to a student ideentity number."
  #validates :year, inclusion: { in: 1700..2016, message: " :Given established year out of range."}
  validates :year, numericality: { only_integer: true }
  validates :college_id, presence: true

  def create_extended_sid_value
  	temp1 = self.id.to_s # Returns the copy of the string.
  	Rails.logger.debug " In student modellllllllll : #{temp1.inspect}"
  	temp1 = temp1.to_s<<"_"<<College.find(self.college_id)[:name][0,2]<<"_"<<self.college_id.to_s
  	Rails.logger.debug " In student modellllllllll : #{temp1.inspect}"
  	self.extended_sid = temp1
  	
  end
end
