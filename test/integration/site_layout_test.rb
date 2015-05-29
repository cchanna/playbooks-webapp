require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test "layout_links" do 
  	get root_path
  	assert_template 'static_pages/home'
  end
end
