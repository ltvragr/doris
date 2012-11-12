class Project < ActiveRecord::Base
  attr_accessible :description, :end_date, :name, :start_date, :lab_tokens

  has_and_belongs_to_many :users
  has_and_belongs_to_many :labs

  attr_reader :lab_tokens

  def lab_tokens=(ids)
    self.lab_ids = ids.split(",")
  end

end
