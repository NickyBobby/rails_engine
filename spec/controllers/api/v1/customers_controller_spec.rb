require 'rails_helper'

RSpec.describe Api::V1::CustomersController do
  describe "GET index", type: :controller do
    it "returns all customers" do
      customer = FactoryGirl.create(:customer)
      get :index, format: :json

      items = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
      expect(Customer.count).to eq(1)
      expect(Customer.last.first_name).to eq("Nick")
    end
  end

  describe "GET #show", type: :controller do
    it "returns one customer" do
      customer = FactoryGirl.create(:customer)
      get :show, id: customer.id, format: :json

      item = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #find", type: :controller do
    it "return first customer to match query" do
      customer = FactoryGirl.create(:customer)
      get :find, id: customer.id, format: :json

      item = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #random", type: :controller do
    it "returns a random customer" do
      FactoryGirl.create_list(:customer, 2)

      get :random, format: :json

      expect(response).to be_success
    end
  end

  describe "GET #invoices", type: :controller do
    it "returns associated invoices" do
      customer = FactoryGirl.create(:customer)

      get :invoices, id: customer.id, format: :json

      expect(response).to be_success
    end
  end

  describe "GET #transactions", type: :controller do
    it "returns associated transactions" do
      customer = FactoryGirl.create(:customer)

      get :transactions, id: customer.id, format: :json

      expect(response).to be_success
    end
  end

  describe "GET #find", type: :controller do
    before(:each) do
      @customer = FactoryGirl.create(:customer, first_name: "Nick", created_at: "2016-03-14 14:53:59 UTC")
      FactoryGirl.create(:customer)
      FactoryGirl.create(:customer)
    end

    it "returns the correct customer with the find and id parameter" do
      get :find, id: @customer.id, format: :json
      customer_response = json_response
      expect(customer_response[:first_name]).to eq @customer.first_name
      expect(customer_response[:last_name]).to eq @customer.last_name
      expect(response).to be_success
    end

    it "returns the correct customer with the find and name parameter" do
      get :find, first_name: @customer.first_name, format: :json
      customer_response = json_response
      expect(customer_response[:first_name]).to eq @customer.first_name
      expect(customer_response[:last_name]).to eq @customer.last_name
      expect(response).to be_success
    end

    it "returns the correct customer with find and created_at" do
      get :find, created_at: @customer.created_at, format: :json
      customer_response = json_response
      expect(customer_response[:first_name]).to eq @customer.first_name
      expect(customer_response[:last_name]).to eq @customer.last_name
      expect(response).to be_success
    end
  end

  describe "GET #find_all", type: :controller do
    before(:each) do
      @customer1 = FactoryGirl.create(:customer, first_name: "Mike")
      @customer2 = FactoryGirl.create(:customer, first_name: "Mike")
      @customer3 = FactoryGirl.create(:customer, first_name: "Frank")
    end

    it "returns the correct customer with the find and id parameter" do
      get :find_all, format: :json, first_name: "Mike"
      customer_response = json_response
      expect(customer_response.count).to eq 2
      expect(customer_response.first[:id]).to eq @customer1.id
      expect(customer_response.last[:id]).to eq @customer2.id
      expect(response).to be_success
    end
  end

  describe "GET #favorite_merchant", type: :controller do
    it "returns the merchant's favorite customer" do
      merchant = FactoryGirl.create(:merchant, name: "Mike")
      customer = FactoryGirl.create(:customer)
      invoice = FactoryGirl.create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      transaction = FactoryGirl.create(:transaction, invoice_id: invoice.id, result: 'success')
      # invoice_item = FactoryGirl.create(:invoice_item, invoice_id: invoice.id)

      get :favorite_merchant, id: customer.id, format: :json

      expect(response).to be_success
    end
  end

end
