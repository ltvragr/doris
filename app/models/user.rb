class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :login, :status

  has_and_belongs_to_many :projects

  has_and_belongs_to_many :labs

  def name
    first_name + " " + last_name
  end 

  def is_admin?
    true
  end

end
