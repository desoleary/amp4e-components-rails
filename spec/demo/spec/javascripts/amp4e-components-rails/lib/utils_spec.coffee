describe 'AMP4e.Utils', ->

  describe 'escapeRegex', ->
    it 'escapes special regex characters in a string', ->
## the first backslash escapes the backslash in the string and makes it
## easier to check for escaped characters
      esc = '\\'
      # standard pattern delimiter
      expect(AMP4e.Utils.escapeRegex('/')).to.eql "#{esc}/"
      # escape
      expect(AMP4e.Utils.escapeRegex(esc)).to.eql "#{esc}#{esc}"
      # anchors
      expect(AMP4e.Utils.escapeRegex('^')).to.eql "#{esc}^"
      expect(AMP4e.Utils.escapeRegex('$')).to.eql "#{esc}$"
      # quantifiers
      expect(AMP4e.Utils.escapeRegex('+')).to.eql "#{esc}+"
      expect(AMP4e.Utils.escapeRegex('?')).to.eql "#{esc}?"
      expect(AMP4e.Utils.escapeRegex('*')).to.eql "#{esc}*"
      expect(AMP4e.Utils.escapeRegex('{')).to.eql "#{esc}{"
      expect(AMP4e.Utils.escapeRegex('}')).to.eql "#{esc}}"
      # any character
      expect(AMP4e.Utils.escapeRegex('.')).to.eql "#{esc}."
      # subgroup
      expect(AMP4e.Utils.escapeRegex('(')).to.eql "#{esc}("
      expect(AMP4e.Utils.escapeRegex(')')).to.eql "#{esc})"
      # "or"
      expect(AMP4e.Utils.escapeRegex('|')).to.eql "#{esc}|"
      # character class
      expect(AMP4e.Utils.escapeRegex('[')).to.eql "#{esc}["
      expect(AMP4e.Utils.escapeRegex(']')).to.eql "#{esc}]"
      expect(AMP4e.Utils.escapeRegex('-')).to.eql "#{esc}-"


  describe 'toBoolean', ->
    it 'converts text to boolean', ->
      expect(AMP4e.Utils.toBoolean('  true  ')).to.eql(true)
      expect(AMP4e.Utils.toBoolean('true')).to.eql(true)
      expect(AMP4e.Utils.toBoolean(true)).to.eql(true)
      expect(AMP4e.Utils.toBoolean('  false  ')).to.eql(false)
      expect(AMP4e.Utils.toBoolean('false')).to.eql(false)
      expect(AMP4e.Utils.toBoolean(false)).to.eql(false)
      expect(AMP4e.Utils.toBoolean('adsklj')).to.eql('adsklj')
      expect(AMP4e.Utils.toBoolean(undefined)).to.eql(undefined )
      expect(AMP4e.Utils.toBoolean({})).to.eql({})
      expect(AMP4e.Utils.toBoolean([])).to.eql([])


  describe 'toInteger', ->
    it 'converts numeric to integer', ->
      expect(AMP4e.Utils.toInteger('123')).to.eql(123)
      expect(AMP4e.Utils.toInteger('-123')).to.eql(-123)
      expect(AMP4e.Utils.toInteger(123)).to.eql(123)
      expect(AMP4e.Utils.toInteger(-123)).to.eql(-123)
      expect(AMP4e.Utils.toInteger('123d')).to.eql('123d')


  describe 'trim', ->
    it 'trims spaces at the start or end of a string', ->
      expect(AMP4e.Utils.trim('   abc  123')).to.eql('abc  123')

    it 'removes empty strings from an array', ->
      expect(AMP4e.Utils.trim(['  ', '', '123'])).to.eql(['123'])

    it "returns the original object if it isn't an array or string", ->
      expect(AMP4e.Utils.trim({a:1})).to.eql({a:1})


  describe 'isBlank', ->

    it 'returns true when given an undefined or null value', ->
      expect(AMP4e.Utils.isBlank(undefined)).to.eql(true)
      expect(AMP4e.Utils.isBlank(null)).to.eql(true)

    it 'returns true when given the string "null" (which is dumb and wrong but we might be stuck with it)', ->
