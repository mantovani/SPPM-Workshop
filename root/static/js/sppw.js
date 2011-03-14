
$(function() {
	$('.button').click( function(value) {
		var nome = $('#nome').val();
		jQuery('#cadastro_pane').showLoading();
		$.getJSON('/inscricao/cadastro',
			function (data) {
				jQuery('#cadastro_pane').hideLoading();
			}
		);
		return false
	});
});
