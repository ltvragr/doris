class Project < ActiveRecord::Base
  attr_accessible   :description, :end_date, :name, :is_confirmed,
                    :start_date, :lab_tokens, :user_tokens, :tag_list, :tag_tokens

  has_and_belongs_to_many :users
  has_and_belongs_to_many :labs

  has_many :taggings
  has_many :tags, through: :taggings

  attr_reader :lab_tokens, :user_tokens, :tag_tokens

  searchable do 
    text :name, :description
  end

  def lab_tokens=(ids)
    self.lab_ids = ids.split(",")
  end

  def user_tokens=(ids)
    self.user_ids = ids.split(",")
  end

  def tag_tokens=(names)
    self.tags = names.split(",").map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end

  def self.tagged_with(name)
    if tag = Tag.where(name: name).first
      return tag.projects
    end
    else
      return nil
  end

  def self.tag_counts
    Tag.select("tags.*, count(taggings.tag_id) as count").joins(:taggings).group("taggings.tag_id")
  end

  def tag_list
    tags.map(&:name).join(", ")
  end

  def tag_list=(names)
    self.tags = names.split(",").map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end
end