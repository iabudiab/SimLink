//
//  SLMenuItem.m
//  SimLink
//
//  Created by Iska on 13/03/14.
//  Copyright (c) 2014 BrainCookie. All rights reserved.
//

#import "SLMenuItem.h"
#import "SLAppView.h"

@interface SLMenuItem ()
{
	NSString *_applicationDirectory;
}

- (void)setup;

@end

@implementation SLMenuItem

- (id)initWithApplicationDirectoryPath:(NSString *)path
{
	self = [super initWithTitle:@"" action:nil keyEquivalent:@""];
	if (self) {
		_applicationDirectory = path;
		[self setup];
	}
	return self;
}

- (void)setup
{
	self.view = [[SLAppView alloc] initWithAppBundlePath:_applicationDirectory];
}

@end
