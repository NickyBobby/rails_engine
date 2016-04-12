module Api
  module V1
    class MerchantsController < ApiController
      respond_to :json, :xml

      def index
        respond_with Merchant.all
      end

      def show
        respond_with Merchant.find(params[:id])
      end

      def find
        # find stuff
      end

      def find_all
        # find all that match
      end

      def random
        respond_with Merchant.all.sample
      end
    end
  end
end
