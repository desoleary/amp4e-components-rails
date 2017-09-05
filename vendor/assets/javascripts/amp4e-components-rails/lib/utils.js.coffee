AMP4e.Utils =

# New, much simpler HTML escape, adapted from Mustache:
# https://github.com/janl/mustache.js/blob/master/mustache.js
  escapeHtml: (string) ->
    String(string).replace /[&<>"'`=\/]/g, (s) -> AMP4e.ENTITYMAP[s]


# escape characters that have special meaning in regular expressions
  escapeRegex: (string) ->
    String(string).replace /[-\/\\^$*+?.()|[\]{}]/g, '\\$&'


  isNumeric: (str) ->
    !@isBlank(str) and (_.isNumber(str) || !isNaN(str))


  isBlank: (arg) ->
# for some reason we treat the string 'null' as blank; this is obviously
# wrong, but we might rely on it somewhere, so it may not be safe to fix it
    undefined == arg || null == arg || (_.isObject(arg) && Object.keys(arg).length == 0) || arg.length == 0 || _.isString(arg) && (_.isEmpty(arg.trim()) || "null" == arg.trim())


  isEmail: (str) ->
#/\A\s*([^@\s]{1,64})@((?:[-a-z0-9]+\.)+[a-z]{2,})\s*\z/i regex from Rails email_validator gem
    /^\s*([^@\s]{1,64})@((?:[-a-z0-9]+\.)+[a-z]{2,})\s*$/gi.test(str) # converted using https://github.com/janosch-x/js_regex.


  isUrl: (str) ->
# from https://github.com/jquery-validation/jquery-validation/blob/master/src/core.js
    /^(?:(?:(?:https?|ftp):)?\/\/)(?:\S+(?::\S*)?@)?(?:(?!(?:10|127)(?:\.\d{1,3}){3})(?!(?:169\.254|192\.168)(?:\.\d{1,3}){2})(?!172\.(?:1[6-9]|2\d|3[0-1])(?:\.\d{1,3}){2})(?:[1-9]\d?|1\d\d|2[01]\d|22[0-3])(?:\.(?:1?\d{1,2}|2[0-4]\d|25[0-5])){2}(?:\.(?:[1-9]\d?|1\d\d|2[0-4]\d|25[0-4]))|(?:(?:[a-z\u00a1-\uffff0-9]-*)*[a-z\u00a1-\uffff0-9]+)(?:\.(?:[a-z\u00a1-\uffff0-9]-*)*[a-z\u00a1-\uffff0-9]+)*(?:\.(?:[a-z\u00a1-\uffff]{2,})).?)(?::\d{2,5})?(?:[/?#]\S*)?$/i.test(str)


  isEmailOrUrl: (str) ->
    @isEmail(str) || @isUrl(str)


  trim: (strOrList) ->
    if _.isArray(strOrList)
      return _.reject strOrList, (str) =>
        @isBlank(str)

    if _.isString(strOrList) then strOrList.trim() else strOrList


  toInteger: (num) ->
    if @isNumeric(num) then parseInt(num) else num


  toBoolean: (bool) ->
    return bool   if _.isBoolean(bool)
    return true  if _.isString(bool) && "true" == bool.trim()
    return false if _.isString(bool) && "false" == bool.trim()
    return bool


  stringToList: (str) ->
    return [] if @isBlank(str)
    return str unless _.isString(str)
    return str.split(',')


  inspect: (object, iter) ->
    iter = ""  if typeof iter is "undefined"
    return "[MAX ITERATIONS]"  if iter.length > 50
    rows = []
    for index of object
      type = typeof object[index]
      rows.push iter + "\"" + index + "\" (" + type + ") => " + ((if type is "object" then "object:" + AMP4e.Utils.inspect(object[index], iter + "  ") else object[index] + ""))
    rows.join iter + "\n"


  format: (formatter, args...) ->
    return formatter.replace /{(\d+)}/g, (match, number) ->
      return if typeof args[number] isnt 'undefined' then args[number] else match


# Creates a deep copy of given object
  deepCopy: (obj) ->
    return obj if _.isArray(obj) || !_.isObject(obj)
    $.extend(true, {}, obj)


  camelCaseToUnderscore: (str, replacementCharacter = '_') ->
    updatedStr = str.replace /([A-Z])/g, (text) ->
      replacementCharacter + text.toLowerCase()
    updatedStr.slice(1)


  toLowerCase: (text) ->
    return text unless _.isString(text)
    text.toLowerCase()


  camelCase: (str) ->
    str.replace /[-_]([A-Za-z])/g, (match, letter) -> letter.toUpperCase()


# convert object keys to camelcase
  objectToCamelCase: (object) ->
    newObject = {}
    _.each object, (val, key) ->
      newObject[AMP4e.Utils.camelCase key] = val
    newObject

  capitalizeFirstLetter: (text) ->
    return text unless _.isString(text)
    text.charAt(0).toLocaleUpperCase() + text.slice(1)


  replaceAll: (text, search, replacement) ->
    return text unless _.isString(text) && _.isString(search) && _.isString(replacement)
    text.replace(new RegExp(search, 'g'), replacement)


  # convert string to hyphen-separated lowercase (similar to the Rails method)
  parameterize: (string, options = {}) ->
    separator = options.separator || '-'
    preserveCase = options.preserveCase || false

    string = String(string).trim().replace /[^a-z0-9\-_]/gi, separator

    unless _.isEmpty(separator)
      reSep = AMP4e.Utils.escapeRegex(separator)
      reDuplicate = new RegExp("#{reSep}{2,}", 'g')
      reLeadingTrailing = new RegExp("^#{reSep}|#{reSep}$", 'g')
      string = string.replace reDuplicate, separator
      string = string.replace reLeadingTrailing, ''

    string = string.toLowerCase() unless preserveCase
    string


  parseUrl: (fullUrl = window.location.href) ->
    return 'Invalid URL (missing protocol)' if fullUrl.indexOf('://') == -1

    # handle missing trailing slash in domain-only URLs
    fullUrl += '/' if fullUrl.match(/\//g).length < 3

    baseURL           = fullUrl.slice(0, fullUrl.lastIndexOf('/') + 1)
    [protocol, path]  = fullUrl.split('://')
    pathParts         = path.split('/')
    route             = path.substr(path.indexOf('/'))
    [domain, port]    = pathParts.splice(0,1)[0].split(':')
    [document, query] = pathParts.pop(1).split('?')
    params            = {}

    port = parseInt(port, 10) unless _.isEmpty(port)
    port ||= if protocol == 'https' then 443 else 80

    if query
      for param in query.split('&')
        [key, val] = param.split('=')
        # treat `+` as space (decodeURIComponent does not do this)
        key = decodeURIComponent(key.replace(/\+/g, '%20'))
        val = decodeURIComponent(val.replace(/\+/g, '%20')) unless _.isEmpty val
        # handle multi-value params
        if key.indexOf('[]') == (key.length - 2)
          key = key.substr(0, key.length - 2)
          if params[key]
            params[key].push val
          else
            params[key] = [val]
        else
          params[key] = val

    getQueryString = ->
      queryParams = []
      for key, val of params
        key = encodeURIComponent(key)
        val = encodeURIComponent(val)
        queryParams.push "#{key}=#{val}"
      queryParams.join('&')

    # return
    {
      baseURL
      document
      domain
      fullUrl
      getQueryString
      params
      pathParts
      port
      protocol
      query
      route
    }


  pathVar: do ->

    parse = (object, path) ->
      return unless AMP4e.Utils.typeOf(object) == 'object' and path?
      return [object, path] if path.indexOf('.') == -1
      path = path.split('.')
      tail = path.pop()
      for property in path
        return unless object.hasOwnProperty(property)
        object = object[property]
      [object, tail]

    read = (object, path) ->
      parts = parse(object, path)
      return parts[0][parts[1]] if parts

    write = (object, path, value) ->
      parts = parse(object, path)
      if parts
        parts[0][parts[1]] = value
        value

    (object, path, value) ->
      return read(object, path) if arguments.length == 2
      return write(object, path, value) if arguments.length == 3
      console.error '[AMP4e.Utils.pathVar] incorrect number of arguments'


  sum: (array) ->
    unless _.isArray(array)
      console.error '[AMP4e.Utils.sum] argument must be an array'
      return
    total = 0
    total += i for i in array
    total


  tokenKeys: (string, start_delimiter, end_delimiter) ->
    pattern = new RegExp(start_delimiter + '[A-Za-z0-9_]+' + end_delimiter, 'g')
    matches = string.match pattern
    return unless matches
    for match in _.unique(matches)
      match = match.slice(start_delimiter.length, 0 - end_delimiter.length)


  typeOf: (object) ->
    return 'array' if _.isArray object
    return 'regexp' if _.isRegExp object
    typeof object
