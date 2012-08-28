class Lab < ActiveRecord::Base
  attr_accessible :description, :name, :url

  has_and_belongs_to_many :projects
end
