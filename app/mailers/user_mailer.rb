class UserMailer < ActionMailer::Base
  default from: "doris@yale.edu"

  def lab_req_email(user)
  	@user = user
  	mail(:to => user.email, :subject => "Please Confirm a Lab on Doris")
  end
end
