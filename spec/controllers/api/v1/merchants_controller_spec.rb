require 'rails_helper'

RSpec.describe Api::V1::MerchantsController do
  describe "GET index", type: :controller do
    it "returns all merchants" do
      merchant = FactoryGirl.create(:merchant)
      get :index, format: :json

      items = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
      expect(Merchant.count).to eq(1)
      expect(Merchant.last.name).to eq("Macy's")
    end
  end

  describe "GET #show", type: :controller do
    it "returns one merchant" do
      merchant = FactoryGirl.create(:merchant)
      get :show, id: merchant.id, format: :json

      item = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #find", type: :controller do
    it "return first merchant to match query" do
      merchant = FactoryGirl.create(:merchant)
      get :find, id: merchant.id, format: :json

      item = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #random", type: :controller do
    it "returns a random merchant" do
      FactoryGirl.create_list(:merchant, 2)

      get :random, format: :json

      expect(response).to be_success
    end
  end

  describe "GET #items", type: :controller do
    it "return all associated items" do
      merchant = FactoryGirl.create(:merchant)
      get :items, id: merchant.id, format: :json

      item = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #find_all", type: :controller do
    before(:each) do
      @merchant1 = FactoryGirl.create(:merchant, name: "Mike")
      @merchant2 = FactoryGirl.create(:merchant, name: "Mike")
      @merchant3 = FactoryGirl.create(:merchant, name: "Frank")
    end

    it "returns the correct merchant with the find and id parameter" do
      get :find_all, format: :json, name: "Mike"
      merchant_response = json_response
      expect(merchant_response.count).to eq 2
      expect(merchant_response.first[:id]).to eq @merchant1.id
      expect(merchant_response.last[:id]).to eq @merchant2.id
      expect(response).to be_success
    end
  end

  describe "GET #favorite_customer", type: :controller do
    it "returns the merchant's favorite customer" do
      merchant = FactoryGirl.create(:merchant, name: "Mike")
      customer = FactoryGirl.create(:customer)
      invoice = FactoryGirl.create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      transaction = FactoryGirl.create(:transaction, invoice_id: invoice.id, result: 'success')
      invoice_item = FactoryGirl.create(:invoice_item, invoice_id: invoice.id)

      get :favorite_customer, id: merchant.id, format: :json

      expect(response).to be_success
    end
  end

  describe "GET #most_revenue", type: :controller do
    it "returns the merchant(s) with the most revenue" do
      merchant = FactoryGirl.create(:merchant, name: "Mike")
      customer = FactoryGirl.create(:customer)
      invoice = FactoryGirl.create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      transaction = FactoryGirl.create(:transaction, invoice_id: invoice.id, result: 'success')
      invoice_item = FactoryGirl.create(:invoice_item, invoice_id: invoice.id)

      get :most_revenue, quantity: 1, format: :json

      expect(response).to be_success
    end
  end

  describe "GET #most_items", type: :controller do
    it "returns the merchant(s) who sold the most items" do
      merchant = FactoryGirl.create(:merchant, name: "Mike")
      customer = FactoryGirl.create(:customer)
      invoice = FactoryGirl.create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      transaction = FactoryGirl.create(:transaction, invoice_id: invoice.id, result: 'success')
      invoice_item = FactoryGirl.create(:invoice_item, invoice_id: invoice.id)

      get :most_items, quantity: 1, format: :json

      expect(response).to be_success
    end
  end

  describe "GET #revenue", type: :controller do
    it "returns the merchant(s) with the most revenue" do
      merchant = FactoryGirl.create(:merchant, name: "Mike")
      customer = FactoryGirl.create(:customer)
      invoice = FactoryGirl.create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      transaction = FactoryGirl.create(:transaction, invoice_id: invoice.id, result: 'success')
      invoice_item = FactoryGirl.create(:invoice_item, invoice_id: invoice.id)

      get :revenue, id: merchant.id, format: :json

      expect(response).to be_success
    end
  end


end
