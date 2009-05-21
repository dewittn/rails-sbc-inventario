Event.addBehavior.reassignAfterAjax = true;

Event.addBehavior({
  '#search_form': Remote.Form,
  'div.pagination a' : Remote.Link,
  
  'body': function(){
      var busy = $div({id:'busy',style: "display:none;"}, "Loading...");
      document.body.appendChild(busy);
      new Ajax.Request('../javascripts/agregar_otro_para_sacar', {evalScripts:true});
  },
});

function sacar(){
    if ($('nombre').innerHTML == "(agregue el nombre)")
        {alert("La orden no tiene nombre"); return false;}
    if ($('numero').innerHTML == "(agregue el numero)")
        {alert("La orden no tiene numero"); return false;}
    
    var faltan = 0;
    var cantidads = $$('.cantidads_por_sacar');
    for (counter = 0; counter < cantidads.length; counter++){
    	if (cantidads[counter].value <= 0)
    	{ faltan = faltan + 1; }
    };
    if (faltan != 0)
        { alert("Faltan cantidad");return false; }
    new Ajax.Request('../javascripts/por_sacar', {evalScripts:true})
} 

function limpiar(){
    new Ajax.Request('../javascripts/limpiar', {evalScripts:true})
}