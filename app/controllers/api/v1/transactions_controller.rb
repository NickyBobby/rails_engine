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
        respond_with Transaction.find_by(transaction_params)
      end

      def find_all
        respond_with Transaction.where(transaction_params)
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
