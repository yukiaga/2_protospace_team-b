$(document).on('turbolinks:load', function() { 
	$('.popular').click(function() {
    	Turbolinks.visit('./prototypes.1')
	});
	$('.newest').click(function() {
    	Turbolinks.visit('./prototypes.2')
	});
});