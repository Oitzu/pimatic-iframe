# iframe configuration options
module.exports = {
	title: "iframe"
	iframeDevice :{
		title: "Plugin Properties"
		type: "object"
		extensions: ["xLink"]
		properties:
			url:
				description: "URL of iframe"
				type: "string"       
			width:
				description: "Width of iframe"
				type: "number"
				default : 340
			height:
				description: "Height of iframe"
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
	}
}
