require 'test_helper'

class PayoutRatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @payout_rate = payout_rates(:one)
  end

  test "should get index" do
    get payout_rates_url
    assert_response :success
  end

  test "should get new" do
    get new_payout_rate_url
    assert_response :success
  end

  test "should create payout_rate" do
    assert_difference('PayoutRate.count') do
      post payout_rates_url, params: { payout_rate: { country: @payout_rate.country, country_code: @payout_rate.country_code, earn: @payout_rate.earn } }
    end

    assert_redirected_to payout_rate_url(PayoutRate.last)
  end

  test "should show payout_rate" do
    get payout_rate_url(@payout_rate)
    assert_response :success
  end

  test "should get edit" do
    get edit_payout_rate_url(@payout_rate)
    assert_response :success
  end

  test "should update payout_rate" do
    patch payout_rate_url(@payout_rate), params: { payout_rate: { country: @payout_rate.country, country_code: @payout_rate.country_code, earn: @payout_rate.earn } }
    assert_redirected_to payout_rate_url(@payout_rate)
  end

  test "should destroy payout_rate" do
    assert_difference('PayoutRate.count', -1) do
      delete payout_rate_url(@payout_rate)
    end

    assert_redirected_to payout_rates_url
  end
end
