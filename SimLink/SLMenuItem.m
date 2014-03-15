//
//  SLMenuItem.m
//  SimLink
//
//  Created by Iska on 13/03/14.
//  Copyright (c) 2014 BrainCookie. All rights reserved.
//

#import "SLMenuItem.h"
#import "SLAppView.h"
#import "SLApplicationBundle.h"

@interface SLMenuItem ()
{
	NSString *_applicationDirectory;
}

- (void)setupWithPath:(NSString *)path;

@end

@implementation SLMenuItem

- (id)initWithApplicationDirectoryPath:(NSString *)path
{
	self = [super initWithTitle:@"" action:nil keyEquivalent:@""];
	if (self) {
		[self setupWithPath:path];
	}
	return self;
}

- (void)setupWithPath:(NSString *)path
{
	SLApplicationBundle *appBundle = [[SLApplicationBundle alloc] initWithApplicationDirectoryPath:path];

	self.title = appBundle.name;
	self.view = [[SLAppView alloc] initWithName:appBundle.name
									 identifier:appBundle.identifier
										version:appBundle.version
										   size:appBundle.size
										andIcon:appBundle.icon];
}

@end
