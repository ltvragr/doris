class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new #guest user (not logged in)
    puts user.new_record?
    if (user.new_record? == false && user.status == "admin")
        can :manage, :all
        can :view, Project
        can :modify_login, User
    else
        can :read, :all
        if user.status == "undergrad"
            can [:update, :edit], User do |user_object|
                user_object == user
            end
            can :create, Project
            can [:update, :edit, :destroy], Project do |project|
                project.try(:users).include? user
            end
            can :logout, User
        end
        if user.status == "pi"
            can [:update, :edit], User do |user_object|
                user_object == user
            end
            can :create, Lab
            can [:update, :edit, :destroy, :authorize_lab], Lab do |lab|
                lab.try(:users).include? user
            end
            can :logout, User
        end
    end
  end
end