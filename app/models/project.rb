class Project < ActiveRecord::Base
  attr_accessible   :description, :end_date, :name, :is_confirmed,
                    :start_date, :lab_tokens, :user_tokens

  has_and_belongs_to_many :users
  has_and_belongs_to_many :labs

  attr_reader :lab_tokens, :user_tokens

  searchable do 
    text :name, :description
  end

  def lab_tokens=(ids)
    self.lab_ids = ids.split(",")
  end

  def user_tokens=(ids)
    self.user_ids = ids.split(",")
  end

end
