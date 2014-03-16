//
//  SLAppView.m
//  SimLink
//
//  Created by Iska on 10/03/14.
//  Copyright (c) 2014 BrainCookie. All rights reserved.
//

#import "SLAppView.h"

#define VIEW_FRAME		CGRectMake(0, 0, 320, 56)
#define ICON_FRAME		CGRectMake(5, 1, 54, 54)
#define TITLE_FRAME		CGRectMake(80, 4, 230, 18)
#define BUNDLE_FRAME	CGRectMake(80, 22, 230, 18)
#define SIZE_FRAME		CGRectMake(80, 40, 230, 18)

@interface SLAppView ()
{
	NSImageView *_imageView;
	NSTextField *_titleView;
	NSTextField *_bundleView;
	NSTextField *_sizeView;
	NSTrackingArea *_trackingArea;
	BOOL _highlighted;
}

- (void)applyTextViewSettings:(NSTextField *)field;
- (void)applyTextViewsHighlightStatus;

@end

@implementation SLAppView
@synthesize delegate = _delegate;

#pragma mark - Lifecycle

- (id)initWithName:(NSString *)name
			identifier:(NSString *)identifier
			   version:(NSString *)version
				  size:(NSString *)size
			   andIcon:(NSImage *)icon
{
	self = [super initWithFrame:VIEW_FRAME];
	if (self) {
		_titleView = [[NSTextField alloc] initWithFrame:TITLE_FRAME];
		[self applyTextViewSettings:_titleView];
		_titleView.stringValue = [NSString stringWithFormat:@"%@ (%@)", name, version];
		[self addSubview:_titleView];

		_bundleView = [[NSTextField alloc] initWithFrame:BUNDLE_FRAME];
		[self applyTextViewSettings:_bundleView];
		_bundleView.stringValue = identifier;
		[self addSubview:_bundleView];

		_sizeView = [[NSTextField alloc] initWithFrame:SIZE_FRAME];
		[self applyTextViewSettings:_sizeView];
		_sizeView.stringValue = size;
		[self addSubview:_sizeView];

		_imageView = [[NSImageView alloc] initWithFrame:ICON_FRAME];
		_imageView.wantsLayer = YES;
		_imageView.layer.cornerRadius = 12.0f;
		_imageView.image = icon ? icon : [NSImage imageNamed:@"simulator"];
		[self addSubview:_imageView];
	}
	return self;
}

- (void)applyTextViewSettings:(NSTextField *)field
{
	[field setDrawsBackground:NO];
	[field setBezeled:NO];
	[field setBordered:NO];
	[field setEditable:NO];
	[field setAlignment:NSRightTextAlignment];
	[field setFont:[NSFont systemFontOfSize:11]];
	[field.cell setUsesSingleLineMode:YES];
	[field.cell setLineBreakMode:NSLineBreakByTruncatingMiddle];
}

- (void)applyTextViewsHighlightStatus
{
	[_titleView setTextColor:_highlighted ? [NSColor whiteColor] : [NSColor blackColor]];
	[_bundleView setTextColor:_highlighted ? [NSColor whiteColor] : [NSColor blackColor]];
	[_sizeView setTextColor:_highlighted ? [NSColor whiteColor] : [NSColor blackColor]];
}

#pragma mark - Mouse Events

- (void)updateTrackingAreas
{
    if(_trackingArea != nil) {
        [self removeTrackingArea:_trackingArea];
    }

    int opts = (NSTrackingMouseEnteredAndExited | NSTrackingActiveAlways);
    _trackingArea = [ [NSTrackingArea alloc] initWithRect:[self bounds]
												  options:opts
													owner:self
												 userInfo:nil];
    [self addTrackingArea:_trackingArea];
}

- (void)mouseEntered:(NSEvent *)theEvent
{
	_highlighted = YES;
	[self applyTextViewsHighlightStatus];
	[self setNeedsDisplay:YES];
}

- (void)mouseExited:(NSEvent *)theEvent
{
	_highlighted = NO;
	[self applyTextViewsHighlightStatus];
	[self setNeedsDisplay:YES];
}

- (void)mouseDown:(NSEvent *)theEvent
{
	if ([_delegate respondsToSelector:@selector(appViewClicked:)]) {
		[_delegate appViewClicked:self];
	}
}

#pragma mark - Drawing

- (void)drawRect:(NSRect)rect;
{
    if (_highlighted) {
        [[NSColor selectedMenuItemColor] set];
        [NSBezierPath fillRect:rect];
    } else {
        [super drawRect: rect];
    }
}

#pragma mark - Flip Coordinates

- (BOOL)isFlipped
{
	return YES;
}

@end
