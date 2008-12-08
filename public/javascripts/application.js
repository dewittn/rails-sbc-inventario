// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function limpar_submit() {
	Element.insert("por_sacar", { bottom: "<input id='commit' name='commit' type='hidden' value='Limpar'>" });
	document.forms[1].onsubmit()
}

function sacar_submit() {
	Element.insert("por_sacar", { bottom: "<input id='commit' name='commit' type='hidden' value='Sacar'>" });
	document.forms[1].onsubmit()
}