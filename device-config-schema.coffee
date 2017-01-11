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
				type: "object"
				properties:
					unit:
						description: "width unit"
						type: "string"
						default: "px"
						enum: ["px", "%"]
					value:
						description: "actual width value"
						type: "number"
						default: 340		
			height:
				description: "height of iframe"
				type: "object"
				properties:
					unit:
						description: "height unit"
						type: "string"
						default: "px"
						enum: ["px", "%"]
					value:
						description: "actual height value"
						type: "number"
						default: 240		
			border:
				description: "Show border on iframe"
				enum: [0, 1]
				default : 1
			scrolling:
				description: "Scrolling on iframe enabled"
				enum: ["yes", "no"]
				default : "yes"
			scale:
				description: "Scaling factor for iframe content"
				type: "number"
				default : 1
			reload:
				description: "Reload cycle in seconds for iframe source. 0 = no reload"
				type: "number"
				default : 0
			enforceReload:
				description: "Add a pseudo URL param to make URL unique. This is to solve browser-caching issues"
				type: "boolean"
				default: false
	}
}