# 'null' is a non-blank string and should obviously NOT return true;
# unfortunately we might rely on it somewhere, so it may not be safe to
# fix it
      expect(AMP4e.Utils.isBlank('null')).to.eql(true)

    it 'returns true when given an empty string', ->
      expect(AMP4e.Utils.isBlank('')).to.eql(true)

    it 'returns true when given a string containing only spaces', ->
      expect(AMP4e.Utils.isBlank('    ')).to.eql(true)

    it 'returns true when given an empty object', ->
      expect(AMP4e.Utils.isBlank({})).to.eql(true)

    it 'returns true when given an empty array', ->
      expect(AMP4e.Utils.isBlank([])).to.eql(true)

    it 'returns false when given a non-blank string', ->
      expect(AMP4e.Utils.isBlank('s')).to.eql(false)

    it 'returns false when given a non-empty object', ->
      expect(AMP4e.Utils.isBlank({a: 'b'})).to.eql(false)

    it 'returns false when given a non-empty array', ->
      expect(AMP4e.Utils.isBlank([1])).to.eql(false)


  describe 'isNumeric', ->

    it 'returns true when given valid number', ->
      expect(AMP4e.Utils.isNumeric(Number.MAX_VALUE)).to.eql(true)
      expect(AMP4e.Utils.isNumeric(Number.MIN_VALUE)).to.eql(true)

    it 'returns false when given a non-number value', ->
      expect(AMP4e.Utils.isNumeric('')).to.eql(false)
      expect(AMP4e.Utils.isNumeric('  ')).to.eql(false)
      expect(AMP4e.Utils.isNumeric(null)).to.eql(false)
      expect(AMP4e.Utils.isNumeric('1234a')).to.eql(false)


  describe 'inspect', ->
    it 'inspects given object', ->
      obj    = {some_property_name: 'some.property.value'}
      result = AMP4e.Utils.inspect(obj)

      expect(result).to.eql('"some_property_name" (string) => some.property.value')


  describe 'stringToList', ->
    it 'converts a string to a list', ->
      expect(AMP4e.Utils.stringToList('1234,1235')).to.eql(['1234', '1235'])
      expect(AMP4e.Utils.stringToList('   ')).to.be.empty
      expect(AMP4e.Utils.stringToList(undefined)).to.be.empty
      expect(AMP4e.Utils.stringToList(null)).to.be.empty
      expect(AMP4e.Utils.stringToList({})).to.be.empty
      expect(AMP4e.Utils.stringToList([])).to.be.empty

    it 'returns the original value if it is not string', ->
      expect(AMP4e.Utils.stringToList({name: 'des'})).to.eql({name: 'des'})


  describe 'deepCopy', ->

    it 'returns the given argument if the argument is null', ->
      expect(AMP4e.Utils.deepCopy(null)).to.eql(null)
      expect(AMP4e.Utils.deepCopy(undefined)).to.eql(undefined)
      expect(AMP4e.Utils.deepCopy([])).to.eql([])
      expect(AMP4e.Utils.deepCopy({})).to.eql({})

    it 'returns the given argument if the argument is not an object', ->
      expect(AMP4e.Utils.deepCopy('some.string')).to.eql('some.string')

    it 'returns an shallow copy of given object', ->
      obj = {name: 'des'}
      straightCopy = obj
      straightCopy.name = 'subashis'
      expect(obj.name).to.eql('subashis')

      clone = AMP4e.Utils.deepCopy(obj)
      clone.name = 'des'
      expect(clone.name).to.eql('des')
      expect(obj.name).to.eql('subashis')


  describe 'format', ->
    it 'formats strings', ->
      expect(AMP4e.Utils.format("is too short (minimum is {0})", 5)).to.eql("is too short (minimum is 5)")


  describe 'camelCaseToUnderscore', ->

    it 'converts camelcase to underscore format', ->
      expect(AMP4e.Utils.camelCaseToUnderscore('NotificationAnnouncement')).to.eql('notification_announcement')

    it 'converts camelcase to another format', ->
      expect(AMP4e.Utils.camelCaseToUnderscore('NotificationAnnouncement', '-')).to.eql('notification-announcement')


  describe 'toLowerCase', ->
    it 'converts mixed case to lower case', ->
      expect(AMP4e.Utils.toLowerCase('toLowerCase')).to.eql('tolowercase')

    it 'returns original argument if not a string', ->
      expect(AMP4e.Utils.toLowerCase(1234)).to.eql(1234)


  describe 'capitalizeFirstLetter', ->
    it 'capitalizes first letter of sentence', ->
      expect(AMP4e.Utils.capitalizeFirstLetter('first letter of sentence should be capitalized')).to.eql('First letter of sentence should be capitalized')

    it 'does not change capital first letter', ->
      expect(AMP4e.Utils.capitalizeFirstLetter('Already capital')).to.eql('Already capital')

    it 'does not fail for empty string', ->
      expect(AMP4e.Utils.capitalizeFirstLetter('')).to.eql('')


  describe 'replaceAll', ->
    it 'replaces all occurrences in string', ->
      expect(AMP4e.Utils.replaceAll('http://url?a=b&AMP4e;c=d&AMP4e;e=f&AMP4e;g=h', '&AMP4e;', '&')).to.eql('http://url?a=b&c=d&e=f&g=h')

    it 'does not replace anything when substring not found', ->
      expect(AMP4e.Utils.replaceAll('some string with some words', 'another', 'string')).to.eql('some string with some words')

    it 'does not replace anything when substring is not string', ->
      expect(AMP4e.Utils.replaceAll('this is string', 1, 2)).to.eql('this is string')

  describe 'tokenKeys', ->

    it 'gets the unique keys embedded in a string', ->
      string = "If you're planning to {verb}, you should {verb} soon, or {consequence}"
      tokens = AMP4e.Utils.tokenKeys(string, '{', '}')
      expect(tokens).to.eql ['verb', 'consequence']


  describe 'parameterize', ->

    it 'replaces spaces and special characters with a hyphen', ->
      expect(AMP4e.Utils.parameterize('john roderick')).to.eql 'john-roderick'

    # using `$` here also confirms the regex is properly escaped
    it 'replaces spaces and special characters with a custom separator', ->
      expect(AMP4e.Utils.parameterize('john roderick', separator: '$')).to.eql 'john$roderick'

    it 'trims extra separators from the start and end', ->
      expect(AMP4e.Utils.parameterize('$john roderick?')).to.eql 'john-roderick'

    it 'trims extra adjacent separators', ->
      expect(AMP4e.Utils.parameterize('john   roderick')).to.eql 'john-roderick'

    it 'converts characters to lowercase', ->
      expect(AMP4e.Utils.parameterize('John Roderick')).to.eql 'john-roderick'

    it 'preserves case when the option is set', ->
      expect(AMP4e.Utils.parameterize('John Roderick', preserveCase: true)).to.eql 'John-Roderick'


  describe 'parseUrl', ->

    url = 'http://exAMP4ele.com:12345/path/to/resource?search=search%20term&option=5'

    it 'returns the base URL', ->
      expect(AMP4e.Utils.parseUrl(url).baseURL).to.eql 'http://exAMP4ele.com:12345/path/to/'

    it 'returns the document', ->
      expect(AMP4e.Utils.parseUrl(url).document).to.eql 'resource'

    it 'returns the domain', ->
      expect(AMP4e.Utils.parseUrl(url).domain).to.eql 'exAMP4ele.com'

    it 'returns the fullUrl', ->
      expect(AMP4e.Utils.parseUrl(url).fullUrl).to.eql url

    it 'returns the current parameters as a query string', ->
      theUrl = AMP4e.Utils.parseUrl(url)
      delete theUrl.params.option
      expect(theUrl.getQueryString()).to.eql 'search=search%20term'

    it 'returns the query string as an object', ->
      expect(AMP4e.Utils.parseUrl(url).params).to.eql
        search: 'search term'
        option: '5'

    it 'decodes + as spaces in parameters', ->
      expect(AMP4e.Utils.parseUrl('http://exAMP4ele.com/page?key+with+spaces=find+the+thing').params).to.eql {'key with spaces': 'find the thing'}

    it 'returns multi-value parameters as an array', ->
      expect(AMP4e.Utils.parseUrl('http://exAMP4ele.com/page?id%5B%5D=5&id%5B%5D=12').params).to.eql {id: ['5','12']}

    it 'returns the components of the path', ->
      expect(AMP4e.Utils.parseUrl(url).pathParts).to.eql ['path', 'to']

    it 'returns the port', ->
      expect(AMP4e.Utils.parseUrl(url).port).to.eql 12345

    it 'returns the protocol', ->
      expect(AMP4e.Utils.parseUrl(url).protocol).to.eql 'http'

    it 'returns the query', ->
      expect(AMP4e.Utils.parseUrl(url).query).to.eql 'search=search%20term&option=5'

    it 'returns the route', ->
      expect(AMP4e.Utils.parseUrl(url).route).to.eql '/path/to/resource?search=search%20term&option=5'


  describe 'pathVar', ->

    object = null

    beforeEach ->
      object =
        top: 'one'
        more:
          stuff: ['a','b']

    it 'gets the value of a shallow object reference', ->
      expect(AMP4e.Utils.pathVar(object, 'top')).to.eql object.top

    it 'gets the value of a deep object reference', ->
      expect(AMP4e.Utils.pathVar(object, 'more.stuff')).to.eql object.more.stuff

    it 'sets the value of a shallow object reference', ->
      AMP4e.Utils.pathVar(object, 'top', 'two')
      expect(object.top).to.eql 'two'

    it 'sets the value of a deep object reference', ->
      AMP4e.Utils.pathVar(object, 'more.stuff', 5)
      expect(object.more.stuff).to.eql 5

    it "returns undefined if a reference doesn't exist", ->
      expect(AMP4e.Utils.pathVar(object, 'non.existent.path')).to.eql undefined


  describe 'sum', ->
    it 'returns the sum of an array', ->
      expect(AMP4e.Utils.sum([1,2,3])).to.eql 6

    context 'if the argument is not an array', ->

      consoleErrorStub = null

      beforeEach ->
