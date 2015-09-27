pimatic-iframe
=======================

This is [Pimatic](http://pimatic.org) plugin for iframes.
You can develop, edit and contribute for this plugin by forking this plugin in [github](https://github.com/Oitzu/pimatic-iframe)

Installation
-------------
Add the plugin to the plugin section:

    {
      "plugin": "iframe"
    },

Configuration
-------------

You have to add a iframe Device device into your config.json based on these example schema ready to copy paste.

    {
      "class": "iframeDevice",
      "id" : "my_iframe",
      "name": "My iframe",
      "url": "http://www.pimatic.org",
      "width": 340,
      "height": 240,
      "border": 1,
      "scrolling": "yes",
      "scale": 1,
      "reload": 0
    },

Description:
-------------

    class : device class
    id : should be your unique device id
    name : name of your device

    url : URL that will be displayed in the iframe
    width : Width of iframe
    height : Height of iframe
    border : Show border arround iframe (1 = yes, 0 = no)
    scrolling : Show scrollbars in iframe (yes/no)
    scale : scaling factor of iframe content
    reload : Reload cycle in seconds for iframe source. 0 = no reload

Load Action:
-------------

As part of rules you can use the following action:

* load [the] device with "url"

*Example:*

* load my_iframe with "http://www.pimatic.org"

Version History
---------------
    0.0.1 : Initial release
    0.0.2 : Adding border and scrolling options
    0.0.3 : Adding scaling factor
    0.0.4 : Adding reload
    0.1.0 : Added better browser compatibility and load action provider.