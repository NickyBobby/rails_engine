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

  describe "GET #random", type: :controller do
    it "returns a random item" do
      FactoryGirl.create_list(:item, 2)

      get :random, format: :json

      expect(response).to be_success
    end
  end

  describe "GET #invoice_items", type: :controller do
    it "returns all associated invoice items" do
      item = FactoryGirl.create(:item)
      get :invoice_items, id: item.id, format: :json

      item = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #merchant", type: :controller do
    it "returns associated merchant" do
      item = FactoryGirl.create(:item)
      get :merchant, id: item.id, format: :json

      item = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #find_all", type: :controller do
    before(:each) do
      @item1 = FactoryGirl.create(:item, name: "Hammer")
      @item2 = FactoryGirl.create(:item, name: "Hammer")
      @item3 = FactoryGirl.create(:item, name: "Sledge Hammer")
    end

    it "returns the correct item with the find and id parameter" do
      get :find_all, format: :json, name: "Hammer"
      item_response = json_response
      expect(item_response.count).to eq 2
      expect(item_response.first[:id]).to eq @item1.id
      expect(item_response.last[:id]).to eq @item2.id
      expect(response).to be_success
    end
  end


end
