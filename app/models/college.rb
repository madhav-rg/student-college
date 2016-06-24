class College < ActiveRecord::Base
  attr_accessible :name, :year
  has_many :students #Have a chat with others regarding this.
  before_update :create_extended_sid_value, if: Proc.new{|college| college.name_changed?}

  validates :name, presence: true
  validates :year, numericality: { only_integer: true }

  def create_extended_sid_value
  	#Rails.logger.debug "Ins collge modellllllllll: #{params.inspect}"
  	Rails.logger.debug  "llllllllllllllllllllllllllllllllllllll #{self.name.inspect}"
  	Rails.logger.debug  "llllllllllllllllllllllllllllllllllllll #{self.name_changed?.inspect}"
  	#if self.name_changed?
  		array = Student.find_all_by_college_id(self.id)
  		array.each do |k|
  			k.extended_sid = k.id.to_s<<"_"<<self.name[0,2]<<"_"<<self.id.to_s
  			Rails.logger.debug  "lllllllllllllllaaaaaaaaaaaaaaaaaaaaaaa: #{k.inspect}" #This and down debugger line shows same-
  			k.save
  			Rails.logger.debug  "llllllllllllllllllllllllllllllllllllll: #{k.inspect}" #-, but after save statement, value get's saved into data base.
  			#Rails.logger.debug  "llllllllllllllllllllllllllllllllllllll #{k.extended__sid.inspect}" # This also works.
  		end
  	#end

  end

end
