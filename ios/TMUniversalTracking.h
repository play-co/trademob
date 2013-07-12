//
//  TMUniversalTracking.h
//  Universal Tracking-SDK
//
//  Created by Martin Biermann on 09/11/2012.
//  Copyright 2012 Trademob GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

extern const unsigned char TM_FEATURE_IDFA;
extern const unsigned char TM_FEATURE_ODIN1_TRACKING;
extern const unsigned char TM_FEATURE_MAC_ADDRESS_TRACKING;
extern const unsigned char TM_FEATURE_WIFI_STATE;
extern const unsigned char TM_FEATURE_CARRIER_INFO;
extern const unsigned char TM_FEATURE_WIFI_SSID;

@protocol TMUniversalTrackingDelegate <NSObject>

- (void)trackingDidFinishAppLaunch;

@end

@interface TMUniversalTracking : NSObject

/**
 * The initial trigger to start the tracking SDK engine.
 *
 * *IMPORTANT* To be called in
 * [UIApplicationDelegate application:didFinishLaunchingWithOptions:].
 *
 * @param urlScheme The URL Scheme the app has registered for.
 *
 * **IMPORTANT** Make sure your app responds to "<urlScheme>://return" URL
 * (plus any kind of query string) and calls trackOpenURL: upon receiving it.
 */
+ (void)startWithURLScheme:(NSString *)urlScheme;

/**
 * The initial trigger to start the tracking SDK engine.
 * 
 * *IMPORTANT* To be called in 
 * [UIApplicationDelegate application:didFinishLaunchingWithOptions:].
 * 
 * @param urlScheme The URL Scheme the app has registered for.
 * @param id<TMUniversalTrackingDelegate> A delegate object to observe certain 
 *        transitions and states of the tracking as defined in the delegate 
 *        protocol.
 * 
 * **IMPORTANT** Make sure your app responds to "<urlScheme>://return" URL 
 * (plus any kind of query string) and calls trackOpenURL: upon receiving it.
 */
+ (void)startWithURLScheme:(NSString *)urlScheme
               andDelegate:(id<TMUniversalTrackingDelegate>)delegate;

/**
 * Use this method to only track this action on its first hit.
 *
 * @param action identificator for this action
 * @param value int
 * @param subId additional id to differ between similar events if needed
 */
+ (void)trackActionOnce:(NSString*)action
               forValue:(int)value
               andSubId:(NSString*)subId;

/**
 * Use this method when you want to track this action whenever it is hit.
 *
 * @param action identificator for this action
 * @param value int
 * @param subId additional id to differ between similar events if needed
 */
+ (void)trackActionAlways:(NSString*)action
                 forValue:(int)value
                 andSubId:(NSString*)subId;

/**
 * Use this method to track URLs your application opens in [UIApplicationDelegate application:openURL:sourceApplication:annotation:].
 * 
 * **IMPORTANT** Make sure your app responds to "<urlScheme>://return" (plus any kind of query string) and calls
 * this method with that URL.
 * 
 * @param url The actual URL your app opens.
 */
+ (void)trackOpenURL:(NSURL *)url;

/**
 * Turn on SDK debug mode to see additional outputs.
 */
+ (void)debugMode;

/**
 * Turn off a certain SDK feature.
 * Use constants states on the top of this doc to disable the corresponding feature.
 */
+ (void)disableTrackingFeature:(unsigned char)feature;

@end
