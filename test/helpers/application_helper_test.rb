require 'test_helper'

class ApplicationHlperTest < ActionView::TestCase
	test "full title helper" do
		assert_equal full_title, 				 "Playbooks Webapp"
		assert_equal full_title("Help"), "Help | Playbooks Webapp"
	end
end