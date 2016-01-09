require 'test_helper'

class CharactersControllerTest < ActionController::TestCase
  def show(character)
      get :show, {id: character.id}
  end

  def setup
    @one = characters(:one)
  end

  test "should show character" do
    show @one
    assert_response :success
    assert_not_nil assigns(:character)
  end

  test "name renders" do
    show @one
    assert_select 'div#name', @one.name
  end
end
