module Api
  module V1
    class TransactionsController < ApiController
      respond_to :json, :xml

      def index
        respond_with Transaction.all
      end

      def show
        respond_with Transaction.find(params[:id])
      end

      def find
        # find stuff
      end

      def find_all
        # find all that match
      end

      def random
        respond_with Transaction.all.sample
      end
    end
  end
end
