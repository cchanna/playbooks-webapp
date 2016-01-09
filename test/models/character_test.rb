require 'test_helper'

class CharacterTest < ActiveSupport::TestCase
  def setup
    @one = characters(:one)
  end

  test 'name must exist' do
    assert Character.create.valid?
    assert Character.create(name: "Fred").valid?
    assert_not Character.create(name: nil).valid?
    assert_not Character.create(name: "").valid?
  end
end
