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

  describe "GET #random", type: :controller do
    it "returns a random transaction" do
      FactoryGirl.create_list(:transaction, 2)

      get :random, format: :json

      expect(response).to be_success
    end
  end

  describe "GET #invoice", type: :controller do
    it "returns the associated invoice" do
      transaction = FactoryGirl.create(:transaction)
      get :invoice, id: transaction.id, format: :json

      item = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #find_all", type: :controller do
    before(:each) do
      @transaction1 = FactoryGirl.create(:transaction, result: "Done")
      @transaction2 = FactoryGirl.create(:transaction, result: "Done")
      @transaction3 = FactoryGirl.create(:transaction, result: "Not Done")
    end

    it "returns the correct transaction with the find and id parameter" do
      get :find_all, format: :json, result: "Done"
      transaction_response = json_response
      expect(transaction_response.count).to eq 2
      expect(transaction_response.first[:id]).to eq @transaction1.id
      expect(transaction_response.last[:id]).to eq @transaction2.id
      expect(response).to be_success
    end
  end

end
