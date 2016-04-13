require 'rails_helper'

RSpec.describe Api::V1::ItemsController do
  describe "GET index", type: :controller do
    it "returns all items" do
      item = FactoryGirl.create(:item)
      get :index, format: :json

      items = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
      expect(Item.count).to eq(1)
      expect(Item.last.name).to eq("hammer")
    end
  end

  describe "GET #show", type: :controller do
    it "returns one item" do
      item = FactoryGirl.create(:item)
      get :show, id: item.id, format: :json

      item = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #find", type: :controller do
    it "return first item to match query" do
      item = FactoryGirl.create(:item)
      get :find, id: item.id, format: :json

      item = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
    end
  end
end
