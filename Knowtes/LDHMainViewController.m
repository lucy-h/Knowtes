//
//  LDHMainViewController.m
//  Knowtes
//
//  Created by Lucy He on 5/9/14.
//  Copyright (c) 2014 Lucy He. All rights reserved.
//

#import "LDHMainViewController.h"
#import "LDHNoteViewController.h"
#import "LDHNoteDoc.h"
#import "LDHNoteData.h"

@interface LDHMainViewController ()
@end

@implementation LDHMainViewController

@synthesize notes = _notes;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Notes";
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    // Set functionality for clicking a "+" button (i.e. add a new note)
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                              target:self action:@selector(addTapped:)];
}

- (void)viewWillAppear:(BOOL)animated
{
    // Thumbnails and note titles may have changed since the main table was last viewed.
    // Refresh to sync display with data.
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _notes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    LDHNoteDoc *note = [self.notes objectAtIndex:indexPath.row];
    cell.textLabel.text = note.data.title;
    cell.imageView.image = note.thumbImage;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// Delete a row.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        LDHNoteDoc *doc = [_notes objectAtIndex:indexPath.row];
        [doc deleteDoc];
        
        [_notes removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
}

// User tapped "+" to add a new note. Create the new note here.
- (void)addTapped:(id)sender {
    LDHNoteDoc *newDoc = [[LDHNoteDoc alloc] initWithTitle:@"New Note" thumbImage:nil fullImage:nil];
    [_notes addObject:newDoc];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_notes.count-1 inSection:0];
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:YES];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LDHNoteDoc *note = _notes[indexPath.row];
    if (!self.noteViewController) {
        self.noteViewController = [[LDHNoteViewController alloc] initWithNibName:@"LDHNoteViewController" bundle:nil];
    }
    self.noteViewController.detailItem = note;
    self.noteViewController.title = note.data.title;
    [self.navigationController pushViewController:self.noteViewController animated:YES];
    
}

@end
