require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    skip "このテストはまだ準備中です"
    get posts_index_url
    assert_response :success
  end
end
