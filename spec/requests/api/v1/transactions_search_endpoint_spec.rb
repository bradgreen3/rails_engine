# require 'rails_helper'
#
# describe "transactions search endpoint" do
#   context "GET /api/v1/transactions/find?id=1" do
#     it "returns transaction with id" do
# 
#       transaction1 = create(:transaction)
#       transaction2 = create(:transaction)
#
#       get "/api/v1/transactions/find?id=#{transaction1.id}"
#
#       transaction_response = JSON.parse(response.body)
#
#       expect(response).to be_success
#       expect(transaction_response["id"]).to eq(transaction1.id)
#
#     end
#   end
# end
