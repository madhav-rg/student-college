class CollegesController < ApplicationController


def index
	@colleges = College.all
	Rails.logger.debug "In Indexxxxxxxxxxxxxxxxxxx methodddddddddd: #{@colleges.inspect}"
end

def show
	@clg = College.find(params[:id])
end

def create
	college = College.new(params[:college])
	if college.save
  		redirect_to action: :index
  	end
end

def edit 
	@college = College.find(params[:id])
end

def destroy
	clg = College.find(params[:id])
	clg.destroy
	redirect_to action: :index

end

def update 
	Rails.logger.debug "In Updateeeeeeeeeeeeeeeeeeeeeeeee method:#{params.inspect}"
	clg = College.find(params[:id])
	if clg.update_attributes(params["college"])
  		redirect_to action: :index
  	end
  	#Rails.logger.debug "In error testinggggggggggggggggggggggggg: "
=begin  	
  	respond_to do |format|
		if @clg.update_attributes(params["college"])
	  		format.html {redirect_to college_path(@clg), notice: "College details Updated"}
	  	else
	  		Rails.logger.debug "In erorrrrrrrrrrrrrrrr situtationnnnnnnnnnnnnn: #{@clg.errors.inspect}"
	  		format.html {render action: :edit}
	  	end
	end
=end
	
end

def new

end

def search_tag
	clg = College.all
	Rails.logger.debug "In search tagggsssssssssssssssssssss: #{params.inspect}"
	@output=[]
	Rails.logger.debug "In search_tag boxxxxxxxxxxxxxxxxxxxxxxxxx: #{params["var"]["name"].inspect}"
	Rails.logger.debug "In search_tag booooooooxxxxxxxxxxxxxxxxxxxxxxxxx: #{clg[0]["name"].inspect}"
	clg.each do |k|
		if k[:name].include? params["var"]["name"]
			#Rails.logger.debug "In search_tag booooooooxxssssssssss: #{k.inspect}"
		   @output.push({"id"=> k[:id], "name"=> k[:name], "year"=> k[:year]})
		end
	end
	Rails.logger.debug "In search_tag bbbbbbbbbbbbbbbbbbbbbboxxx: #{@output.inspect}"
end

def associate_tables
	Rails.logger.debug "In associate tabbleeeeeeeeeesssssss: #{College.all.inspect}"
	clg = College.includes(:students).find(params[:id])#This(includes(:student)) will makke sure minimum number of queries are made.
	@answer = clg.students
	Rails.logger.debug "In associate tablesssssssssss: #{@answer.inspect}"
	#temp = College.find_all_by_year(2020) #Find_by other columns in the table.
	#temp = College.find_or_create_by_name("yo")
	#temp = College.exists?(:name => "BPHC")
	#temp = College.where( :name => "BPHC")
	#temp.year=2222
	#temp.save #Commit the extra assignments apart from (create_by) to the client object(temp).
	#Rails.logger.debug "In associate tabbbbbbbbbbbbbbbbbbbbles: #{temp.inspect}"
	#@@tempo = College.includes(:student).all#This method is used to avoid (n+1) queries. Which decreases number of calculations for searching(That's slightlly unclear to me.)
	#Rails.logger.debug "For debuggggggggggggggggggggggginggggggggggg: #{College.first.student.inspect}"#Now calculations on tempo won't cause any (n+1) query issues.

end

end
