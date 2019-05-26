# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
      if user.admin?  # additional permissions for administrators
        can :manage, Event
        can :manage, User
        can :manage, UserTicket
        can :manage, Ticket
        can :manage, Place

      else
        can :read, Event
        can :read, User
        can :read, UserTicket
        can :read, Ticket
        can :read, Place
      end
  end
end
