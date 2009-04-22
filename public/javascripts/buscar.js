Event.addBehavior({
  '#search_form': Remote.Form,
  
  'body': function(){
      var busy = $div({id:'busy',style: "display:none;"}, "Loading...");
      document.body.appendChild(busy);
  },
});

Ajax.Responders.register({
  onCreate: function() {
    if($('busy') && Ajax.activeRequestCount > 0)
      Effect.Appear('busy',{duration:0.5,queue:'end'});
  },
  
  onComplete: function() {
    if($('busy') && Ajax.activeRequestCount == 0)
      Effect.Fade('busy',{duration:1.0,queue:'end'});
  }    
});
