//
//  AppDelegate.m
//  Knowtes
//
//  Created by Lucy He on 5/8/14.
//  Copyright (c) 2014 Lucy He. All rights reserved.
//

#import "AppDelegate.h"

#import "LDHMainViewController.h"

#import "LDHNoteViewController.h"

#import "LDHNoteDoc.h"

#import "LDHNoteDatabase.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{   
    // Load notes from device.
    NSMutableArray *loadedNotes = [LDHNoteDatabase loadNoteDocs];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    // Create the main view controller. Set its data to the data retrieved from the device.
    LDHMainViewController *mainViewController = [[LDHMainViewController alloc] initWithNibName:@"LDHMainViewController" bundle:nil];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:mainViewController];
    self.window.rootViewController = self.navigationController;
    mainViewController.notes = loadedNotes;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application{}

- (void)applicationDidEnterBackground:(UIApplication *)application{}

- (void)applicationWillEnterForeground:(UIApplication *)application{}

- (void)applicationDidBecomeActive:(UIApplication *)application{}

- (void)applicationWillTerminate:(UIApplication *)application{}

@end
