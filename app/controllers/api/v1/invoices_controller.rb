module Api
  module V1
    class InvoicesController < ApiController
      respond_to :json, :xml

      def index
        respond_with Invoice.all
      end

      def show
        respond_with Invoice.find(params[:id])
      end

      def find
        # find stuff
      end

      def find_all
        # find all that match
      end

      def random
        respond_with Invoice.all.sample
      end
    end
  end
end
