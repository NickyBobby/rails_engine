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
end
