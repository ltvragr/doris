class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :project
  # attr_accessible :title, :body
end
