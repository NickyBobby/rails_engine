module Api
  module V1
    class CustomersController < ApiController
      respond_to :json

      def index
        respond_with Customer.all
      end

      def show
        respond_with Customer.find(params[:id])
      end

      def find
        if customer_params[:created_at]
          ct = DateTime.parse(params[:created_at].to_s)
          respond_with Customer.find_by(created_at: ct)
        elsif customer_params[:updated_at]
          cu = DateTime.parse(params[:updated_at].to_s)
          respond_with Customer.find_by(updated_at: cu)
        else
          respond_with Customer.find_by(customer_params)
        end
      end

      def find_all
        if customer_params[:created_at]
          ct = DateTime.parse(params[:created_at].to_s)
          respond_with Customer.where(created_at: ct)
        elsif customer_params[:updated_at]
          cu = DateTime.parse(params[:updated_at].to_s)
          respond_with Customer.where(updated_at: cu)
        else
          respond_with Customer.where(customer_params)
        end
      end

      def random
        respond_with Customer.all.sample
      end

      def invoices
        respond_with customer.invoices
      end

      def transactions
        respond_with customer.transactions
      end

      def favorite_merchant
        merchant_id = customer.invoices.joins(:transactions)
                         .where("result = 'success'")
                         .group(:merchant_id).count
                         .sort_by { |key, value| value }
                         .reverse.first.first
        respond_with Merchant.find(merchant_id)
      end

      private

        def customer_params
          params.permit(:id,
                        :first_name,
                        :last_name,
                        :created_at,
                        :updated_at)
        end

        def customer
          Customer.find(params[:id])
        end
    end
  end
end
