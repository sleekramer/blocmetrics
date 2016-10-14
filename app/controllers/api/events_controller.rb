class API::EventsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_filter :set_access_control_headers

  def create
    begin
      registered_application = RegisteredApplication.find_by(url: request.env['HTTP_ORIGIN'])
      if registered_application == nil
        render json: { error: "Unregistered application" }, status: :unprocessable_entity
      elsif @event = registered_application.events.create!(event_params)
        render json: @event, status: :created
      else
        render json: {errors: @event.errors.full_messages}, status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordInvalid => invalid
      render json: { errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def preflight
    head 200
  end

  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Content-Type'
  end
  private

  def event_params
    params.require(:event).permit(:name)
  end
end
