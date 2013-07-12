#import "TradeMobPlugin.h"

@implementation TradeMobPlugin

// The plugin must call super dealloc.
- (void) dealloc {
	[super dealloc];
}

// The plugin must call super init.
- (id) init {
	self = [super init];
	if (!self) {
		return nil;
	}

	return self;
}

- (void) initializeWithManifest:(NSDictionary *)manifest appDelegate:(TeaLeafAppDelegate *)appDelegate {
	@try {
		NSString *shortName = [manifest valueForKey:@"shortName"];
		[TMUniversalTracking startWithURLScheme:shortName];

		[TMUniversalTracking debugMode];

		NSLog(@"{tradeMob} Initialized with manifest shortName: '%@'", shortName);
	}
	@catch (NSException *exception) {
		NSLog(@"{tradeMob} Failure to get shortName key from manifest file: %@", exception);
	}
}

- (void) handleOpenURL:(NSURL *)url {
	NSLog(@"{tradeMob} Tracking open URL '%@'", url);

	[TMUniversalTracking trackOpenURL:url];
}

- (void) track:(NSDictionary *)jsonObject {
	@try {
		NSString *eventName = [jsonObject valueForKey:@"eventName"];

		NSDictionary *evtParams = [jsonObject objectForKey:@"params"];

		NSString *jsonString = [evtParams JSONString];

		[TMUniversalTracking trackActionAlways:eventName forValue:0 andSubId:jsonString];

		NSLOG(@"{tradeMob} Delivered event '%@' : subId=%@", eventName, jsonString);
	}
	@catch (NSException *exception) {
		NSLOG(@"{tradeMob} Exception while processing event: ", exception);
	}
}

@end
