//
//  SLApplicationBundle.h
//  SimLink
//
//  Created by Iska on 14/03/14.
//  Copyright (c) 2014 BrainCookie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLApplicationBundle : NSObject

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *version;
@property (nonatomic, readonly) NSString *identifier;
@property (nonatomic, readonly) NSString *size;
@property (nonatomic, readonly) NSImage *icon;
@property (nonatomic, readonly, getter = isSystemApplication) BOOL systemApplication;

- (instancetype)initWithApplicationDirectoryPath:(NSString *)path;

@end
