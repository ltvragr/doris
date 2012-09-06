class Project < ActiveRecord::Base
  attr_accessible :description, :end_date, :name, :start_date

  has_and_belongs_to_many :users
  has_and_belongs_to_many :labs
  
end
