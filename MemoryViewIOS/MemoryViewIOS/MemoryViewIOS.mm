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



- (BOOL) checkForSpace {
    uint64_t totalSpace = 0;
    uint64_t totalFreeSpace = 0;
    
    double NEED;
    double HAVE;
    
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    
    if (dictionary) {
        NSNumber *fileSystemSizeInBytes = [dictionary objectForKey: NSFileSystemSize];
        NSNumber *freeFileSystemSizeInBytes = [dictionary objectForKey:NSFileSystemFreeSize];
        
        totalSpace = [fileSystemSizeInBytes unsignedLongLongValue];
        totalFreeSpace = [freeFileSystemSizeInBytes unsignedLongLongValue];
        
        NEED = 100.00;
        HAVE = ((totalFreeSpace/1024ll)/1024ll);
        
        NSLog(@"Memory Capacity of %llu MiB with %llu MiB Free memory available.", ((totalSpace/1024ll)/1024ll), ((totalFreeSpace/1024ll)/1024ll));
    } else {
        NSLog(@"Error Obtaining System Memory Info: Domain = %@, Code = %ld", [error domain], (long)[error code]);
    }
    
    if (HAVE >= NEED) {
        return YES;
    }
    else {
        return NO;
    }
}



@end


#pragma mark - EXTERN -

extern "C"
{
    // TEST
    
    void HelloFromUnity()
    {
        NSLog(@"-- IOS PLUGIN -- ");
    }
    
    
    // GETTERS
    
    static NSString* ReturnDocumentsDirectory()
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *doc = [paths objectAtIndex:0];
        return doc;
    }
    
    double CheckFreeSpace() {
        uint64_t totalSpace = 0;
        uint64_t totalFreeSpace = 0;
        double HAVE;
        NSError *error = nil;
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
        if (dictionary) {
            NSNumber *fileSystemSizeInBytes = [dictionary objectForKey: NSFileSystemSize];
            NSNumber *freeFileSystemSizeInBytes = [dictionary objectForKey:NSFileSystemFreeSize];
            totalSpace = [fileSystemSizeInBytes unsignedLongLongValue];
            totalFreeSpace = [freeFileSystemSizeInBytes unsignedLongLongValue];
            HAVE = ((totalFreeSpace/1024ll)/1024ll);
            NSLog(@"Memory Capacity of %llu MiB with %llu MiB Free memory available.", ((totalSpace/1024ll)/1024ll), ((totalFreeSpace/1024ll)/1024ll));
        }
        else {
            NSLog(@"Error Obtaining System Memory Info: Domain = %@, Code = %ld", [error domain], (long)[error code]);
            return 0.0;
        }
        return HAVE;
    }
    
    
    // UTIL
    
    char* cStringCopy(const char* string)
    {
        if (string == NULL)
            return NULL;
        
        char* res = (char*)malloc(strlen(string) + 1);
        strcpy(res, string);
        return res;
    }
    
    static NSString* CreateNSString(const char* string)
    {
        if (string != NULL)
            return [NSString stringWithUTF8String:string];
        else
            return [NSString stringWithUTF8String:""];
    }
    
    
    
    
}




