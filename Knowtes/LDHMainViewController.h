//
//  LDHMainViewController.h
//  Knowtes
//
//  Created by Lucy He on 5/9/14.
//  Copyright (c) 2014 Lucy He. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LDHNoteViewController;

@interface LDHMainViewController : UITableViewController

@property (strong, nonatomic) LDHNoteViewController *noteViewController;
@property (strong) NSMutableArray *notes;

@end
