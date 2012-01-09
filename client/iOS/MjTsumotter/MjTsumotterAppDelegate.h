//
//  MjTsumotterAppDelegate.h
//  MjTsumotter
//
//  Created by 寺師 佳彦 on 11/12/28.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MjTsumotterViewContoller.h"

@interface MjTsumotterAppDelegate : UIResponder <UIApplicationDelegate>
{
    UIWindow                            *_window;
    MjTsumotterViewContoller            *_mainViewCtl;
}

@property (strong, nonatomic)   UIWindow                                *window;
@property (strong, nonatomic)   MjTsumotterViewContoller                *mainViewCtl;


@property (readonly, strong, nonatomic) NSManagedObjectContext          *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel            *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator    *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

// デバッグ用メソッド
- (void)displayFrameViewController:(id)sender withTitle:(NSString *)title;
- (void)displayButtonLabel:(UIViewController *)sender withTitle:(NSString *)title;
- (void)displayDictionary:(NSDictionary *)dictionary withTitle:(NSString *)title;

@end
