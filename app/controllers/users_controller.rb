class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  # GET /apps/:bundle/users
  # GET /apps/:bundle/users.json
  def index
    @users = Event.where(:app => params[:bundle]).uniq.pluck(:user)
  end

  def show
    @events = Event.where(:app => params[:bundle], :user => params[:user]).order('id DESC').limit(100)
  end
end
