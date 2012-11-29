class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new #guest user (not logged in)
    if user.has_role? :admin
        can :manage, :all
    else
        can :read, :all
        if user.has_role? :undergrad
            can [:update, :edit], User do |user_object|
                user_object == user
            end
            can :create, Project
            can [:update, :edit], Project do |project|
                project.try(:user) == user
            end
            can :logout, User
        end
        if user.has_role? :pi
            can [:update, :edit], User do |user_object|
                user_object == user
            end
            can :create, Lab
            can [:update, :edit], Lab do |lab|
                lab.try(:user) == user
            end
            can :logout, User
        end
    end
  end
end