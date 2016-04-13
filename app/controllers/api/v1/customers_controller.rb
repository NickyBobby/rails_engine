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
        respond_with Customer.find_by(customer_params)
      end

      def find_all
        respond_with Customer.where(customer_params)
      end

      def random
        respond_with Customer.all.sample
      end

      def invoices
        # customer = Customer.find(params[:id])
        respond_with customer.invoices
      end

      def transactions
        # customer = Customer.find(params[:id])
        respond_with customer.transactions
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
