class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_channel, only: [:show]

  # GET /apps/:bundle/users
  # GET /apps/:bundle/users.json
  def index
    @users = Event.where(:app => params[:bundle]).uniq.pluck(:user)

    attachments = Event.where(:user => @users, :type => "User", :subtype => "Info").group(:user).having('timestamp = MAX(timestamp)').pluck(:user, :id, :attachment, :payload)
    @icons = Hash[attachments.map{|att| [att[0], "#{att[1]}/#{att[2]}"]}]
    @names = Hash[attachments.map{|att|
      if jsonPayload = JSON.parse(att[3], :quirks_mode => true)
        if !jsonPayload["name"].blank?
          [att[0], jsonPayload["name"]]
        else
          nil
        end
      else
        nil
      end
      }]
  end

  # GET /apps/:bundle/users/:uuid/events
  # GET /apps/:bundle/users/:uuid/events.json
  def show
    @events = Event.where(:app => params[:bundle], :user => params[:user]).order('timestamp DESC').limit(100)
  end

  private

  def set_channel
    @channel = CGI.escape("#{params[:bundle]}-#{params[:user]}")
  end
end
