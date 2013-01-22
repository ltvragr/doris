class Lab < ActiveRecord::Base
  attr_accessible :description, :name, :url, :is_authorized, :user_tokens

  has_and_belongs_to_many :projects

  has_many :users, through: :projects

  attr_reader :user_tokens

  def user_tokens=(ids)
    self.user_ids = ids.split(",")
  end

end
