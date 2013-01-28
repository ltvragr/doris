module ProjectsHelper
	def set_status
    	params.merge!({:status => "undergrad"})
	end
end