class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :login, :status
end
