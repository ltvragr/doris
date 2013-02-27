class UserMailer < ActionMailer::Base
  default from: "doris@yale.edu"

  def lab_req_email(user)
  	@user = user
  	mail(:to => @user.email, :subject => "Yale: Please confirm your lab on Doris")
  end

  def project_confirm_email(user)
  	@user = user
  	mail(:to => @user.email, :subject => "Yale: Please confirm a project on Doris")
  end
end
