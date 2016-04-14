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
        if invoice_items_params[:created_at]
          ct = DateTime.parse(params[:created_at].to_s)
          respond_with InvoiceItem.find_by(created_at: ct)
        elsif invoice_items_params[:updated_at]
          cu = DateTime.parse(params[:updated_at].to_s)
          respond_with InvoiceItem.find_by(updated_at: cu)
        elsif invoice_items_params[:unit_price]
          unit_price = (invoice_items_params[:unit_price].to_f * 100).to_i
          respond_with InvoiceItem.find_by(unit_price: unit_price)
        else
          respond_with InvoiceItem.find_by(invoice_items_params)
        end
      end

      def find_all
        if invoice_items_params[:created_at]
          ct = DateTime.parse(params[:created_at].to_s)
          respond_with InvoiceItem.where(created_at: ct)
        elsif invoice_items_params[:updated_at]
          cu = DateTime.parse(params[:updated_at].to_s)
          respond_with InvoiceItem.where(updated_at: cu)
        elsif invoice_items_params[:unit_price]
          unit_price = (invoice_items_params[:unit_price].to_f * 100).to_i
          respond_with InvoiceItem.where(unit_price: unit_price)
        else
          respond_with InvoiceItem.where(invoice_items_params)
        end
      end

      def random
        respond_with InvoiceItem.all.sample
      end

      def invoice
        respond_with invoice_item.invoice
      end

      def item
        respond_with invoice_item.item
      end

      private

        def invoice_items_params
          params.permit(:id,
                        :item_id,
                        :invoice_id,
                        :quantity,
                        :unit_price,
                        :created_at,
                        :updated_at)
        end

        def invoice_item
          InvoiceItem.find(params[:id])
        end
    end
  end
end
