$(document).on("turbolinks:load", function() {
  var $user_current_password, $user_password, $user_password_confirmation;

  $('#delete_account_form .checkbox-input').click(function () {
    if ($(this).is(':checked')) {
      $('input#delete_account_btn').removeClass('disabled').removeAttr('disabled');
    } else {
      $('input#delete_account_btn').addClass('disabled').attr('disabled', true);
    }
  });

  $('#user_current_password').on('keyup', function() {
    user_current_password = $(this).val();
    show_btn();
  });

  $('#user_password').on('keyup', function() {
    user_password = $(this).val();
    show_btn();
  });

  $('#user_password_confirmation').on('keyup', function() {
    user_password_confirmation = $(this).val();
    show_btn();
  });

  function valid_state() {
    if (user_current_password.length > 0 && user_password.length > 0 && user_password == user_password_confirmation) {
      return true;
    } else {
      return false;
    }
  };

  function show_btn() {
    if (valid_state()) {
      $('#change_password_btn').removeClass('disabled').removeAttr('disabled');
    } else {
      $('#change_password_btn').addClass('disabled').attr('disabled', true);
    }
  };
});