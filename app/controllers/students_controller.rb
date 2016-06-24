class StudentsController < ApplicationController
  
  def do_queries
  @student = Student.all
  end

  def do_query
  @student = Student.all
  end

  def show
  	Rails.logger.debug "In StudentController show method , params are #{params.inspect}"
  	@stu = Student.find(params[:id])
  	#Rails.logger.debug"#{@stu.inspect}"
  	#@specific=Student.find(params[:id]) # Here params[:id] gives a string "1", not a integer, even then the search for id is successful here unlike in html.erb.file
	Rails.logger.debug "In show methoddddddddddd: #{@stu.inspect}"
	respond_to do |format|
	  	format.json do 
	  		render json: @stu.to_json
	  	end
	  	format.html do
	  	end
	end
  end

  def index
  	@student=Student.all
  	Rails.logger.debug "#{params.inspect}"
  	#Rails.logger.debug "#@student.inspect ssss"
  	#Rails.logger.debug"#{@student[2]}"
  end

  def new # Displays a form that enables user to input the data.
  end
  
  def create # Helps in saving the data that had been given from user.
  	#Rails.logger.debug "In StudentController create method: params are #{params.inspect}"
  	#temp = params["student"]
  	#Rails.logger.debug"Inn update methoddddddddddddddddd #{College.find(params["student"]["college_id"])[:id].inspect}"
  	#params["student"]["extended_sid"] = params["student"]["extended_sid"] <<
  	student = Student.new(params[:student])
  	#student.extended_sid = student.create_extended_sid_value
  	if student.save
  		redirect_to action: :new
  	end
=begin
	def book_params
	   params.require(:student).permit(:sid, :dept, :maths, :physics, :chemistry, :year)
	end
