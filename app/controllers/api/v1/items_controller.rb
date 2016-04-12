module Api
  module V1
    class ItemsController < ApiController
      respond_to :json, :xml

      def index
        respond_with Item.all
      end

      def show
        respond_with Item.find(params[:id])
      end

      def find
        # find stuff
      end

      def find_all
        # find all that match
      end

      def random
        respond_with Item.all.sample
      end
    end
  end
end
