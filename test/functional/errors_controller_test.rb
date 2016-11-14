require 'test_helper'

class ErrorsControllerTest < ActionController::TestCase
  test "should get error_404" do
    assert_response(:success) do
      get "/banana"
    end
  end
end
