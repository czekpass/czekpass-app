require 'test_helper'

class PerkTemplatesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get perk_templates_new_url
    assert_response :success
  end

  test "should get create" do
    get perk_templates_create_url
    assert_response :success
  end

end
