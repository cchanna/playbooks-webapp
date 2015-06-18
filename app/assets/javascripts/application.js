// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require_tree .

$(document).on('change', '.submittable', function() {
	$(this).parents('form:first').submit();
});

function save_data(form, text) {
	$('#overlay').hide();
	$(text).show();
	var value = $(form).val().split("\n");
	var result = "";
	for (var line in value) {
		result += "<p>" + value[line] + "</p>";
	}
	$(text).html(result);


	$(form).parents('form:first').submit();
	$(form).parents('form:first').remove();
}