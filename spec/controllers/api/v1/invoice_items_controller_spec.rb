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
end
