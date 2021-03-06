class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def login
    name = params[:username]
    @user = User.find_by(username: name)

    if @user
      flash[:success] = "Successfully logged in as #{name}"
      session[:user_id] = @user.id
      redirect_to root_path
    else
      @user = User.new(username: name)

      if @user.save
        flash[:success] = "Successfully created new user #{name}"
        session[:user_id] = @user.id
        redirect_to root_path
      else
        flash.now[:error] = "Something went wrong, could not create user #{name}"
        render :new, status: :bad_request
      end

    end
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_to root_path
  end
end
