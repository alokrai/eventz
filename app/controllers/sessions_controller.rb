# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to (session[:intended_url] || events_path),
                  notice: "welcome back #{user.name}!"
      session[:intended_url] = nil
    else
      flash.now[:alert] = 'Invalid username or password'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to events_path
  end
end
