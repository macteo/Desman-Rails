class AppsController < ApplicationController
  skip_before_action :verify_authenticity_token

  # GET /apps/:bundle/users
  # GET /apps/:bundle/users.json
  def index
    @apps = Event.uniq.pluck(:app)
    attachments = Event.where(:type => "Desman.Application", :subtype => "Info").where("attachment IS NOT NULL").having('timestamp = MAX(timestamp)').group(:app, :timestamp).pluck(:app, :id, :attachment, :payload)
    @icons = Hash[attachments.map{|att| [att[0], "#{att[1]}/#{att[2]}"]}]
    @names = Hash[attachments.map{|att|
      begin
        if jsonPayload = JSON.parse(att[3], :quirks_mode => true)
          if !jsonPayload["name"].blank?
            [att[0], jsonPayload["name"]]
          else
            nil
          end
        else
          nil
        end
      rescue Exception => e
        nil
      end
      }]
  end
end
