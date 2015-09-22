pimatic-uframe
=======================

This is [Pimatic](http://pimatic.org) plugin for iframes.
You can develop, edit and contribute for this plugin by forking this plugin in [github](https://github.com/Oitzu/pimatic-iframe)

Installation
-------------
Add this plugin by go to Pimatic apps Plugin menu

Add the plugin to the plugin section:

    {
      "plugin": "iframe"
    },

Configuration
-------------

You have to add a iframe Device device into your config.json based on these example schema ready to copy paste.

    {
      "class": "iframeDevice"
      "id" : "my_iframe",
      "name": "My iframe",
      "url": "http://www.google.com",
      "width": 340,
      "height": 240
    },

Description:
-------------

    class : device class
    id : should be your unique device id
    name : name of your device

    url : url that will be displayed in the iframe
    width : width of iframe
    Height : hight of iframe

Version History
---------------
    0.0.1 : Initial release