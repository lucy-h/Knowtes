//
//  LDHPhotoViewController.m
//  Knowtes
//
//  Created by Lucy He on 5/10/14.
//  Copyright (c) 2014 Lucy He. All rights reserved.
//

#import "LDHPhotoViewController.h"

@interface LDHPhotoViewController ()

@end

@implementation LDHPhotoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.imageView.image = self.image;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.imageView.image = self.image;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
