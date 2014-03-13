//
//  SLAppView.m
//  SimLink
//
//  Created by Iska on 10/03/14.
//  Copyright (c) 2014 BrainCookie. All rights reserved.
//

#import "SLAppView.h"

#define VIEW_FRAME		CGRectMake(0, 0, 256, 56)
#define ICON_FRAME		CGRectMake(5, 0, 72, 56)
#define TITLE_FRAME		CGRectMake(80, 4, 168, 18)
#define BUNDLE_FRAME	CGRectMake(80, 22, 168, 18)
#define SIZE_FRAME		CGRectMake(80, 40, 168, 18)

@interface SLAppView ()
{
	NSImageView *_imageView;
	NSTextField *_titleView;
	NSTextField *_bundleView;
	NSTextField *_sizeView;
}

- (void)applyTextViewSettings:(NSTextField *)field;

@end

@implementation SLAppView

- (id)initWithAppBundlePath:(NSString *)path
{
	self = [super initWithFrame:VIEW_FRAME];
	if (self) {
		_imageView = [[NSImageView alloc] initWithFrame:ICON_FRAME];
		[self addSubview:_imageView];

		_titleView = [[NSTextField alloc] initWithFrame:TITLE_FRAME];
		[self applyTextViewSettings:_titleView];
		_titleView.stringValue = [path lastPathComponent];
		[self addSubview:_titleView];	

		_bundleView = [[NSTextField alloc] initWithFrame:BUNDLE_FRAME];
		[self applyTextViewSettings:_bundleView];
		_bundleView.stringValue = [path lastPathComponent];
		[self addSubview:_bundleView];

		_sizeView = [[NSTextField alloc] initWithFrame:SIZE_FRAME];
		[self applyTextViewSettings:_sizeView];
		_sizeView.stringValue = [path lastPathComponent];
		[self addSubview:_sizeView];
	}
	return self;
}

- (void)applyTextViewSettings:(NSTextField *)field
{
	[field setBezeled:NO];
	[field setBordered:NO];
	[field setEditable:NO];
	[field setAlignment:NSRightTextAlignment];
	[field setFont:[NSFont systemFontOfSize:11]];
}

- (BOOL)isFlipped
{
	return YES;
}

@end
