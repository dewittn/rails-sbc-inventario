Event.addBehavior({  
  'body': function(){
      var busy = $div({id:'busy',style: "display:none;"}, "Loading...");
      document.body.appendChild(busy);
      new Ajax.InPlaceEditor('factura', path_prefix + '/javascripts/factura')
  },
  
  '#inventario_marca_id:change': function(){
   new Ajax.Request(path_prefix + '/javascripts/reinventariar?' + document.forms[0].serialize(), {evalScripts:true});
  },
  
  '#inventario_color_id:change': function(){
   new Ajax.Request(path_prefix + '/javascripts/reinventariar?' + document.forms[0].serialize(), {evalScripts:true});
  },
  
  '#inventario_tipo_id:change': function(){
   new Ajax.Request(path_prefix + '/javascripts/reinventariar?' + document.forms[0].serialize(), {evalScripts:true});
  },
  
  '#inventario_genero_id:change': function(){
   new Ajax.Request(path_prefix + '/javascripts/reinventariar?' + document.forms[0].serialize(), {evalScripts:true});
  },

  '#inventario_estilo_id:change': function(){
   new Ajax.Request(path_prefix + '/javascripts/reinventariar?' + document.forms[0].serialize(), {evalScripts:true});
  },

  '#inventario_talla_id:change': function(){
   new Ajax.Request(path_prefix + '/javascripts/reinventariar?' + document.forms[0].serialize(), {evalScripts:true});
  },
});