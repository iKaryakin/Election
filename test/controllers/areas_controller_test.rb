require 'test_helper'

class AreasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get area_index_url
    assert_response :success
  end

end
