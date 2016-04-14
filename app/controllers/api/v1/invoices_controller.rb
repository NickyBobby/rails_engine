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
        if invoice_params[:created_at]
          ct = DateTime.parse(params[:created_at].to_s)
          respond_with Invoice.find_by(created_at: ct)
        elsif invoice_params[:updated_at]
          cu = DateTime.parse(params[:updated_at].to_s)
          respond_with Invoice.find_by(updated_at: cu)
        else
          respond_with Invoice.find_by(invoice_params)
        end
      end

      def find_all
        if invoice_params[:created_at]
          ct = DateTime.parse(params[:created_at].to_s)
          respond_with Invoice.where(created_at: ct)
        elsif invoice_params[:updated_at]
          cu = DateTime.parse(params[:updated_at].to_s)
          respond_with Invoice.where(updated_at: cu)
        else
          respond_with Invoice.where(invoice_params)
        end
      end

      def random
        respond_with Invoice.all.sample
      end

      def transactions
        respond_with invoice.transactions
      end

      def invoice_items
        respond_with invoice.invoice_items
      end

      def items
        respond_with invoice.items
      end

      def customer
        respond_with invoice.customer
      end

      def merchant
        respond_with invoice.merchant
      end

      private

        def invoice_params
          params.permit(:id,
                        :customer_id,
                        :merchant_id,
                        :status,
                        :created_at,
                        :updated_at)
        end

        def invoice
          Invoice.find(params[:id])
        end
    end
  end
end
