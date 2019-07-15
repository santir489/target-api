module Api
  module V1
    class ApiController < ActionController::API
      include Concerns::ActAsApiRequest
      include DeviseTokenAuth::Concerns::SetUserByToken

      rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid

      def render_record_invalid(exception)
        render json: { errors: exception.record.errors.as_json }, status: :bad_request
      end
    end
  end
end
