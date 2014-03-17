//
//  SLSimulatorRemoteClient.h
//  SimLink
//
//  Created by Iska on 16/03/14.
//  Copyright (c) 2014 BrainCookie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DTiPhoneSimulatorRemoteClient.h"

@interface SLSimulatorRemoteClient : NSObject <DTiPhoneSimulatorSessionDelegate>

+ (instancetype)sharedClient;

- (void)launchApplicationAtPath:(NSString *)path;

@end
