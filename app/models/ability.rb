class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new #guest user (not logged in)
    puts user.new_record?
    if (user.new_record? == false && user.has_role?(:admin))
        can :manage, :all
    else
        can :read, :all
        can :create, User
        if user.has_role? :undergrad
            can [:update, :edit], User do |user_object|
                user_object == user
            end
            can :create, Project
            can [:update, :edit, :destroy], Project do |project|
                project.try(:users).include? user
            end
            can :logout, User
        end
        if user.has_role? :pi
            can [:update, :edit], User do |user_object|
                user_object == user
            end
            can :create, Lab
            can [:update, :edit, :destroy], Lab do |lab|
                lab.try(:user).include? user
            end
            can :logout, User
        end
    end
  end
end