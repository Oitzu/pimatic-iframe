$(document).on( "templateinit", (event) ->
  # define the item class
	done = false
	class iframeDeviceItem extends pimatic.DeviceItem
		constructor: (templData, @device) ->
			@id = @device.id
			@frameId = @device.id + "_iframe"
			@name = @device.name
			@url = @device.config.url
			@width = @device.config.width ? @device.configDefaults.width
			@height = @device.config.height ? @device.configDefaults.height
			@border = @device.config.border ? @device.configDefaults.border
			@scrolling = @device.config.scrolling ? @device.configDefaults.scrolling
			@overflow = ko.observable(if @scrolling is 'no' then 'hidden' else 'auto')
			@scale = @device.config.scale ? @device.configDefaults.scale
			@divWidth = Math.round(@width * @scale) + (2 * @border)
			@divHeight = Math.round(@height * @scale) + (2 * @border)
			@reload = @device.config.reload  ? @device.configDefaults.reload
			super(templData,@device)

			attribute = @getAttribute("url")
			@url = ko.observable attribute.value()
			attribute.value.subscribe (newValue) =>
				@url newValue

		afterRender: (elements) ->
			super(elements)
			timeout = null

			resize = =>
				frame = document.getElementById @frameId
#				console.log(
#					$(frame).parent().parent().width(),
#					$(frame).parent().parent().get(0).getBoundingClientRect().width,
#					$(frame).parent().width(),
#					$(frame).parent().get(0).getBoundingClientRect().width,
#					$(frame).width(),
#					$(frame).get(0).getBoundingClientRect().width
#				)
				if (frame? and $(frame).parent().width() >= $(frame).get(0).getBoundingClientRect().width)
					@overflow 'hidden'
				else if @scrolling isnt 'no'
					@overflow 'auto'

			resize()
			# When "resize" is triggered the resize may be still in progress. Thus, the resize function call will be
			# deferred to get proper results for the width of the parent elements. This is also a strategy to
			# de-bounce the resize event as it may be fire multiple times in a row
			# See http://stackoverflow.com/a/5490021/4816693
			window.onresize = =>
				if timeout?
					clearTimeout timeout
					timeout = null
				timeout = setTimeout resize, 750


			# Reload the iframe source periodically if "reload" device property has been set to a value > 0
			# See http://stackoverflow.com/a/4062084/4816693			if @reload > 0
			setInterval ( =>
				frame = document.getElementById @frameId
				frame.src = frame.src if frame?
			), @reload * 1000



	# register the item-class
	pimatic.templateClasses['iframe'] = iframeDeviceItem
)