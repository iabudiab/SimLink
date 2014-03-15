//
//  SLMenuItem.h
//  SimLink
//
//  Created by Iska on 13/03/14.
//  Copyright (c) 2014 BrainCookie. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SLAppView.h"

@interface SLMenuItem : NSMenuItem <SLAppViewDelegate>

- (id)initWithApplicationDirectoryPath:(NSString *)path;

@end
