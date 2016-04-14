require 'rails_helper'

RSpec.describe Api::V1::InvoicesController do
  describe "GET index", type: :controller do
    it "returns all invoices" do
      invoice = FactoryGirl.create(:invoice)
      get :index, format: :json

      items = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
      expect(Invoice.count).to eq(1)
      expect(Invoice.last.status).to eq("completed")
    end
  end

  describe "GET #show", type: :controller do
    it "returns one invoice" do
      invoice = FactoryGirl.create(:invoice)
      get :show, id: invoice.id, format: :json

      item = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #find", type: :controller do
    it "return first invoice to match query" do
      invoice = FactoryGirl.create(:invoice)
      get :find, id: invoice.id, format: :json

      item = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #random", type: :controller do
    it "returns a random invoice" do
      FactoryGirl.create_list(:invoice, 2)

      get :random, format: :json

      expect(response).to be_success
    end
  end

  describe "GET #transactions", type: :controller do
    it "return associated transactions" do
      invoice = FactoryGirl.create(:invoice)
      get :transactions, id: invoice.id, format: :json

      item = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #invoice_items", type: :controller do
    it "return associated invoice items" do
      invoice = FactoryGirl.create(:invoice)
      get :invoice_items, id: invoice.id, format: :json

      item = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #items", type: :controller do
    it "return associated items" do
      invoice = FactoryGirl.create(:invoice)
      get :items, id: invoice.id, format: :json

      item = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #customer", type: :controller do
    it "return associated customer" do
      invoice = FactoryGirl.create(:invoice)
      get :customer, id: invoice.id, format: :json

      item = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #merchant", type: :controller do
    it "return associated merchant" do
      invoice = FactoryGirl.create(:invoice)
      get :merchant, id: invoice.id, format: :json

      item = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #find", type: :controller do
    it "return first invoice to match query" do
      invoice = FactoryGirl.create(:invoice)
      get :find, id: invoice.id, format: :json

      item = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
    end
  end


  describe "GET #find_all", type: :controller do
    before(:each) do
      @invoice1 = FactoryGirl.create(:invoice, status: 3000)
      @invoice2 = FactoryGirl.create(:invoice, status: 3000)
      @invoice3 = FactoryGirl.create(:invoice, status: 2000)
    end

    it "returns the correct invoice with the find and id parameter" do
      get :find_all, format: :json, status: 3000
      invoice_response = json_response
      expect(invoice_response.count).to eq 2
      expect(invoice_response.first[:id]).to eq @invoice1.id
      expect(invoice_response.last[:id]).to eq @invoice2.id
      expect(response).to be_success
    end
  end
end
