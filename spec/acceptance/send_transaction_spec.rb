require 'spec_helper'

RSpec.describe "SendTransaction", vcr: {record: :once} do

  let(:transaction_id) { SecureRandom.hex(6) }

  it "sends a transaction" do
    client = EWayClient.new(CONFIG)

    query_list_banks_response = client.query_list_banks
    expect(query_list_banks_response).to be_success
    bank = query_list_banks_response.banks.first

    response = client.send_transaction(
      transaction_id: transaction_id,
      transaction_date: Time.now,
      transaction_currency: "VND",
      transaction_amount: 50_000,
      sett_amount: 50_000,
      sett_currency: "VND",
      sett_conversion_rate: 1,
      sender_name: "Test Sender",
      sender_country: "Philippines",
      receiver_name: "Test Recipient",
      receiver_address: "123 St",
      receiver_district: "Test St dist",
      receiver_city: "Ho Chi Minh",
      paymentmode: "FT",
      bank_id: bank.bank_id,
      bank_account_number: "0123456789",
      bankbranch_name: "Test Branch",
      bankbranch_address: "123 Testy"
    )

    expect(response).to be_success
  end

end
