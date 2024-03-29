# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)

    can [:show_shared, :show_accessible], [FlashcardSet, UserSentenceSet], {access: :shared}
    can [:show_specific, :show_accessible, :index], [LearningSession, FlashcardSet, UserSentenceSet], user_id: user.id
    can :manage, [FlashcardSet, UserSentenceSet], user_id: user.id
    can :manage, Flashcard, flashcard_set: {user_id: user.id}
    can :manage, UserSentence, user_sentence_set: {user_id: user.id}
    can [:show, :update], User, id: user.id

    if user.teacher
      can [:show_specific, :show_accessible], [FlashcardSet, UserSentenceSet], {access: :class, user_id: user.teacher.id}
    end

    return unless (user.teacher? || user.admin?)
    can [:show_specific, :show_accessible], LearningSession, {user_id: user.students.ids, learnable_type: 'FlashcardSet', learnable_id: FlashcardSet.class.pluck(:id)}
    can [:show_specific, :show_accessible], LearningSession, {user_id: user.students.ids, learnable_type: 'UserSentenceSet', learnable_id: UserSentenceSet.class.pluck(:id)}
    can [:show_specific, :show_accessible], [FlashcardSet, UserSentenceSet], {access: :class, user_id: user.students.ids}

    return unless user.admin?
    can [:show_specific, :show_accessible, :index], [LearningSession, FlashcardSet, UserSentenceSet]
    can [:show, :show_all, :update], User

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
