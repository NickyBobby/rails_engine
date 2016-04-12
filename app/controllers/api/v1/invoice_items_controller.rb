module Api
  module V1
    class InvoiceItemsController < ApiController
      respond_to :json, :xml

      def index
        respond_with InvoiceItem.all
      end

      def show
        respond_with InvoiceItem.find(params[:id])
      end

      def find
        # find stuff
      end

      def find_all
        # find all that match
      end

      def random
        respond_with InvoiceItem.all.sample
      end
    end
  end
end
