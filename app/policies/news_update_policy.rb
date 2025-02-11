# frozen_string_literal: true

class NewsUpdatePolicy < ApplicationPolicy
  def index?
    user.is_admin?
  end

  def create?
    user.is_admin?
  end

  def update?
    user.is_admin?
  end

  def permitted_attributes
    [:message, :duration, :duration_in_days, :is_deleted]
  end
end
