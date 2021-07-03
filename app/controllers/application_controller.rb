# frozen_string_literal: true

class ApplicationController < ActionController::Base

  private

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def require_signin
    unless current_user
      session[:intended_url] = request.url
      redirect_to new_session_url, alert: 'please signin'
    end
  end

  def current_user?(user)
    current_user == user
  end

  def require_admin
    redirect_to events_url, alert: 'unauthorized access' unless current_user.admin?
  end

  def current_user_admin?
    current_user&.admin
  end

  helper_method :current_user, :current_user?, :current_user_admin?
end
