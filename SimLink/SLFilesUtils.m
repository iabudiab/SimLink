//
//  SLFilesUtils.m
//  SimLink
//
//  Created by Iska on 12/03/14.
//  Copyright (c) 2014 BrainCookie. All rights reserved.
//

#import "SLFilesUtils.h"

@implementation SLFilesUtils

+ (SLFilesUtils *)sharedInstance
{
	static SLFilesUtils *singleton;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		singleton = [[self alloc] init];
	});
	return singleton;
}

- (NSArray *)subdirectoriesAtPath:(NSString *)path
{
	NSFileManager *fileManager = [NSFileManager defaultManager];

	NSDirectoryEnumerator *enumerator  = [fileManager enumeratorAtURL:[NSURL fileURLWithPath:path]
										   includingPropertiesForKeys:@[ NSURLNameKey, NSURLIsDirectoryKey ]
															  options:NSDirectoryEnumerationSkipsSubdirectoryDescendants | NSDirectoryEnumerationSkipsHiddenFiles
														 errorHandler:nil];
	NSMutableArray *list = [NSMutableArray array];

	for (NSURL *item in enumerator) {
		NSNumber *isDirectory;
		[item getResourceValue:&isDirectory forKey:NSURLIsDirectoryKey error:NULL];

		if ([isDirectory boolValue]) [list addObject:item.path];
	}
	return list;
}

- (NSArray *)contentsOfDirectoryAtPath:(NSString *)path ofType:(NSString *)type
{
	NSFileManager *fileManager = [NSFileManager defaultManager];

	NSDirectoryEnumerator *enumerator  = [fileManager enumeratorAtURL:[NSURL fileURLWithPath:path]
										   includingPropertiesForKeys:@[ NSURLNameKey, NSURLIsSymbolicLinkKey ]
															  options:NSDirectoryEnumerationSkipsSubdirectoryDescendants | NSDirectoryEnumerationSkipsHiddenFiles
														 errorHandler:nil];
	NSMutableArray *list = [NSMutableArray array];

	for (NSURL *item in enumerator) {
		if (![[item pathExtension] isEqualToString:type]) continue;

		NSNumber *isSymbolicLink;
		[item getResourceValue:&isSymbolicLink forKey:NSURLIsSymbolicLinkKey error:NULL];

		if (![isSymbolicLink boolValue]) [list addObject:item.path];
	}
	return list;
}

@end
