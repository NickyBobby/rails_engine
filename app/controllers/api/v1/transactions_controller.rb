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
        if transaction_params[:created_at]
          ct = DateTime.parse(params[:created_at].to_s)
          respond_with Transaction.find_by(created_at: ct)
        elsif transaction_params[:updated_at]
          cu = DateTime.parse(params[:updated_at].to_s)
          respond_with Transaction.find_by(updated_at: cu)
        else
          respond_with Transaction.find_by(transaction_params)
        end
      end

      def find_all
        if transaction_params[:created_at]
          ct = DateTime.parse(params[:created_at].to_s)
          respond_with Transaction.where(created_at: ct)
        elsif transaction_params[:updated_at]
          cu = DateTime.parse(params[:updated_at].to_s)
          respond_with Transaction.where(updated_at: cu)
        else
          respond_with Transaction.where(transaction_params)
        end
      end

      def random
        respond_with Transaction.all.sample
      end

      def invoice
        respond_with transaction.invoice
      end

      private

        def transaction_params
          params.permit(:id,
                        :invoice_id,
                        :credit_card_number,
                        :result,
                        :created_at,
                        :updated_at)
        end

        def transaction
          Transaction.find(params[:id])
        end
    end
  end
end
