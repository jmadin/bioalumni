# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#record-date').datepicker({
      format: "yyyy/mm/dd",
      startView: 2,
      autoclose: true,
      todayHighlight: true
  });

$ ->
  $('#until-date').datepicker({
      format: "yyyy/mm/dd",
      startView: 2,
      autoclose: true,
      todayHighlight: true
  });
