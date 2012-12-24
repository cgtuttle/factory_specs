// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require_tree .

// get the current date
var date = new Date();
var m = date.getMonth(), d = date.getDate(), y = date.getFullYear();

 $(function (){
	 $('#item_spec_eff_date').datepicker({
    dateFormat: 'D, dd M yy',
		minDate: new Date(y, m, d)
  });
 });


