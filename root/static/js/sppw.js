

$(function() {
	$('#cpf').mask('999.999.999-99');
	$('#telefone').mask('(99)9999-9999');
	$('#cep').bind().keyup( function() {
		if(document.activeElement.id === 'cep') {
			var cep = $(this).val();

			if (cep.match(/\d\d\d\d\d-\d\d\d/)) {
				jQuery('#cadastro_pane').showLoading();
				var url_string = "http://cep.opendatabr.org/api/" + cep;

				$.ajax({
					url: url_string,
					data_type: 'json',
					success: function (data) {
						jQuery('#cadastro_pane').hideLoading();		
					
						$('#endereco_detalhes').show();
					},
					error: function () {
						jQuery('#cadastro_pane').hideLoading();
						$('#endereco_detalhes').show();
					},
					complete: function() {
						jQuery('#cadastro_pane').hideLodding();
						$('#endereco_detalhes').show();
					}
				});
			}
		}
	});

	$('#cep').mask('99999-999');


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


