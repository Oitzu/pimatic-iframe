module.exports = (env) ->
	Promise = env.require 'bluebird'
	assert = env.require 'cassert'
	iframeActionProvider = require('./iframe-action.coffee')(env)

	class iframePlugin extends env.plugins.Plugin
		init: (app, @framework, @config) =>
			deviceConfigDef = require("./device-config-schema")
			@framework.deviceManager.registerDeviceClass("iframeDevice",{
				configDef : deviceConfigDef.iframeDevice,
				createCallback : (config) => new iframeDevice(config,this)
			})

			@framework.ruleManager.addActionProvider(new iframeActionProvider(@framework))

			@framework.on "after init", =>
				mobileFrontend = @framework.pluginManager.getPlugin 'mobile-frontend'
				if mobileFrontend?
					mobileFrontend.registerAssetFile 'js', "pimatic-iframe/app/iframe-page.coffee"
					mobileFrontend.registerAssetFile 'html', "pimatic-iframe/app/iframe-template.html"
				return
		info: (text) ->
			env.logger.info text
			return
		error: (text) ->
			env.logger.error text
			return
		debug: (text) ->
			env.logger.debug text
			return
		replaceAll: (x,s,r) ->
			return x.split(s).join(r)

	class iframeDevice extends env.devices.Device
		attributes:
			url:
				description: "URL"
				type: "string"
			width:
				description: "Width of the Image"
				type: "number"
				default : 340
			height:
				description: "Height of the Image"
				type: "number"
				default : 240
			border:
				description: "Show border on iframe"
				type: "number"
				default : 1
			scrolling:
				description: "Scrolling on iframe enabled"
				type: "string"
				default : "yes"
			scale:
				description: "Scaling factor for iframe content"
				type: "number"
				default : 1
			reload:
				description: "Reload cycle in seconds for iframe source. 0 = no reload"
				type: "number"
				default : 0
		actions:
			loadIFrameWith:
				description: 'loads the iframe with a new source URL'
		template: 'iframe'

		constructor: (@config,@plugin) ->
			@id = @config.id
			@name = @config.name
			@url = @config.url
			@width = @config.width
			@height = @config.height
			@border = @config.border
			@scrolling = @config.scrolling
			@scale = @config.scale
			@reload = @config.reload
			super()

		loadIFrameWith: (url) ->
			unless @url is url
				@url = url
				@emit "url", url
			return Promise.resolve()

		getWidth: -> Promise.resolve(@width)
		getHeight: -> Promise.resolve(@height)
		getUrl: -> Promise.resolve(@url)
		getBorder: -> Promise.resolve(@border)
		getScrolling: -> Promise.resolve(@scrolling)
		getScale: -> Promise.resolve(@scale)
		getReload: -> Promise.resolve(@reload)


	myPlugin = new iframePlugin
	return myPlugin
