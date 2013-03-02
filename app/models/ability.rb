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
            can [:update, :edit], Project do |project|
                project.try(:users).include? user
            end
            can :add_self_to_project, Project do |project|
                not project.try(:users).include? user
            end
            can :logout, User
            can [:request, :create], Lab
        end
        if user.status == "pi"
            can [:update, :edit], User do |user_object|
                user_object == user
            end
            can :create, Project
            can [:create, :confirm, :update, :edit, :modify_users_on_project], Project do |project|
                project.labs.each {|lab| lab.try(:principles).include? user}
            end
            if user.labs.empty?          # limit one lab per PI
                can :create, Lab 
            end
            can [:update, :edit, :destroy, :approve], Lab do |lab|
                lab.try(:principles).include? user
            end
            can :logout, User
        end
    end
  end
end