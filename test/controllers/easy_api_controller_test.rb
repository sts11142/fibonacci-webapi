require "test_helper"

class EasyApiControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "should get easy_api" do
    get easy_api_url
    assert_response :success
  end

end
