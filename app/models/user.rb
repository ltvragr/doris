class User < ActiveRecord::Base
  rolify
  attr_accessible :email, :first_name, :last_name, :login, :status

  has_and_belongs_to_many :projects
  has_and_belongs_to_many :labs, join_table: 'labs_principles'

  def name
    first_name + " " + last_name
  end  
end
