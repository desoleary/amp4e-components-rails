#= require rails-ujs
#= require turbolinks
#= require sinonjs
#= require underscore
#= require backbone
#= require jquery
#= require bootstrap
#= require chai
#= require amp4e-components-rails
#= require_tree .

$.extend window, _.omit(chai, window) # adding chai methods to window
