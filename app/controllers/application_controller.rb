class ApplicationController < ActionController::API
  include RailsJwtAuth::AuthenticableHelper
  include RailsJwtAuth::ParamsHelper

  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from RailsJwtAuth::NotAuthorized, with: :render_not_authorized_response

  private

  def render_unprocessable_entity_response(exception)
    render(json: { message: 'Validation Failed', errors: record_errors(exception.record) }, status: 422)
  end

  def render_not_found_response(exception)
    render(json: { error: exception.message }, status: 404)
  end

  def render_not_authorized_response
    render(json: { error: 'Unauthorized User' }, status: 401)
  end

  def registration_create_params
    params.require(RailsJwtAuth.model_name.underscore).permit(RailsJwtAuth.auth_field_name, :password,
                                                              :password_confirmation, :full_name)
  end

  def record_errors(record)
    record.errors.messages.map do |field, error_messages|
      { resource: record.class.to_s, field: field.to_s, message: error_messages.join(', ') }
    end
  end
end
