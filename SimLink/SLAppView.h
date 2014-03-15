//
//  SLAppView.h
//  SimLink
//
//  Created by Iska on 10/03/14.
//  Copyright (c) 2014 BrainCookie. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SLAppView : NSView

- (id)initWithName:(NSString *)name
		identifier:(NSString *)identifier
		   version:(NSString *)version
			  size:(NSString *)size
		   andIcon:(NSImage *)icon;

@end
