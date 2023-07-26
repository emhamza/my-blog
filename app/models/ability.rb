class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Post, public: true
    can :read, Comment, public: true

    # user can read their own posts
    retrun unless user.present?

    can(:read, Post, user:)
    can :destroy, Post.where(author_id: user.id)

    can(:read, Comment, user:)
    can :destroy, Comment.where(author_id: user.id)

    return unless user.role == 'admin' # permission for admins

    can :destroy, post
    can :destroy, Comment
  end
end
