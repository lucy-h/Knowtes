//
//  LDHNoteViewController.h
//  Knowtes
//
//  Created by Lucy He on 5/9/14.
//  Copyright (c) 2014 Lucy He. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h> 
#import "LDHPhotoViewController.h"


@class LDHNoteDoc;

@interface LDHNoteViewController : UIViewController <UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate, MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) LDHNoteDoc *detailItem; // Contains data for note
@property (strong, nonatomic) LDHPhotoViewController *photoViewController; // Displays photo larger.
@property (strong, nonatomic) UIImagePickerController *picker; // Photo picker for note photo attachment.

@property (weak, nonatomic) IBOutlet UITextField *titleField; // Title of note.
@property (weak, nonatomic) IBOutlet UIImageView *imageView; // Where the photo of note is displayed.
@property (weak, nonatomic) IBOutlet UITextView *noteField; // Body of the note.
@property (weak, nonatomic) IBOutlet UILabel *dateCreated; // Date note was created. (Cannot be edited.)

- (IBAction)showEmail:(id)sender; // Open the screen to send a note as an email.
- (IBAction)addPictureTapped:(id)sender; // Button to add/edit photo is tapped.
- (IBAction)titleFieldTextChanged:(id)sender; // Action called when title text is changed.

@end
