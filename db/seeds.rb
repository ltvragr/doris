# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'ffaker'

#Method for prompting the user for the number of records per model they want to seed into the database.
def ask_for_records(model)
  STDOUT.puts "\nHow many #{model} records would you like to generate? (please enter a number)"
  STDIN.gets.chomp.to_i
end

#Random Time
def time_rand(from = 0.0, to = Time.now, length = 0)
  range = to.to_f - from.to_f

  if range > length.to_f
    range = length.to_f
  end

  Time.at(from + rand * range)
end

#Random object that is used throughout for generating fake data that Faker can't
r = Random.new

####################
#Seed Admin user
####################
if User.all.empty?  
  USER_ATTRS = [:first_name, :last_name, :email, :login, :status]
  user_data = {}
  STDOUT.puts "We need to create an account for you first."  
    USER_ATTRS.each do |a|
      STDOUT.puts a.to_s  
      user_data[a] = STDIN.gets.chomp
    end
  
  user = User.create!(user_data)
  user.add_role "admin"
  user.add_role "undergrad"
  user.save!
end


####################
#Seed other users
####################
entered_num = ask_for_records("User")

if entered_num.integer? && entered_num > 0
  users = entered_num.times.map do
    User.create do |u|
      u.first_name =Faker::Name.first_name
      u.last_name =Faker::Name.last_name
      u.email =Faker::Internet.email
      u.login = (0...3).map{65.+(rand(25)).chr}.join.downcase + r.rand(2..99).to_s
      u.status = "undergrad"
    end
  end
  STDOUT.puts "\n#{entered_num} records successfully created!"
  users << User.first
else
  STDOUT.puts "\nPlease enter a whole number greater than 0."
  entered_num = STDIN.gets.chomp.to_i
end

####################
#Seed Labs
####################
entered_num = ask_for_records("Labs")

if entered_num.integer? && entered_num > 0
  labs = entered_num.times.map do
    Lab.create do |l|
      l.name =Faker::Name.last_name + "'s Lab"
      l.description =Faker::Company.catch_phrase
      l.url = Faker::Internet.email
    end
  end
  STDOUT.puts "\n#{entered_num} records successfully created!"
else
  STDOUT.puts "\nPlease enter a whole number greater than 0."
  entered_num = STDIN.gets.chomp.to_i
end

####################
#Seed Projects
####################
entered_num = ask_for_records("Projects")

if entered_num.integer? && entered_num > 0
  projects = entered_num.times.map do
    Project.create! do |p|
      p.name = Faker::Lorem.words(6)
      p.description = Faker::Lorem.sentences(3)
      p.start_date = Date.yesterday  #time_rand.to_date
      p.end_date = Date.tomorrow #p.start_date + rand(300).days
      p.users = User.all.sample(5)
      p.labs = Lab.all.sample(rand(2))
      puts p.save!
    end
  end
  STDOUT.puts "\n#{entered_num} records successfully created!"
else
  STDOUT.puts "\nPlease enter a whole number greater than 0."
  entered_num = STDIN.gets.chomp.to_i
end
