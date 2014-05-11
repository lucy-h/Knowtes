//
//  LDHNoteDoc.h
//  Knowtes
//
//  Created by Lucy He on 5/9/14.
//  Copyright (c) 2014 Lucy He. All rights reserved.
//


#import <Foundation/Foundation.h>

@class LDHNoteData;

@interface LDHNoteDoc : NSObject {
    NSString *_docPath;
}

@property (strong) NSString *docPath;
- (id)init;
- (id)initWithDocPath:(NSString *)docPath;
- (void)saveData;
- (void)deleteDoc;
- (void)saveImages;

@property (strong, nonatomic) LDHNoteData *data;
@property (strong, nonatomic) UIImage *thumbImage;
@property (strong, nonatomic) UIImage *fullImage;

- (id)initWithTitle:(NSString*)title thumbImage:(UIImage *)thumbImage fullImage:(UIImage *)fullImage;

@end