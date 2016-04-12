module Api
  module V1
    class CustomersController < ApiController
      respond_to :json, :xml

      def index
        respond_with Customer.all
      end

      def show
        respond_with Customer.find(params[:id])
      end

      def find
        binding.pry
        if Customer.find(params[:id])
          respond_with Customer.find(params[:id])
        elsif Customer.find_by(params[:first_name])
          respond_with Customer.find_by(params[:first_name])
        elsif Customer.find_by(params[:last_name])
          respond_with Customer.find_by(params[:last_name])
        end
        # find stuff
      end

      def find_all
        # find all that match
      end

      def random
        respond_with Customer.all.sample
      end
    end
  end
end
