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
end
