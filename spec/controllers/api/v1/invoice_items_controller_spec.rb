require 'rails_helper'

RSpec.describe Api::V1::InvoiceItemsController do
  describe "GET index", type: :controller do
    it "returns all invoice items" do
      invoice_item = FactoryGirl.create(:invoice_item)
      get :index, format: :json

      items = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
      expect(InvoiceItem.count).to eq(1)
      expect(InvoiceItem.last.unit_price).to eq(4000)
    end
  end

  describe "GET #show", type: :controller do
    it "returns one invoice item" do
      invoice_item = FactoryGirl.create(:invoice_item)
      get :show, id: invoice_item.id, format: :json

      item = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #find", type: :controller do
    it "return first invoice item to match query" do
      invoice_item = FactoryGirl.create(:invoice_item)
      get :find, id: invoice_item.id, format: :json

      item = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #find", type: :controller do
    it "return first invoice item to match query" do
      invoice_item = FactoryGirl.create(:invoice_item)
      get :find, id: invoice_item.id, unit_price: "40.00", format: :json

      item = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #random", type: :controller do
    it "returns a random invoice item" do
      FactoryGirl.create_list(:invoice_item, 2)

      get :random, format: :json

      expect(response).to be_success
    end
  end

  describe "GET #find_all", type: :controller do
    before(:each) do
      @invoice_item1 = FactoryGirl.create(:invoice_item, quantity: 3000)
      @invoice_item2 = FactoryGirl.create(:invoice_item, quantity: 3000)
      @invoice_item3 = FactoryGirl.create(:invoice_item, quantity: 2000)
    end

    it "returns the correct invoice_item with the find and id parameter" do
      get :find_all, format: :json, quantity: 3000
      invoice_item_response = json_response
      expect(invoice_item_response.count).to eq 2
      expect(invoice_item_response.first[:id]).to eq @invoice_item1.id
      expect(invoice_item_response.last[:id]).to eq @invoice_item2.id
      expect(response).to be_success
    end
  end

  describe "GET #invoice", type: :controller do
    it "returns associated invoice" do
      invoice_item = FactoryGirl.create(:invoice_item)
      get :invoice, id: invoice_item.id, format: :json

      item = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #item", type: :controller do
    it "returns associated item" do
      invoice_item = FactoryGirl.create(:invoice_item)
      get :item, id: invoice_item.id, format: :json

      item = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
    end
  end

end
