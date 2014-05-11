//
//  LDHNoteDatabase.m
//  Knowtes
//
//  Created by Lucy He on 5/10/14.
//  Modified from: http://www.raywenderlich.com/1914/nscoding-tutorial-for-ios-how-to-save-your-app-data
//  Copyright (c) 2014 Lucy He. All rights reserved.
//

#import "LDHNoteDatabase.h"
#import "LDHNoteDoc.h"

@implementation LDHNoteDatabase

+ (NSString *)getPrivateDocsDir {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:@"Private Documents"];
    
    NSError *error;
    [[NSFileManager defaultManager] createDirectoryAtPath:documentsDirectory withIntermediateDirectories:YES attributes:nil error:&error];
    
    return documentsDirectory;
    
}

+ (NSMutableArray *)loadNoteDocs {
    
    // Get private docs dir
    NSString *documentsDirectory = [LDHNoteDatabase getPrivateDocsDir];
    NSLog(@"Loading notes from %@", documentsDirectory);
    
    // Get contents of documents directory
    NSError *error;
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectory error:&error];
    if (files == nil) {
        NSLog(@"Error reading contents of documents directory: %@", [error localizedDescription]);
        return nil;
    }
    
    // Create NoteDoc for each file
    NSMutableArray *retval = [NSMutableArray arrayWithCapacity:files.count];
    for (NSString *file in files) {
        if ([file.pathExtension compare:@"note" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
            NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:file];
            LDHNoteDoc *doc = [[LDHNoteDoc alloc] initWithDocPath:fullPath];
            [retval addObject:doc];
        }
    }
    
    return retval;
}

+ (NSString *)nextNoteDocPath {
    
    // Get private docs dir
    NSString *documentsDirectory = [LDHNoteDatabase getPrivateDocsDir];
    
    // Get contents of documents directory
    NSError *error;
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectory error:&error];
    if (files == nil) {
        NSLog(@"Error reading contents of documents directory: %@", [error localizedDescription]);
        return nil;
    }
    
    // Search for an available name
    int maxNumber = 0;
    for (NSString *file in files) {
        if ([file.pathExtension compare:@"note" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
            NSString *fileName = [file stringByDeletingPathExtension];
            maxNumber = MAX(maxNumber, fileName.intValue);
        }
    }
    
    // Get available name
    NSString *availableName = [NSString stringWithFormat:@"%d.note", maxNumber+1];
    return [documentsDirectory stringByAppendingPathComponent:availableName];
}
@end

