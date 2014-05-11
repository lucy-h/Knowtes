//
//  LDHNoteDoc.m
//  Knowtes
//
//  Created by Lucy He on 5/9/14.
//  Copyright (c) 2014 Lucy He. All rights reserved.
//

#import "LDHNoteDoc.h"
#import "LDHNoteData.h"
#import "LDHNoteDatabase.h"
#define kDataKey        @"Data"
#define kDataFile       @"data.plist"
#define kThumbImageFile @"thumbImage.jpg"
#define kFullImageFile  @"fullImage.jpg"

@implementation LDHNoteDoc

@synthesize data = _data;
@synthesize thumbImage = _thumbImage;
@synthesize fullImage = _fullImage;
@synthesize docPath = _docPath;

// Initialization functions.

- (id)init {
    if ((self = [super init])) {
    }
    return self;
}

- (id)initWithTitle:(NSString*)title thumbImage:(UIImage *)thumbImage fullImage:(UIImage *)fullImage {
    if ((self = [super init])) {
        self.data = [[LDHNoteData alloc] initWithTitle:title];
        self.thumbImage = thumbImage;
        self.fullImage = fullImage;
    }
    return self;
}

- (id)initWithDocPath:(NSString *)docPath {
    if ((self = [super init])) {
        _docPath = [docPath copy];
    }
    return self;
}

// Functions to save/delete data and save images (via NSFileManager).

- (BOOL)createDataPath {
    
    if (_docPath == nil) {
        self.docPath = [LDHNoteDatabase nextNoteDocPath];
    }
    
    NSError *error;
    BOOL success = [[NSFileManager defaultManager] createDirectoryAtPath:_docPath withIntermediateDirectories:YES attributes:nil error:&error];
    if (!success) {
        NSLog(@"Error creating data path: %@", [error localizedDescription]);
    }
    return success;
    
}


- (void)saveData {
    
    if (_data == nil) return;
    
    [self createDataPath];
    
    NSString *dataPath = [_docPath stringByAppendingPathComponent:kDataFile];
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:_data forKey:kDataKey];
    [archiver finishEncoding];
    [data writeToFile:dataPath atomically:YES];
    
}

- (void)saveImages {
    
    if (_thumbImage == nil || _fullImage == nil) return;
    
    [self createDataPath];
    
    NSString *thumbImagePath = [_docPath stringByAppendingPathComponent:kThumbImageFile];
    NSData *thumbImageData = UIImagePNGRepresentation(_thumbImage);
    [thumbImageData writeToFile:thumbImagePath atomically:YES];
    
    NSString *fullImagePath = [_docPath stringByAppendingPathComponent:kFullImageFile];
    NSData *fullImageData = UIImagePNGRepresentation(_fullImage);
    [fullImageData writeToFile:fullImagePath atomically:YES];
    
    self.thumbImage = nil;
    self.fullImage = nil;
    
}

- (void)deleteDoc {
    
    NSError *error;
    BOOL success = [[NSFileManager defaultManager] removeItemAtPath:_docPath error:&error];
    if (!success) {
        NSLog(@"Error removing document path: %@", error.localizedDescription);
    }
    
}

// Accessors to data and images for this image. If the data/image is already loaded, it is returned.
// Otherwise it's retrieved from memory.

- (LDHNoteData *)data {
    
    if (_data != nil) return _data;
    
    NSString *dataPath = [_docPath stringByAppendingPathComponent:kDataFile];
    NSData *codedData = [[NSData alloc] initWithContentsOfFile:dataPath];
    if (codedData == nil) return nil;
    
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:codedData];
    _data = [unarchiver decodeObjectForKey:kDataKey];
    [unarchiver finishDecoding];
    
    return _data;
    
}

- (UIImage *)thumbImage {
    
    if (_thumbImage != nil) return _thumbImage;
    
    NSString *thumbImagePath = [_docPath stringByAppendingPathComponent:kThumbImageFile];
    return [UIImage imageWithContentsOfFile:thumbImagePath];
    
}

- (UIImage *)fullImage {
    
    if (_fullImage != nil) return _fullImage;
    
    NSString *fullImagePath = [_docPath stringByAppendingPathComponent:kFullImageFile];
    return [UIImage imageWithContentsOfFile:fullImagePath];
    
}

@end
