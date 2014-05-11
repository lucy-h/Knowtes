//
//  LDHNoteData.m
//  Knowtes
//
//  Created by Lucy He on 5/9/14.
//  Copyright (c) 2014 Lucy He. All rights reserved.
//

#import "LDHNoteData.h"

@implementation LDHNoteData

@synthesize title = _title;
@synthesize text = _text;
@synthesize date = _date;

- (id)initWithTitle:(NSString*)title {
    if ((self = [super init])) {
        self.title = title;
        self.text = @"Tap here to add text to your new note!";
        self.date = [NSDate date];
    }
    return self;
}

- (id)initWithTitle:(NSString*)title text:(NSString*)text date:(NSDate*)date{
    if ((self = [super init])) {
        self.title = title;
        self.text = text;
        self.date = date;
    }
    return self;
}

#pragma mark NSCoding

#define kTitleKey       @"Title"
#define kText      @"Text"
#define kDate      @"Date"

// Code required for saving / loading data from device.

- (void) encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_title forKey:kTitleKey];
    [encoder encodeObject:_text forKey:kText];
    [encoder encodeObject:_date forKey:kDate];
}

- (id)initWithCoder:(NSCoder *)decoder {
    NSString *title = [decoder decodeObjectForKey:kTitleKey];
    NSString *text = [decoder decodeObjectForKey:kText];
    NSDate *date = [decoder decodeObjectForKey:kDate];
    return [self initWithTitle:title text:text date:date];
}

@end

