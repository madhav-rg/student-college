namespace :my_namespace do
	
	desc "Updating all Extended_Sid attributes of the Student  objects."
	task :update_extended_sid => :environment do
		puts "In my_namespaceeeeeeeeee: "
		#puts Student.all.inspect
		Student.all.each do |k|
		puts "In my_namespaceeeeeeeeeee taskkkkkkkkk: "	
		Rails.logger.debug "In my_namespaceeeeeeeeeeee: #{k.sid.inspect}"
		 k.extended_sid = k.create_extended_sid_value	
		 k.save
		end
		
	end
end
