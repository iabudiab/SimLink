//
//  SLAppView.h
//  SimLink
//
//  Created by Iska on 10/03/14.
//  Copyright (c) 2014 BrainCookie. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol SLAppViewDelegate;

@interface SLAppView : NSView
{
	__weak id<SLAppViewDelegate> _delegate;
}

@property (nonatomic, weak) id<SLAppViewDelegate> delegate;

- (id)initWithName:(NSString *)name
		identifier:(NSString *)identifier
		   version:(NSString *)version
			  size:(NSString *)size
		   andIcon:(NSImage *)icon;

@end

@protocol SLAppViewDelegate <NSObject>

- (void)appViewClicked:(SLAppView *)appView;

@end
