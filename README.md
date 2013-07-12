# Game Closure DevKit Plugin: TradeMob

This plugin allows you to collect analytics using the [TradeMob](https://trademob.atlassian.net/wiki/display/public/Trademob+Wiki+Homepage) toolkit.  Both iOS and Android targets are supported.

## Usage

Install the addon with `basil install trademob`.

Include it in the `manifest.json` file under the "addons" section for your game:

~~~
"addons": [
	"trademob"
],
~~~

To specify your game's Tracking ID, edit the `manifest.json "android" and "ios" sections as shown below:

~~~
	"android": {
		"versionCode": 1,
		"icons": {
			"36": "resources/icons/android36.png",
			"48": "resources/icons/android48.png",
			"72": "resources/icons/android72.png",
			"96": "resources/icons/android96.png"
		}
	},
~~~

~~~
	"ios": {
		"bundleID": "mmp",
		"appleID": "568975017",
		"version": "1.0.3",
		"icons": {
			"57": "resources/images/promo/icon57.png",
			"72": "resources/images/promo/icon72.png",
			"114": "resources/images/promo/icon114.png",
			"144": "resources/images/promo/icon144.png"
		}
	},
~~~

Note that the manifest keys are case-sensitive.

To use TradeMob tracking in your game, import the trademob object:

~~~
import plugins.trademob.tradeMob as tradeMob;
~~~

Then send individual track events like this:

~~~
tradeMob.track("myEvent", {
	"score": 999,
	"coins": 11,
	"isRandomParameter": true
});
~~~

Your events will be tracked as "always" events with action = event name, and a JSON string of the event data in the subId.

You can test for successful integration via the [TradeMob](https://trademob.atlassian.net/wiki/display/public/Trademob+Wiki+Homepage) website after successfully building and running your game on a network-connected device.  Also check the console for helpful debug messages.

You should see console logs like this:

~~~
2013-07-11 19:14:43.593 mmp[1597:907] TrademobUniversalSDK: Successfully tracked custom event.
~~~
