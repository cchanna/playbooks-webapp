require 'test_helper'

class CharacterCreationTest < ActionDispatch::IntegrationTest
  test "create character" do
    get "/characters/new"
    assert_response :success

    post_via_redirect "/characters", character: {archetype_id: Archetype.find_by(name:"Scoundrel").id}
    assert_response :success
  end
end
