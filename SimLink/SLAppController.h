//
//  SLAppController.h
//  SimLink
//
//  Created by Iska on 09/03/14.
//  Copyright (c) 2014 BrainCookie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLAppController : NSObject
{
	IBOutlet NSMenu *_statusMenu;
	NSStatusItem *_statusItem;
}

- (IBAction)hello:(id)sender;

@end
