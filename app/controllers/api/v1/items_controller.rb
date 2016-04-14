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
        if item_params[:created_at]
          ct = DateTime.parse(params[:created_at].to_s)
          respond_with Item.find_by(created_at: ct)
        elsif item_params[:updated_at]
          cu = DateTime.parse(params[:updated_at].to_s)
          respond_with Item.find_by(updated_at: cu)
        else
          respond_with Item.find_by(item_params)
        end
      end

      def find_all
        if item_params[:created_at]
          ct = DateTime.parse(params[:created_at].to_s)
          respond_with Item.where(created_at: ct)
        elsif item_params[:updated_at]
          cu = DateTime.parse(params[:updated_at].to_s)
          respond_with Item.where(updated_at: cu)
        else
          respond_with Item.where(item_params)
        end
      end

      def random
        respond_with Item.all.sample
      end

      def invoice_items
        respond_with item.invoice_items
      end

      def merchant
        respond_with item.merchant
      end

      private

        def item_params
          params.permit(:id,
                        :name,
                        :description,
                        :unit_price,
                        :merchant_id,
                        :created_at,
                        :updated_at)
        end

        def item
          Item.find(params[:id])
        end
    end
  end
end
