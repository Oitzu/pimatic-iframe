$(document).on( "templateinit", (event) ->
  # define the item class
	done = false
	class iframeDeviceItem extends pimatic.DeviceItem
		constructor: (templData, @device) ->
			@id = @device.id
			@name = @device.name
			@url = @device.config.url
			@width = @device.config.width  ? @device.configDefaults.width
			@height = @device.config.height ? @device.configDefaults.height
			@border = @device.config.border ? @device.configDefaults.border
			@scrolling = @device.config.scrolling = @device.configDefaults.scrolling
			super(templData,@device)
  
  # register the item-class
	pimatic.templateClasses['iframe'] = iframeDeviceItem
)
