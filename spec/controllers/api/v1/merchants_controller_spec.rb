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
end
