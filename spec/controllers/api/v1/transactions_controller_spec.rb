require 'rails_helper'

RSpec.describe Api::V1::TransactionsController do
  describe "GET index", type: :controller do
    it "returns all transactions" do
      transaction = FactoryGirl.create(:transaction)
      get :index, format: :json

      items = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
      expect(Transaction.count).to eq(1)
      expect(Transaction.last.result).to eq("pending")
    end
  end

  describe "GET #show", type: :controller do
    it "returns one transaction" do
      transaction = FactoryGirl.create(:transaction)
      get :show, id: transaction.id, format: :json

      item = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #find", type: :controller do
    it "return first transaction to match query" do
      transaction = FactoryGirl.create(:transaction)
      get :find, id: transaction.id, format: :json

      item = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
    end
  end
end
