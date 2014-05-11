//
//  NoteViewController.h
//  Test1
//
//  Created by Lucy He on 5/8/14.
//  Copyright (c) 2014 Lucy He. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoteViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end