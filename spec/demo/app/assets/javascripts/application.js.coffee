#= require rails-ujs
#= require turbolinks
#= require underscore
#= require jquery
#= require bootstrap
#= require chai
#= require amp4e-components-rails
#= require_tree .

$.extend window, _.omit(chai, window) # adding chai methods to window
