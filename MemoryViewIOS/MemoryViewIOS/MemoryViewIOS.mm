//
//  MemoryViewIOS.m
//  MemoryViewIOS
//
//  Created by Jesse Scott on 2016-02-12.
//  Copyright © 2016 E-Link Entertainment. All rights reserved.
//

#import "MemoryViewIOS.h"

#pragma mark - PRIVATE -

@implementation MemoryViewIOS


@end


#pragma mark - EXTERN -

extern "C"
{
    
    double CheckFreeSpace() {
        NSLog(@"\n\n-- MEMORY VIEW UNITY/IOS PLUGIN -- \n");
        uint64_t totalSpaceInUnsignedInts = 0;
        uint64_t totalFreeSpaceInUnsignedInts = 0;
        double FREE_SPACE;
        NSError *error = nil;
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
        if (dictionary) {
            NSNumber *fileSystemSizeInBytes = [dictionary objectForKey: NSFileSystemSize];
            NSNumber *freeFileSystemSizeInBytes = [dictionary objectForKey:NSFileSystemFreeSize];
            totalSpaceInUnsignedInts = [fileSystemSizeInBytes unsignedLongLongValue];
            totalFreeSpaceInUnsignedInts = [freeFileSystemSizeInBytes unsignedLongLongValue];
            FREE_SPACE = ((totalFreeSpaceInUnsignedInts/1024ll)/1024ll);
            NSLog(@"Memory Capacity of %llu MiB with %llu MiB Free memory available.",
                  ((totalSpaceInUnsignedInts/1024ll)/1024ll),
                  ((totalFreeSpaceInUnsignedInts/1024ll)/1024ll));
        }
        else {
            NSLog(@"Error Obtaining System Memory Info: Domain = %@, Code = %ld", [error domain], (long)[error code]);
            return 0.0;
        }
        NSLog(@"\n\n");
        return FREE_SPACE;
    }
    
}




