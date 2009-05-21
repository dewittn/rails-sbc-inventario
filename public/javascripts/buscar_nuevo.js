Event.addBehavior({  
  'body': function(){
      var busy = $div({id:'busy',style: "display:none;"}, "Loading...");
      document.body.appendChild(busy);
      new Ajax.InPlaceEditor('factura', '/inventario/javascripts/factura')
  },
});