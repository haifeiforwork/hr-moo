/*
 * 기존 input에서 name속성을 가져와 hidden input을 추가하여 값만 저장.
 * 보여지는 형식과 저장되는 형식을 구분.
 * 예) 2017-11-27	20171127
 *
 */
$.fn.extend({
	moorimDatePicker : function(options) {
		var input = $(this);
		var hiddenInput = $('<input>');
		hiddenInput.attr("name", $(this).attr("name"));
		hiddenInput.attr("type", "hidden");
		if (input.val() && input.val().length > 0) {
			hiddenInput.val(parseDate(input.val()));
		}
		input.after(hiddenInput);
		input.attr("name", "");

		input.focusout(function() {
			if ($(this).val().length == 10) {
				hiddenInput.val(parseDate(input.val()));
			} else if ($(this).val().length == 0) {
				hiddenInput.val("");
			}
		});
		var defaultOptions = {
			onSelect : function() {
				hiddenInput.val(parseDate(input.val()));
			}
		};
		$.extend(true, defaultOptions, options);
		input.datepicker(defaultOptions);
		return input;
	}
});

function parseDate(input) {
	return input.replace(/[^0-9]/g,'');
}