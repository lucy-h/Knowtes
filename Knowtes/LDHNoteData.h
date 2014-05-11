//
//  LDHNoteData.h
//  Object which holds the title, text and date of a Note.
//  Knowtes
//
//  Created by Lucy He on 5/9/14.
//  Copyright (c) 2014 Lucy He. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDHNoteData : NSObject <NSCoding>

@property (strong) NSString *title;
@property (strong) NSString *text;
@property (strong) NSDate *date;

- (id)initWithTitle:(NSString*)title;

@end