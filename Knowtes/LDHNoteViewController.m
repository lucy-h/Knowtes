//
//  LDHNoteViewController.m
//  Knowtes
//
//  Created by Lucy He on 5/9/14.
//  Email code adapted from: http://www.appcoda.com/ios-programming-101-send-email-iphone-app/
//  and: http://www.appcoda.com/ios-programming-create-email-attachment/
//  Copyright (c) 2014 Lucy He. All rights reserved.
//

#import "LDHNoteViewController.h"
#import "LDHNoteData.h"
#import "LDHNoteDoc.h"
#import "RWTUIImageExtras.h"

@interface LDHNoteViewController ()
- (void)configureView;
@end

@implementation LDHNoteViewController

@synthesize picker = _picker;

#pragma mark - managing the note

- (void)configureView
{
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.titleField.text = self.detailItem.data.title;
        self.imageView.image = self.detailItem.fullImage;
        self.noteField.text = self.detailItem.data.text;
        self.dateCreated.text = [self.detailItem.data.date description];
    }
    
    // Add a tap gesture recognizer over a note's photo. Tapping a photo will show it enlarged.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tap.numberOfTapsRequired = 1;
    tap.cancelsTouchesInView = NO;
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:tap];
}

// Push a photo view controller to show a larger version of a note's photo.
-(void)handleTap:(id)sender{
    if(self.imageView.image) {
        if (!self.photoViewController) {
            self.photoViewController = [[LDHPhotoViewController alloc] initWithNibName:@"LDHPhotoViewController" bundle:nil];
        }
        self.photoViewController.image = self.imageView.image;
        [self.navigationController pushViewController:self.photoViewController animated:YES];
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.titleField.text = self.detailItem.data.title;
        self.imageView.image = self.detailItem.fullImage;
        self.noteField.text = self.detailItem.data.text;
        self.dateCreated.text = [self.detailItem.data.date description];
    }
    
    // Keyboard and "Done" button which open when the note text is being edited may be open.
    // (If for example, they were open, and the user navigated elsewhere.)
    // Ensure they are always closed when returning to a note's screen.
    [self.noteField resignFirstResponder];
    self.navigationItem.rightBarButtonItem = nil;
}


// Called when the "Add/Edit Photo" button is clicked.
- (IBAction)addPictureTapped:(id)sender {
    if (self.picker == nil) {
        self.picker = [[UIImagePickerController alloc] init];
        self.picker.delegate = self;
        self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        self.picker.allowsEditing = NO;
    }
    [self presentViewController:_picker animated:YES completion:nil];
}

#pragma mark MFMailComposeViewControllerDelegate

- (IBAction)showEmail:(id)sender {
    // Email Subject
    NSMutableString *emailTitleM = [NSMutableString string];
    [emailTitleM appendString:self.detailItem.data.title];
    [emailTitleM appendString:@" from Knowtes"];
    NSString *emailTitle = emailTitleM;
   
    // Email Content
    NSString *messageBody = self.detailItem.data.text;
    
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@"your@email.com"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];

    // Format the image into a JPEG and attach it to the email.
    [mc addAttachmentData:UIImageJPEGRepresentation(self.detailItem.fullImage,1) mimeType:@"image/jpeg" fileName:[NSString stringWithFormat:@"%@.jpeg", self.detailItem.data.title]];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
}


- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *fullImage = (UIImage *) [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImage *thumbImage = [fullImage imageByScalingAndCroppingForSize:CGSizeMake(44, 44)];
    self.detailItem.fullImage = fullImage;
    self.detailItem.thumbImage = thumbImage;
    self.imageView.image = fullImage;
    [self.detailItem saveImages];
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    // If the user left the title field empty, by default name this note "Untitled"
    if([self.detailItem.data.title isEqualToString:@""]){
        self.detailItem.data.title = @"Untitled";
        self.titleField.text = self.detailItem.data.title;
    }
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)titleFieldTextChanged:(id)sender {
    self.detailItem.data.title = self.titleField.text;
    self.title = NSLocalizedString(self.titleField.text, self.titleField.text);
    [self.detailItem saveData];
}

#pragma mark UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView {
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    [textView resignFirstResponder];
    self.detailItem.data.text = textView.text;
    [self.detailItem saveData];
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"Tap here to add text to your new note!"]) {
        textView.text = @"";
        textView.textAlignment = NSTextAlignmentLeft;
    }
    
    // When the user is editing the note text, add a "Done" button to the
    // navigation bar which they can click to finish editing.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                              target:self action:@selector(doneEditing:)];
}

- (void)doneEditing:(id)sender {
    // Hide the keyboard and remove the "Done" button.
    [self.noteField resignFirstResponder];
    self.navigationItem.rightBarButtonItem = nil;
}

@end