=end
   end

  def edit
	  #Rails.logger.debug "In StudentController edit method: params are #{params.inspect}"
	  @student = Student.find(params[:id])
	  #Rails.logger.debug "params[:id].inspect"
	  Rails.logger.debug "In edit methooooooooooooooodddddddddddddddd: #{@student.inspect} "
	  respond_to do |format|
	  	format.json do 
	  		render json: @student.to_json
	  	end
	  	format.html do
	  	end
	  end

  end

  def destroy
  	#Rails.logger.debug "In StudentController destroy method: params are #{params.inspect}"
  	#instance = Student.where( "sid = ? AND year =?",params[:stu_id],params[:year])
  	stud = Student.find(params[:id])
  	stud.destroy
  	#Student.find(params[:id] ).destroy
  	#Student.destroy(Student.where( :sid => params[:stu_id]).where(:year => params[:year]))
  	redirect_to action: :index
  end

  def update
  	#Rails.logger.debug "In StudentController update method: params are #{params.inspect}"
  	@student=Student.find(params[:id])
  	Rails.logger.debug " In update methodddddddddddddddddd: #{params.inspect}"
  	#status = @student.update_attributes(params["student"])

  	Rails.logger.debug "Testingggggggggggggggggggg erorrrrsssssssssss: #{@student.errors.inspect}"

  	respond_to do |format|
		if @student.update_attributes(params["student"])
	  		format.html {redirect_to student_path(@student), notice: "Student Updated"}
	  	else
	  		Rails.logger.debug "In erorrrrrrrrrrrrrrrr situtationnnnnnnnnnnnnn: #{@student.errors.inspect}"
	  		format.html {render action: :edit}
	  	end
	end
  	#@student.extended_sid = @student.create_extended_sid_value
  	#@student.save
  end

  def solution
  	Rails.logger.debug "Solution Debug"
  	Rails.logger.debug "#{params[:Group_by].inspect}"
  	results = Student.all
  	group_by_opt = params[:Group_by];
	group_by_result = group_by_fn(group_by_opt,results) if( group_by_opt == "ID" || group_by_opt == "Department" || group_by_opt == "Year" )
    temp = group_by_result.values
    sort_by_val = params[:Sort_by];
    sort_by_fn(sort_by_val,temp) if(sort_by_val == "Maths" || sort_by_val == "Physics" || sort_by_val == "Chemistry")
    @should_compare_val = params[:Diff];
	compare(results) if(@should_compare_val == "ID" || @should_compare_val == "Department")
	@show_total_val = params[:Total];
	display_total(results) if(@show_total_val == "True")
  end

  def average(grp_id,k)
		len = grp_id[k].length # Gives number of hashes in the value associated with a key.
		#Rails.logger.debug " In average method royyyyy #{@results.inspect}"
		#ails.logger.debug " In average method royyyyyyyyyyyyyyyyy  #{grp_id[k][0][:maths].inspect}"
		Rails.logger.debug " Testinnnnnnnnnnnnnnnnnnnnng brooooooo #{grp_id[k].inspect}"
		math_sum = 0;phy_sum = 0;chem_sum = 0 # Gets the sum of all the subjects for all the hashes in the value of a key.
		for i in 0..len-1
			math_sum = math_sum + (grp_id[k][i][:maths])
			phy_sum = phy_sum + (grp_id[k][i][:physics])
			chem_sum = chem_sum + (grp_id[k][i][:chemistry])
		end
		math_avg = (math_sum.to_f / len).round(2) # Calculating average for each key(multiple hashes in the values).
		phy_avg = (phy_sum.to_f / len).round(2)
		chem_avg = (chem_sum.to_f / len).round(2)
		return math_avg,phy_avg,chem_avg
	end

	def calc_total(grp_id,k)
		len = grp_id[k].length # Gives number of hashes in the value associated with a key.
		math_sum = 0
		phy_sum = 0
		chem_sum = 0 # Gets the sum of all the subjects for all the hashes in the value of a key.
		for i in 0..len-1
			math_sum = math_sum + (grp_id[k][i][:maths])
			phy_sum = phy_sum + (grp_id[k][i][:physics])
			chem_sum = chem_sum + (grp_id[k][i][:chemistry])
		end

		return math_sum,phy_sum,chem_sum
	end

	def group_by_fn(group_by,results)
		key_to_group = "sid" if( group_by == "ID"); # In the below line string has been converted into Symbol.
		key_to_group = "year" if( group_by == "Year")
		key_to_group = "dept" if( group_by == "Department")
			grp_id = results.group_by{|h| h[key_to_group.to_sym]} #Creatig a hash(grouping by) where values are array of hashes, where keys are value stored in Group_by variable.
			avg=Hash.new
			grp_id.each_key{|k|
				math_avg,phy_avg,chem_avg=average(grp_id,k)
				avg[k] = {:id=>k,:maths_avg=>math_avg,:phys_avg=>phy_avg,:chemi_avg=>chem_avg}
				
			} # Pushing hashes into a array of hashes is not known to me now, So, this is the lengthy way of doing that.	
			return avg # Saving the average values for each key, as they need to be sorted based on any chosen subject.

	end

	def sort_by_fn(sort_by_input,answ) # group_by_fn and sort_by_fn functions are linked, so group_by_fn have to be executed for sort_by_fn functiond to work.
		key_to_sort = "maths_avg" if(sort_by_input == "Maths"); # In the below line string has been converted into Symbol.
		key_to_sort = "phys_avg" if(sort_by_input == "Physics")
		key_to_sort = "chemi_avg" if(sort_by_input == "Chemistry")
			@sort_hash = answ.sort_by{|k| k[key_to_sort.to_sym]} # Sorting the array of hashes based on sort_by element.
			puts"ID\tMATHS\tPHYSICS\tCHEMISTRY"#Above, even without to_sym, it's working fine.
			@sort_hash.each do |k| # Iterating through array of hashes.
				puts" #{k[:id]}\t#{k[:maths_avg]}\t#{k[:phys_avg]}\t#{k[:chemi_avg]}"
			end
		#Rails.logger.debug "aaaaaaaaaaaaaaaaaaaa #{answ.inspect}"

	end

	def compare(results)
			#puts"Give the present year: "
			pre_year = "2016"
			#puts"Give the past_year:"
			past_year = "2015"
			@comp_pre_year = Hash.new
			@comp_past_year = Hash.new
			@comp_final = Hash.new
			if (@should_compare_val == "ID")
				diff_hash = results.group_by{|h| h[:year]} # Grouping the initial results based on year.
				@final = Hash.new # Which stores the final data containing present,past years and their differece data.
				Rails.logger.debug "In compare blockkkkkkkkkkkkkkkkkkkkkkk #{diff_hash.inspect}"
				pre_data = diff_hash[pre_year].group_by{|h| h[:sid]} # Grouping by present year.
				past_data = diff_hash[past_year].group_by{|h| h[:sid]} # Grouping by past year, to make id's as the keys.
				Rails.logger.debug "In compare block babbbbbbbbbbboooooo #{pre_data.inspect}"
				pre_data.each_key{|k| # Iterating through the keys(id's) in the present year.
					if(!past_data.key?(k)) # If "id"  is not present in past year, then default values are assigned to difference values.
						math_res = 100;phy_res = 100;chem_res = 100
						@final[k] = [{:year=>pre_year.to_i,:Matths=>pre_data[k][0][:maths],:Physs=>pre_data[k][0][:physics],:Chemm=>pre_data[k][0][:chemistry]},{:year=>past_year.to_i,:Matths=>0,:Physs=>0,:Chemm=>0},{:change=>"change",:Matths=>math_res,:Physs=>phy_res,:Chemm=>chem_res}]
						# Current, Past, Difference values,year in a sequence are passed onto final hash(where values are array of hashes,id's are keys).
					else # Here the ordinary cases(past id's exist)
						math_res = (((pre_data[k][0][:maths] - past_data[k][0][:maths]) * 100).to_f / past_data[k][0][:maths]).round(2)
						phy_res = (((pre_data[k][0][:physics] - past_data[k][0][:physics]) * 100).to_f / past_data[k][0][:physics]).round(2)
						chem_res = (((pre_data[k][0][:chemistry] - past_data[k][0][:chemistry]) * 100).to_f / past_data[k][0][:chemistry]).round(2)
						@final[k] = [{:year=>(pre_year.to_i),:Matths=>pre_data[k][0][:maths],:Physs=>pre_data[k][0][:physics],:Chemm=>pre_data[k][0][:chemistry]},{:year=>(past_year.to_i),:Matths=>past_data[k][0][:maths],:Physs=>past_data[k][0][:physics],:Chemm=>past_data[k][0][:chemistry]},{:change=>"change",:Matths=>math_res,:Physs=>phy_res,:Chemm=>chem_res}]
					
					end
				}
				#Rails.logger.debug "In Final Phase: #{@final.inspect}"
				puts"ID\tMATHS\tPHYSICS\tCHEMISTRY\t"
				@final.each_key{|k| # Iterating through the keys,printing all the asked for values.
					puts k.to_i
					puts "#{@final[k][0][:year]}\t#{@final[k][0][:Matths]}\t#{@final[k][0][:Physs]}\t#{@final[k][0][:Chemm]}"
					puts "#{@final[k][1][:year]}\t#{@final[k][1][:Matths]}\t#{@final[k][1][:Physs]}\t#{@final[k][1][:Chemm]}"
					puts "#{@final[k][2][:change]}\t#{@final[k][2][:Matths]}\t#{@final[k][2][:Physs]}\t#{@final[k][2][:Chemm]}"
				}
			else
				diff_hash = results.group_by{|h| h[:year]} 
				@final = Hash.new
				pre_data = diff_hash[pre_year].group_by{|h| h[:dept]}
				past_data = diff_hash[past_year].group_by{|h| h[:dept]}
				Rails.logger.debug "In eaaaaaaaalllllllllllllllllse block, #{pre_data.inspect}"
				pre_data.each_key{|k|
					len = pre_data[k].size
					Rails.logger.debug "In elllllllllllllllllssssssssssse block, #{pre_data["a1"][0][:maths].inspect}"
					math_sum = 0;phy_sum = 0; chem_sum = 0;
					for i in 0..len-1
						math_sum = math_sum + pre_data[k][i][:maths].to_f
						phy_sum = phy_sum + pre_data[k][i][:physics].to_f
						chem_sum = chem_sum + pre_data[k][i][:chemistry].to_f
					end
					@comp_pre_year[k] = {:maths=> (math_sum/len).round(2), :physics=> (phy_sum/len).round(2), :chemistry=>(chem_sum/len).round(2), :year=>pre_year }

					len = past_data[k].size
					math_sum = 0;phy_sum = 0; chem_sum = 0;
					for i in 0..len-1
						math_sum = math_sum + past_data[k][i][:maths].to_f
						phy_sum = phy_sum + past_data[k][i][:physics].to_f
						chem_sum = chem_sum + past_data[k][i][:chemistry].to_f
					end
					@comp_past_year[k] = {:maths=> (math_sum/len).round(2), :physics=> (phy_sum/len).round(2), :chemistry=>(chem_sum/len).round(2), :year=>past_year }
					Rails.logger.debug "In eeeeeeeeelllsssssssssse condition broooooooo #{@comp_past_year.inspect}" 
					Rails.logger.debug "In eeeeeeeeeelllsssssssssseeeee condition yooooooooo #{@comp_pre_year.inspect}"				
				}
				@comp_past_year.each_key {|k|
					math_avg_dept = (((@comp_pre_year[k][:maths] - @comp_past_year[k][:maths])*100).to_f / @comp_past_year[k][:maths]).round(2)
					phys_avg_dept = (((@comp_pre_year[k][:physics] - @comp_past_year[k][:physics])*100).to_f / @comp_past_year[k][:physics]).round(2)
					chem_avg_dept = (((@comp_pre_year[k][:chemistry] - @comp_past_year[k][:chemistry])*100).to_f / @comp_past_year[k][:chemistry]).round(2)
					@comp_final[k] = {:maths=> math_avg_dept, :physics=>  phys_avg_dept, :chemistry=> chem_avg_dept, :change=>"change"}
					Rails.logger.debug "In eeeeeeeeeelllsssssssssseeeee condition yooooooooo #{@comp_final[k].inspect}"
					Rails.logger.debug "In eeeeeeeeeelllsssssssssseeeee condition yooooooooo #{k.inspect}"
				}
			end		
	end

	def display_total(results)
		grp_id = results.group_by{|h| h[:year]} # Grouping by years.
			puts"Subjectwise totals of various subjects in the mentioned years are as follows: "
			puts"Year\tMaths\tPhysics\tChemistry"
			@total_year_wise = Hash.new
			@total_all_years = Hash.new
			math_total = 0;phy_total = 0;chem_total = 0; # Variables to store sum of subject scores for all the years.
			grp_id.each_key{|k| # Iterating through years(keys).
				math_sum,phy_sum,chem_sum=calc_total(grp_id,k)
				math_total = math_total + math_sum;phy_total = phy_total + phy_sum;chem_total = chem_total + chem_sum;#Getting
				@total_year_wise[k]= {:year => k,:maths => math_sum, :physics => phy_sum, :chemistry => chem_sum}
				puts "#{k}\t#{math_sum}\t #{phy_sum}\t#{chem_sum}" # Displaying the sum of the subject scores for a year.
			}
			#Rails.logger.debug "In display total pageroyyyyyyyyyyyyyyyyyyyy #{@total_year_wise.inspect}"
			key_to_sort = :year  #This two lines I had tried to get the years sorted.
			#@total_year_wise = @total_year_wise.sort_by{|k| @total_year_wise[k][key_to_sort.to_i]} # This is for the fact that- 
			#-the element is hash which can't be sorted based on values in hash, which itself is one of the values in the main hash.
			@total_all_years = {:year => "Total", :maths => math_total, :physics => phy_total, :chemistry => chem_total}
			puts"Grand total of sum of all the subjects in the given years is: "
			puts"Total\tMaths\tPhysics\tChemistry"
			puts"\t#{math_total}\t#{phy_total}\t#{chem_total}" # This prints the Grand total of all the subject scores for all the years.		
	end

end
