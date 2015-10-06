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

Troubleshooting
-------------

If the iframe content is not displayed the reason maybe one of the following *security restrictions*:

* Pimatic web page has been loaded via https while iframe source is http. This will give you an error message on the
  web console as shown below. *Workaround:* Either load pimatic page via http or load iframe src via https (if https
  is supported by the site).

    ```
    Mixed Content: The page at 'https://localhost/' was loaded over HTTPS, but requested an insecure
    resource 'http://www.pimatic.org'. This request has been blocked; the content must be served over HTTPS.
    ```

* Sourced web site denies embedding. This is the case with google.com, for example. Workaround: Some sites offer
  additional resources which can be embedded, for example, this is the case
  for [googlemaps](https://developers.google.com/maps/documentation/embed/guide). Otherwise, you can only
  circumvent the restriction by putting a rewriting http proxy into the communication path.

    ```
    Refused to display 'https://www.google.de/?gfe_rd=cr&ei=7wgIVuiXCY6r8wfYkLnoDQ&gws_rd=ssl'
    in a frame because it set 'X-Frame-Options' to 'SAMEORIGIN'.
    ```

Version History
---------------
    0.0.1 : Initial release
    0.0.2 : Adding border and scrolling options
    0.0.3 : Adding scaling factor
    0.0.4 : Adding reload
    0.1.0 : Added better browser compatibility and load action provider.
    0.1.1 : Fixing missing file issue #4
    0.1.2 : Fixing infinity refresh on missing refresh value #6