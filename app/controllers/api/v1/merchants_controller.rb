module Api
  module V1
    class MerchantsController < ApiController
      respond_to :json, :xml

      def index
        respond_with Merchant.all
      end

      def show
        respond_with Merchant.find(params[:id])
      end

      def find
        if merchant_params[:created_at]
          ct = DateTime.parse(params[:created_at].to_s)
          respond_with Merchant.find_by(created_at: ct)
        elsif merchant_params[:updated_at]
          cu = DateTime.parse(params[:updated_at].to_s)
          respond_with Merchant.find_by(updated_at: cu)
        else
          respond_with Merchant.find_by(merchant_params)
        end
      end

      def find_all
        if merchant_params[:created_at]
          ct = DateTime.parse(params[:created_at].to_s)
          respond_with Merchant.where(created_at: ct)
        elsif merchant_params[:updated_at]
          cu = DateTime.parse(params[:updated_at].to_s)
          respond_with Merchant.where(updated_at: cu)
        else
          respond_with Merchant.where(merchant_params)
        end
      end

      def random
        respond_with Merchant.all.sample
      end

      def items
        respond_with merchant.items
      end

      def invoices
        respond_with merchant.invoices
      end

      def most_revenue
        merchants = Merchant.all.sort_by do |merchant|
                     Invoice.where(merchant_id: merchant.id)
                            .joins(:invoice_items, :transactions)
                            .where("transactions.result = 'success'")
                            .sum("unit_price * quantity")
                          end
        top_merchants = merchants.reverse.take(params[:quantity].to_i)
        respond_with top_merchants
      end

      def most_items
        merchants = Merchant.all.sort_by do |merchant|
                      Invoice.where(merchant_id: merchant.id)
                             .joins(:invoice_items, :transactions)
                             .where("transactions.result = 'success'")
                             .sum(:quantity)
                    end
        top_merchants = merchants.reverse.take(params[:quantity].to_i)
        respond_with top_merchants
      end

      def revenue
        if params['date']
          date = DateTime.parse(params[:date])
          revenue_for_day = merchant.invoices.joins(:invoice_items, :transactions)
                                             .where("invoices.created_at = ?", date)
                                             .where("transactions.result = 'success'")
                                             .sum("unit_price * quantity")
          rev_day = { "revenue" => sprintf('%.02f', (revenue_for_day / 100.00)) }
          respond_with rev_day
        else
          merchant_revenue = merchant.invoices.joins(:invoice_items, :transactions).where("transactions.result = 'success'").sum("unit_price * quantity")
          m_rev = { "revenue" => sprintf('%.02f', (merchant_revenue / 100.00)) }
          respond_with m_rev
        end
      end

      def favorite_customer
        customer_id = merchant.invoices.joins(:invoice_items, :transactions)
                                       .where("transactions.result = 'success'")
                                       .group(:customer_id)
                                       .count.sort_by { |k,v| v }.reverse.first[0]
        respond_with Customer.find(customer_id)
      end

      def customers_with_pending_invoices
        customers = merchant.invoices.joins(:invoice_items, :transactions)
                                     .where("transactions.result = 'failed'")
                                     .group(:customer_id)
        respond_with customers
      end

      private

        def merchant_params
          params.permit(:id,
                        :name,
                        :created_at,
                        :updated_at)
        end

        def merchant
          Merchant.find(params[:id])
        end
    end
  end
end