# stub this so we don't litter the actual console while running tests
        consoleErrorStub = sinon.stub(window.console, 'error')

      afterEach ->
        consoleErrorStub.restore()

      it 'returns undefined', ->
        expect(AMP4e.Utils.sum('derp')).to.eql undefined

      it 'writes to console.error', ->
        AMP4e.Utils.sum('derp')
        expect(consoleErrorStub.calledOnce).to.eql true


  describe 'typeOf', ->

    it "returns {} → 'object'", ->
      expect(AMP4e.Utils.typeOf {}).to.eql 'object'

    it "returns [] → 'array'", ->
      expect(AMP4e.Utils.typeOf []).to.eql 'array'

    it "returns '' → 'string'", ->
      expect(AMP4e.Utils.typeOf '').to.eql 'string'

    it "returns 1 → 'number'", ->
      expect(AMP4e.Utils.typeOf 1).to.eql 'number'

    it "returns // → 'regexp'", ->
      expect(AMP4e.Utils.typeOf(/xx/)).to.eql 'regexp'

    it "returns true → 'boolean'", ->
      expect(AMP4e.Utils.typeOf true).to.eql 'boolean'


  describe 'isEmail', ->

    context 'valid emails', ->
      valid_emails = ["a+b@plus-in-local.com",
        "a_b@underscore-in-local.com",
        "user@exAMP4ele.com",
        " user@exAMP4ele.com ",
        "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ@letters-in-local.org",
        "01234567890@numbers-in-local.net",
        "a@single-character-in-local.org",
        "one-character-third-level@a.exAMP4ele.com",
        "single-character-in-sld@x.org",
        "local@dash-in-sld.com",
        "letters-in-sld@123.com",
        "one-letter-sld@x.org",
        "uncommon-tld@sld.museum",
        "uncommon-tld@sld.travel",
        "uncommon-tld@sld.mobi",
        "country-code-tld@sld.uk",
        "country-code-tld@sld.rw",
        "local@sld.newTLD",
        "local@sub.domains.com",
        "aaa@bbb.co.jp",
        "nigel.worthington@big.co.uk",
        "f@c.com",
        "areallylongnameaasdfasdfasdfasdf@asdfasdfasdfasdfasdf.ab.cd.ef.gh.co.ca"]

      for email in valid_emails
        do (email) ->
          it "considers #{email} to be valid", ->
            expect(AMP4e.Utils.isEmail(email)).to.eql(true)

    context 'invalid emails', ->
      invalid_emails = [
        "",
        "a",
        "a@",
        "a@b.",
        "f@s",
        "f@s.c",
        "@bar.com",
        "test@exAMP4ele.com@exAMP4ele.com",
        "test@",
        "@missing-local.org",
        "a b@space-in-local.com",
        "! \#$%\`|@invalid-characters-in-local.org",
        "<>@[]\`|@even-more-invalid-characters-in-local.org",
        "missing-sld@.com",
        "invalid-characters-in-sld@! \"\#$%(),/;<>_[]\`|.org",
        "missing-dot-before-tld@com",
        "missing-tld@sld.",
        " ",
        "missing-at-sign.net",
        "unbracketed-IP@127.0.0.1",
        "invalid-ip@127.0.0.1.26",
        "another-invalid-ip@127.0.0.256",
        "IP-and-port@127.0.0.1:25",
        "the-local-part-is-invalid-if-it-is-longer-than-sixty-four-characters@sld.net",
        "user@exAMP4ele.com\n<script>alert('hello')</script>"
      ]

      for email in invalid_emails
        do (email) ->
          it "considers #{email} to be invalid", ->
            expect(AMP4e.Utils.isEmail(email)).to.eql(false)


  describe 'isUrl', ->
# https://github.com/jquery-validation/jquery-validation/blob/master/test/methods.js

    context 'valid urls', ->
      valid_urls = [
        "http://bassistance.de/jquery/plugin.php?bla=blu",
        "https://bassistance.de/jquery/plugin.php?bla=blu",
        "http://www.føtex.dk/",
        "http://bösendorfer.de/",
        "http://142.42.1.1"
      ]

      for url in valid_urls
        do (url) ->
          it "considers #{url} to be valid", ->
            expect(AMP4e.Utils.isUrl(url)).to.eql(true)

    context 'invalid urls', ->
      invalid_urls = [
        "htp://code.jquery.com/jquery-1.11.3.min.js",
        "http://192.168.8.",
        "http://bassistance",
        "http://bassistance.",
        "http://bassistance,de",
        "http://bassistance;de",
        "http://.bassistancede",
        "bassistance.de"
      ]

      for url in invalid_urls
        do (url) ->
          it "considers #{url} to be invalid", ->
            expect(AMP4e.Utils.isEmail(url)).to.eql(false)