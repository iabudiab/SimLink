//
//  SLMenuItem.h
//  SimLink
//
//  Created by Iska on 13/03/14.
//  Copyright (c) 2014 BrainCookie. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SLAppView.h"

typedef enum {
	SLMenuItemActionDefault	= 0,
	SLMenuItemActionRun		= 1,
	SLMenuItemActionDelete	= 2
} SLMenuItemAction ;

@interface SLMenuItem : NSMenuItem <SLAppViewDelegate>

- (id)initWithApplicationDirectoryPath:(NSString *)path;

- (void)setCurrentAction:(NSNumber *)action;

@end
