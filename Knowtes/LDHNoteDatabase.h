//
//  LDHNoteDatabase.h
//  Knowtes
//
//  Created by Lucy He on 5/10/14.
//  Modified from: http://www.raywenderlich.com/1914/nscoding-tutorial-for-ios-how-to-save-your-app-data
//  Copyright (c) 2014 Lucy He. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDHNoteDatabase : NSObject
+ (NSMutableArray *)loadNoteDocs;
+ (NSString *)nextNoteDocPath;
@end

