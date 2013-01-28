module LabsHelper
	def set_status
    	params.merge!({:status => "pi"})
	end
end
