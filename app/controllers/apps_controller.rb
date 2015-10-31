class AppsController < ApplicationController
  skip_before_action :verify_authenticity_token

  # GET /apps/:bundle/users
  # GET /apps/:bundle/users.json
  def index
    @apps = Event.uniq.pluck(:app)
  end
end
