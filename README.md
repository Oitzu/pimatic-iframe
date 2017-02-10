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
Please have a look at the Trouble Shooting section below if the content isn't displayed or reloaded properly.

    {
      "class": "iframeDevice",
      "id" : "my_iframe",
      "name": "My iframe",
      "url": "http://www.pimatic.org",
      "width": 340,
      "unit": "px"
      "height": 240,
      "border": 1,
      "scrolling": "yes",
      "scale": 1,
      "reload": 0,
      "enforceReload": false
    },

Description:
-------------

    class : device class
    id : should be your unique device id
    name : name of your device

    url : URL that will be displayed in the iframe
    width : Width of iframe
    unit: Unit of witdth specification (px, %)
    height : Height of iframe
    border : Show border around iframe (1 = yes, 0 = no)
    scrolling : Show scrollbars in iframe (yes/no)
    scale : Scaling factor of iframe content
    reload : Reload cycle in seconds for iframe source. 0 = no reload
    enforceReload : Add a pseudo URL param to make URL unique. This is to solve browser-caching issues

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
    
If the iframe content is not properly reloaded or updated this may be due to browser-caching issues:

* Normally, the browser avoids reloading web content from the server by serving web resources from its local 
  cache to speed up web browsing, significantly. To facilitate caching, the HTTP protocol includes various 
  mechanisms to support the browser in determining the lifetime of a (cached) web resource and to let the browser 
  querying the server if a given web resource has been changed. This works very well most of the time, but 
  there are cases where web servers have been misconfigured or the server implementation does not support 
  cache-control. As a result the iframe content may not be reloaded properly as it will always be served from the 
  browser-cache rather than requesting the (updated) content from the server. In particular, this has been found 
  to be case with some IP web camera applications where the web content typically is an image file being continuously 
  updated by the server. In such cases you can set `enforceReload` property to `true`.  This will add a query 
  parameter with a timestamp for each reload cycle to make the requested URL unique. As a result the browser will 
  regard the given URL as a new resource and bypass the cache.

Version History
---------------
    0.0.1 : Initial release
    0.0.2 : Adding border and scrolling options
    0.0.3 : Adding scaling factor
    0.0.4 : Adding reload
    0.1.0 : Added better browser compatibility and load action provider.
    0.1.1 : Fixing missing file issue #4
    0.1.2 : Fixing infinity refresh on missing refresh value #6
    0.1.3 : Fix for Pimatic 0.9
    0.2.0 : enforeReload added. (Thx to @mwittig)
