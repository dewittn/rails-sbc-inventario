// jQuery version of buscar_index.js for Rails 4.2
$(document).ready(function() {
  // Make search form submit via AJAX
  $('#search_form').on('submit', function(e) {
    e.preventDefault();
    $.ajax({
      url: $(this).attr('action'),
      type: 'GET',
      data: $(this).serialize(),
      dataType: 'script'
    });
  });

  // Make pagination links work via AJAX
  $(document).on('click', 'div.pagination a', function(e) {
    e.preventDefault();
    $.ajax({
      url: $(this).attr('href'),
      type: 'GET',
      dataType: 'script'
    });
  });
});

function sacar() {
  // Validate that order has a name
  if ($('#nombre').html() == "(agregue el nombre)") {
    alert("La orden no tiene nombre");
    return false;
  }

  // Validate that order has a number
  if ($('#numero').html() == "(agregue el numero)") {
    alert("La orden no tiene numero");
    return false;
  }

  // Validate that all quantities are filled in
  var faltan = 0;
  var cantidads = $('.cantidads_por_sacar');
  for (var counter = 0; counter < cantidads.length; counter++) {
    if (cantidads[counter].value <= 0) {
      faltan = faltan + 1;
    }
  }

  if (faltan != 0) {
    alert("Faltan cantidad");
    return false;
  }

  // Submit the request
  $.post('/javascripts/por_sacar', function() {
    // Response will be handled by por_sacar.js.erb
  }, 'script');
}

function limpiar() {
  $.post('/javascripts/limpiar', function() {
    // Response will be handled by limpiar.js.erb
  }, 'script');
}

// In-place editing functionality for order name and number
$(document).ready(function() {
  // Make elements with class 'editable' clickable for editing
  $(document).on('click', '.editable', function(e) {
    var $span = $(this);

    // Don't start editing if already editing
    if ($span.find('input').length > 0) {
      return;
    }

    var currentText = $span.text();
    var placeholder = $span.data('placeholder');
    var url = $span.data('url');

    // Replace text with an input field
    var inputValue = (currentText === placeholder) ? '' : currentText;
    var $input = $('<input type="text" class="in-place-editor" />')
      .val(inputValue)
      .css({
        'font-size': 'inherit',
        'font-family': 'inherit',
        'font-weight': 'inherit',
        'padding': '2px 4px',
        'margin': '0',
        'border': '1px solid #ccc',
        'background-color': '#ffffcc'
      });

    $span.html($input);
    $input.focus().select();

    // Function to save the value
    var saveValue = function() {
      var newValue = $input.val().trim();

      // Send AJAX request to save
      $.ajax({
        url: url,
        type: 'POST',
        data: {
          value: newValue,
          authenticity_token: $('meta[name="csrf-token"]').attr('content')
        },
        success: function(response) {
          // Update the span with the response from server
          $span.text(response);
        },
        error: function() {
          // On error, revert to original text
          $span.text(currentText);
          alert('Error al guardar. Por favor, intente de nuevo.');
        }
      });
    };

    // Save on blur (clicking away)
    $input.on('blur', function() {
      saveValue();
    });

    // Save on Enter key, cancel on Escape
    $input.on('keydown', function(e) {
      if (e.keyCode === 13) { // Enter
        e.preventDefault();
        $(this).blur(); // Trigger blur to save
      } else if (e.keyCode === 27) { // Escape
        e.preventDefault();
        $span.text(currentText); // Revert to original
      }
    });
  });

  // Add visual feedback on hover for editable elements
  $(document).on('mouseenter', '.editable', function() {
    $(this).css('cursor', 'pointer');
    if ($(this).find('input').length === 0) {
      $(this).css('background-color', '#f0f0f0');
    }
  });

  $(document).on('mouseleave', '.editable', function() {
    if ($(this).find('input').length === 0) {
      $(this).css('background-color', 'transparent');
    }
  });
});
