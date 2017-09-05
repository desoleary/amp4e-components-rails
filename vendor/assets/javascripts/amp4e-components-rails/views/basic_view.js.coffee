#-------------------------------------------------------------------------------
# BasicView
#-------------------------------------------------------------------------------
#
# Adds common functionality to Backbone.View
#
# defaultOptions:
# - default key/value pairs for the initial `options` hash
#
# defaultProperties:
# - key/value pairs to capture from `options` as instance @properties
# - specify `null` as the value to include a key with no default value
# - if no properties have default values, just provide an array of key names
# - extra properties not in the defaults can be provided via `extraProps` (hash)
#
# _addEvents:
# - simplifies appending new events to the @events property
# - useful for adding events conditionally and extending events in subclasses
#
# _getLineage:
# - introspection tool for dev; returns references to the current view's class
#   and each of the parent classes it inherits from
# - call on any view instance in the console; each class can be clicked to jump
#   to its constructor in the source (convenient way to add breakpoints etc.)
#
# _getOptionsWithDefaults:
# - utility for extracting key/value pairs from `options` that match the keys
#   of a hash of defaults, with the default value filled in for any missing or
#   undefined options
#
#-------------------------------------------------------------------------------

class AMP4e.Components.Views.BasicView extends Backbone.View

  constructor: (options = {}) ->
    options = _.defaults options, @defaultOptions if @defaultOptions
    @_setInstanceProperties(options)
    super options


  _addEvents: (events) ->
    return unless AMP4e.Utils.typeOf(events) == 'object'
    @events ||= {}
    _.extend @events, events


  _getLineage: ->
    lineage = [@constructor]
    obj = @constructor.__super__.constructor
    until obj == undefined
      lineage.push obj
      obj = obj.__super__?.constructor
    lineage


  _getOptionsWithDefaults: (options, defaults) ->
    _.defaults _.pick(options, _.keys(defaults)), defaults


  _setInstanceProperties: (options) ->
    if @defaultProperties
      defaultProps = _.result(this, 'defaultProperties')
      relevantOptions =
        if _.isArray defaultProps
          _.pick options, defaultProps
        else
          @_getOptionsWithDefaults options, defaultProps
      # capture the relevant options as instance properties
      _.each relevantOptions, (value, key) => @[key] = value
    # capture extra key/value pairs, if any
    _.each(options.extraProps, (value, key) => @[key] = value) if options.extraProps
