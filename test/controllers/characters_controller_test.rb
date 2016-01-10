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

  test "should show setting symbol" do
    setting_symbol @claire
    assert_response :success
    assert_not_nil assigns(:character)
  end

  test "setting symbol renders" do
    setting_symbol @claire
    assert_select '#symbol', @claire.archetype.setting_symbol
  end

  test "setting symbol examples render" do
    setting_symbol @claire
    example1 = @claire.archetype.setting_symbol_example1
    example2 = @claire.archetype.setting_symbol_example2
    example3 = @claire.archetype.setting_symbol_example3
    assert_select '#examples', "(#{example1},#{example2},#{example3})"
  end
end
