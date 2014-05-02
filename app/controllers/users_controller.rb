# coding: utf-8
# 

class UsersController < ApplicationController

  def index
    do_and_respond do 
    end
  end

  def show
    do_and_respond(:show) do 
    end
  end

  def new
    puts ["new", params, @current_user]
    return edit if @current_user
    do_and_respond(:new) do
      @current_user = User.new
      @object = params[:object]
    end
  end
  
  def edit
    puts ["edit", params, @current_user]
    do_and_respond(:edit, :show) do
      @object = params[:object]
    end
  end
  
  def create
    puts ["create", params, @current_user]
    do_and_respond(:show) do
      puts params[:user]
      @current_user = User.where(User.name_without_accent(user_params)).first_or_create!(user_params)
    end
  end
  
  def update
    puts ["update", params, @current_user]
    do_and_respond(:show) do
      @current_user.update_attributes!(user_params)
    end
  end
  
  def authenticate
    puts params[:password]
    @authenticated = "authentification de premier niveau" if User.check_password(params[:password])
    do_and_respond(:index) do
    end
  end

private
  def user_params
    params.require(:user).permit!
  end
end