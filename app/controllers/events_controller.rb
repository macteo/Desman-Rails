class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token
  before_action :authenticate, only: [:create]

  # GET /events
  # GET /events.json
  def index
    @events = Event.order('timestamp DESC').limit(100)
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    if !params["event"]["payload"].is_a?(String)
      @event.payload = params["event"]["payload"].to_json
    end

    if params["event"]["timestamp"]
      @event.timestamp = Time.at(params["event"]["timestamp"].to_f)
    end

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    if !params["event"]["payload"].is_a?(String)
      @event.payload = params["event"]["payload"].to_json
    end

    if params["event"]["timestamp"]
      @event.timestamp = Time.at(params["event"]["timestamp"].to_f)
    end

    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:type, :subtype, :timestamp, :uuid, :user, :app, :payload, :attachment, :attachment_cache).tap do |whitelisted|
        whitelisted[:payload] = params[:event][:payload]
      end
    end

    def authenticate
    authenticate_or_request_with_http_token do  |token, options|
      app = APPS_AUTH[params[:app]]
      if app
        logger.info "------- Token " #{token}
        # logger.info "------- App #{app}"
        if app["token"] && app["token"] == token
          logger.info "Authenticated"
        else
          render :json => {:error => "Unauthorized"}.to_json, :status => 401
          return
        end
      else
        render :json => {:error => "app not found"}.to_json, :status => 404
        return
      end
    end
  end
end
