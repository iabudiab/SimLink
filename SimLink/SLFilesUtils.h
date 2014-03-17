//
//  SLFilesUtils.h
//  SimLink
//
//  Created by Iska on 12/03/14.
//  Copyright (c) 2014 BrainCookie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLFilesUtils : NSObject

+ (SLFilesUtils *)sharedInstance;


- (NSArray *)subdirectoriesAtPath:(NSString *)path;
- (NSArray *)contentsOfDirectoryAtPath:(NSString *)path ofType:(NSString *)type includeSymlinks:(BOOL)includeSymlinks;
- (BOOL)isItemSymlinkAtPath:(NSString *)path;
- (unsigned long long)sizeOfItemAtPath:(NSString *)path;

@end
