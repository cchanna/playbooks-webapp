require 'test_helper'

class CharactersControllerTest < ActionController::TestCase
  def show(character)
      get :show, {id: character.id}
  end

  def setup
    @claire = characters(:claire)
  end

  test "should show new character page" do
    get :new
    assert_response :success
  end

  test "should show character" do
    show @claire
    assert_response :success
    assert_not_nil assigns(:character)
  end

  test "name renders" do
    show @claire
    assert_select 'div#name', @one.name
  end

  test "archetype renders" do
    show @claire
    assert_select 'div#archetype', "The " + @claire.archetype.name
  end
end
