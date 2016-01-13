require 'test_helper'

class CharactersControllerTest < ActionController::TestCase
  def setup
    @claire = Character.find_by(name: 'Claire')
  end

  def show(character)
      get :show, {id: character.id}
  end

  def setting_symbol(character)
    get :setting_symbol, {id: character.id}
  end

  test "character_exists" do
    assert_not @claire.nil?
  end

  test "should show character" do
    show @claire
    assert_response :success
    assert_not_nil assigns(:character)
  end

  test "should show new character page" do
    get :new
    assert_response :success
  end
end
