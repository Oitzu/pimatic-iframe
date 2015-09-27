module.exports = (env) ->

  assert = env.require 'cassert'
  _ = env.require 'lodash'
  M = env.matcher


  ###
  The iframe Action Provider
  -------------
  Provides the ability to load an iframe devices with a new source:

  * load _device_ with _value_

  where _device_ is the name or id of an iframe device.
  ###
  class iframeActionProvider extends env.actions.ActionProvider

    constructor: (@framework) ->

    # ### parseAction()
    ###
    Parses the above actions.
    ###
    parseAction: (input, context) =>
      # The result the function will return:
      retVar = null

      iframes = _(@framework.deviceManager.devices).values().filter(
        (device) => device.hasAction("loadIFrameWith")
      ).value()

      if iframes.length is 0 then return

      device = null
      valueTokens = null
      match = null

      # Try to match the input string with:
      M(input, context)
      .match('load ')
      .matchDevice(iframes, (next, d) =>
        next.match(' with ')
        .matchStringWithVars( (next, ts) =>
          if device? and device.id isnt d.id
            context?.addError(""""#{input.trim()}" is ambiguous.""")
            return
          device = d
          valueTokens = ts
          match = next.getFullMatch()
        )
      )

      if match?
        return {
        token: match
        nextInput: input.substring(match.length)
        actionHandler: new iframeActionHandler(@framework, device, valueTokens)
        }
      else
        return null

  class iframeActionHandler extends env.actions.ActionHandler

    constructor: (@framework, @device, @valueTokens) ->
      assert @device?
      assert @valueTokens?


    ###
    Handles the above actions.
    ###
    _doExecuteAction: (simulate, value) =>
      return (
        if simulate
          __("would load iframe %s with %s", @device.name, value)
        else
          @device.loadIFrameWith(value).then( => __("load iframe %s with %s", @device.name, value) )
      )

    # ### executeAction()
    executeAction: (simulate) =>
      @framework.variableManager.evaluateStringExpression(@valueTokens).then( (value) =>
        return @_doExecuteAction(simulate, value)
      )

    # ### hasRestoreAction()
    hasRestoreAction: -> no

  return iframeActionProvider