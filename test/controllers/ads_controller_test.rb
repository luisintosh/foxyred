require 'test_helper'

class AdsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ad = ads(:one)
  end

  test "should get index" do
    get ads_url
    assert_response :success
  end

  test "should get new" do
    get new_ad_url
    assert_response :success
  end

  test "should create ad" do
    assert_difference('Ad.count') do
      post ads_url, params: { ad: { code: @ad.code, countries: @ad.countries, default: @ad.default, end_date: @ad.end_date, network: @ad.network, position: @ad.position, price: @ad.price, start_date: @ad.start_date, traffic_source: @ad.traffic_source, type: @ad.type, weight: @ad.weight } }
    end

    assert_redirected_to ad_url(Ad.last)
  end

  test "should show ad" do
    get ad_url(@ad)
    assert_response :success
  end

  test "should get edit" do
    get edit_ad_url(@ad)
    assert_response :success
  end

  test "should update ad" do
    patch ad_url(@ad), params: { ad: { code: @ad.code, countries: @ad.countries, default: @ad.default, end_date: @ad.end_date, network: @ad.network, position: @ad.position, price: @ad.price, start_date: @ad.start_date, traffic_source: @ad.traffic_source, type: @ad.type, weight: @ad.weight } }
    assert_redirected_to ad_url(@ad)
  end

  test "should destroy ad" do
    assert_difference('Ad.count', -1) do
      delete ad_url(@ad)
    end

    assert_redirected_to ads_url
  end
end
