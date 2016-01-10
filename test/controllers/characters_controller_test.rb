require 'test_helper'

class CharactersControllerTest < ActionController::TestCase
  def setup
    @claire = characters(:claire)
  end

  def show(character)
      get :show, {id: character.id}
  end

  test "should show character" do
    show @claire
    assert_response :success
    assert_not_nil assigns(:character)
  end

  test "name renders" do
    show @claire
    assert_select 'div#name', @claire.name
  end

  test "archetype renders" do
    show @claire
    assert_select 'div#archetype', "The " + @claire.archetype.name
  end

  test "should show new character page" do
    get :new
    assert_response :success
  end

  test "should show setting" do
    get :setting_symbol, {id: @claire.id}
    assert_response :success
    assert_not_nil assigns(:character)
  end
end
