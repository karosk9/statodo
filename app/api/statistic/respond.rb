module Statistic
  class Respond < Grape::API

    version 'v1', using: :path
    format :json

    helpers do
      def set_random_response
        random_response = rand(1..4)
        return error!({ error: 'unexpected error', detail: 'Internal Server Error' }, 500) if random_response == 1
        return error!({ error: 'record_not_found', detail: 'Record not found' }, 404) if random_response == 2
        return long_request_processing if random_response == 3
        ok_response
      end

      def long_request_processing
        sleep 120
        ok_response
      end

      def ok_response
        {
          user_email: params[:user_email],
          task_id: params[:task_id]
        }
      end
    end

    resource :statistic do
      params do
        requires :task_id, type: Integer
        requires :user_email, type: String
      end

      get :respond do
        set_random_response
      end
    end
  end
end
