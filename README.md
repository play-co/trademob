# Game Closure DevKit Plugin: TradeMob

This plugin allows you to collect analytics using the [TradeMob](http://www.trademob.com/) toolkit.  Both iOS and Android targets are supported.

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

You can test for successful integration via the [TradeMob](http://www.trademob.com/) website after successfully building and running your game on a network-connected device.  Also check the console for helpful debug messages.

You should see console logs like this:

~~~
E/JS      ( 5978): {googleAnalytics} Initializing from manifest with googleTrackingID= UA-42399544-1

…

D/JS      ( 5978): LOG plugins.googleanalytics.googleAnalytics {googleAnalytics} track:  AppStart [object Object]
E/JS      ( 5978): {googleAnalytics} track - success: category= AppStart action='JSON' label= {"paramTest1":"valueTest1","paramTest2":"valueTest2"}
D/JS      ( 5978): LOG plugins.googleanalytics.googleAnalytics {googleAnalytics} track:  UpgradePriceGroup [object Object]
E/JS      ( 5978): {googleAnalytics} track - success: category= UpgradePriceGroup action= priceGroup label= B_CHEAPER
~~~
