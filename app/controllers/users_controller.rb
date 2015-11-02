class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_channel, only: [:show]
  # GET /apps/:bundle/users
  # GET /apps/:bundle/users.json
  def index
    @users = Event.where(:app => params[:bundle]).uniq.pluck(:user, :device)
  end

  def show
    @events = Event.where(:app => params[:bundle], :user => params[:user]).order('timestamp DESC').limit(100)
  end

  private

  def set_channel
    @channel = CGI.escape("#{params[:bundle]}-#{params[:user]}")
  end
end
