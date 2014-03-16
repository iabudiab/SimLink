//
//  SLMenuItemView.h
//  SimLink
//
//  Created by Iska on 10/03/14.
//  Copyright (c) 2014 BrainCookie. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol SLMenuItemViewDelegate;

@interface SLMenuItemView : NSView
{
	__weak id<SLMenuItemViewDelegate> _delegate;
}

@property (nonatomic, weak) id<SLMenuItemViewDelegate> delegate;

- (id)initWithName:(NSString *)name
		identifier:(NSString *)identifier
		   version:(NSString *)version
			  size:(NSString *)size
		   andIcon:(NSImage *)icon;

@end

@protocol SLMenuItemViewDelegate <NSObject>

- (void)appViewClicked:(SLMenuItemView *)appView;

@end
