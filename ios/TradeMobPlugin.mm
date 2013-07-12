#import "TradeMobPlugin.h"
#import "JSONKit.h"
#import <CommonCrypto/CommonDigest.h>


@interface NSString(hashMD5)

- (NSString *)hashMD5;

@end


@interface NSString(hashSHA1)

- (NSString *)hashSHA1;

@end


@implementation NSString(hashMD5)

- (NSString *)hashMD5 {
	// Create pointer to the string as UTF8
	const char *ptr = [self UTF8String];
	
	// Create byte array of unsigned chars
	unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
	
	// Create 16 byte MD5 hash value, store in buffer
	CC_MD5(ptr, strlen(ptr), md5Buffer);
	
	// Convert MD5 value in the buffer to NSString of hex values
	NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
	for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
		[output appendFormat:@"%02x",md5Buffer[i]];
	
	return output;
}

@end


@implementation NSString(hashSHA1)

- (NSString *)hashSHA1 {
	// Create pointer to the string as UTF8
	const char *ptr = [self UTF8String];
	
	// Create byte array of unsigned chars
	unsigned char sha1Buffer[CC_SHA1_DIGEST_LENGTH];
	
	CC_SHA1(ptr, strlen(ptr), sha1Buffer);
	
	NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
	for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
		[output appendFormat:@"%02x",sha1Buffer[i]];
	
	return output;
}

@end


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

		[TMUniversalTracking disableTrackingFeature:TM_FEATURE_WIFI_SSID];
		[TMUniversalTracking disableTrackingFeature:TM_FEATURE_WIFI_STATE];

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
