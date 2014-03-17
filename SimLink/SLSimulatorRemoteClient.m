//
//  SLSimulatorRemoteClient.m
//  SimLink
//
//  Created by Iska on 16/03/14.
//  Copyright (c) 2014 BrainCookie. All rights reserved.
//

#import "SLSimulatorRemoteClient.h"

#define XCODE_DIR				@"/Applications/Xcode.app/Contents"
#define FOUNDATION_FRAMEWORK	@"SharedFrameworks/DVTFoundation.framework"
#define DEV_TOOLS_FRAMEWORK		@"OtherFrameworks/DevToolsFoundation.framework"
#define SIMULATOR_FRAMEWORK		@"Developer/Platforms/iPhoneSimulator.platform/Developer/Library/PrivateFrameworks/DVTiPhoneSimulatorRemoteClient.framework"

@class DVTPlatform;
@class DTiPhoneSimulatorApplicationSpecifier;
@class DTiPhoneSimulatorSession;
@class DTiPhoneSimulatorSessionConfig;
@class DTiPhoneSimulatorSystemRoot;
@class DVTiPhoneSimulatorMessenger;

@interface DVTPlatform : NSObject

+ (BOOL)loadAllPlatformsReturningError:(NSError **)error;

@end

@interface SLSimulatorRemoteClient ()
{

}

- (void)loadFrameworks;
- (void)loadAllPlatforms;

@end

@implementation SLSimulatorRemoteClient

+ (instancetype)sharedClient
{
	static SLSimulatorRemoteClient *singleton = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		singleton = [[self alloc] init];
	});
	return singleton;
}

- (id)init
{
	self = [super init];
	if (self) {
		[self loadFrameworks];
		[self loadAllPlatforms];
	}
	return self;
}

- (void)loadFrameworks
{
	NSString *foundationFrameworkPath = [XCODE_DIR stringByAppendingPathComponent:FOUNDATION_FRAMEWORK];
	NSBundle *foundationFrameworkBundle = [NSBundle bundleWithPath:foundationFrameworkPath];
	if ([foundationFrameworkBundle load] == NO) {
		NSLog(@"Error loading DVTFoundation.framework");
		return;
	}

	NSString *devToolsFrameworkPath = [XCODE_DIR stringByAppendingPathComponent:DEV_TOOLS_FRAMEWORK];
	NSBundle *devToolsFrameworkBundle = [NSBundle bundleWithPath:devToolsFrameworkPath];
	if ([devToolsFrameworkBundle load] == NO) {
		NSLog(@"Error loading DevToolsFoundation.framework");
		return;
	}

	NSString *simulatorFrameworkPath = [XCODE_DIR stringByAppendingPathComponent:SIMULATOR_FRAMEWORK];
	NSBundle *simulatorFrameworkBundle = [NSBundle bundleWithPath:simulatorFrameworkPath];
	if ([simulatorFrameworkBundle load] == NO) {
		NSLog(@"Error loading DVTiPhoneSimulatorRemoteClient.framework");
		return;
	}
}

- (void)loadAllPlatforms
{
    Class dvtPlatformClass = NSClassFromString(@"DVTPlatform");
	if (dvtPlatformClass == nil) {
		NSLog(@"Error loading DVTPlatform class");
		return;
	}

	NSError *error = nil;
	[dvtPlatformClass loadAllPlatformsReturningError:&error];
	if (error) {
		NSLog(@"Failed to load all platforms: %@", [error debugDescription]);
		return;
	}
}

- (void)launchApplicationAtPath:(NSString *)path
{
	DTiPhoneSimulatorApplicationSpecifier *applicationSpecifier = [NSClassFromString(@"DTiPhoneSimulatorApplicationSpecifier")  specifierWithApplicationPath:path];
    if (applicationSpecifier == nil) {
		NSLog(@"Error loading application specifier");
		return;
	}

    DTiPhoneSimulatorSystemRoot *defaultSdkRoot = [NSClassFromString(@"DTiPhoneSimulatorSystemRoot") defaultRoot];

    DTiPhoneSimulatorSessionConfig *sessionConfig = [NSClassFromString(@"DTiPhoneSimulatorSessionConfig") new];
    [sessionConfig setApplicationToSimulateOnStart:applicationSpecifier];
    [sessionConfig setSimulatedSystemRoot:defaultSdkRoot];
	[sessionConfig setSimulatedDeviceFamily:@(2)];
	[sessionConfig setSimulatedDeviceInfoName:@"iPad"];
    [sessionConfig setSimulatedApplicationShouldWaitForDebugger:NO];

    DTiPhoneSimulatorSession *session = [NSClassFromString(@"DTiPhoneSimulatorSession") new];
    [session setDelegate:self];

    NSError *error;
    if (![session requestStartWithConfig:sessionConfig timeout:30 error:&error]) {
		NSLog(@"Error starting session: %@", [error debugDescription]);
	}
}

#pragma mark - Session Delegate (DTiPhoneSimulatorSessionDelegate)

- (void)session:(DTiPhoneSimulatorSession *)session didStart:(BOOL)started withError:(NSError *)error
{
	NSLog(@"Session Started");
}

- (void)session:(DTiPhoneSimulatorSession *)session didEndWithError:(NSError *)error
{
	NSLog(@"Session Error");
}

@end
