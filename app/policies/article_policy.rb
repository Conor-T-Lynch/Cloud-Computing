class ArticlePolicy < ApplicationPolicy
  def index?
    true  # Anyone can view the list of articles
  end

  def show?
    true  # Anyone can view an article
  end

  def create?
    user.present?  # Only logged-in users can create articles
  end

  def update?
    user.present? && record.user_id == user.id  # Only the owner can update their article
  end

  def destroy?
    user.present? && record.user_id == user.id  # Only the owner can destroy their article
  end
end
