//
//  MjTsumotterAppDelegate.m
//  MjTsumotter
//
//  Created by 寺師 佳彦 on 11/12/28.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MjTsumotterAppDelegate.h"

@implementation MjTsumotterAppDelegate

@synthesize window                      = _window;
@synthesize mainViewCtl                 = _mainViewCtl;
@synthesize managedObjectContext        = __managedObjectContext;
@synthesize managedObjectModel          = __managedObjectModel;
@synthesize persistentStoreCoordinator  = __persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor blackColor];

    // メインとなるビューを設定する.
    _mainViewCtl    = [[MjTsumotterViewContoller alloc] init];
    self.window.rootViewController = self.mainViewCtl;

    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil)
    {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil)
    {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"MjTsumotter" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return __managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil)
    {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"MjTsumotter.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return __persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (void)dealloc
{
    [_window release];
    [_mainViewCtl release];
    [__managedObjectContext release];
    [__managedObjectModel release];
    [__persistentStoreCoordinator release];
    [super dealloc];
}

#pragma mark - For Debugging

/**
 * UIView/UIViewContoller.viewのフレーム情報をログ出力する.
 */
- (void)displayFrameViewController:(id)sender withTitle:(NSString *)title
{
#ifdef ModeDebug
    UIView *view = nil;
    if ([sender isKindOfClass:[UIViewController class]]) {
        view = [(UIViewController *)sender view];
    }
    else {
        view = (UIView *)sender;
    }
    
    NSLog(@"frame  x:%5.1f y:%5.1f w:%5.1f h:%5.1f %@(%@)",
          view.frame.origin.x, view.frame.origin.y, 
          view.frame.size.width, view.frame.size.height, 
          NSStringFromClass([sender class]), title);
    NSLog(@"bounds x:%5.1f y:%5.1f w:%5.1f h:%5.1f %@(%@)",
          view.bounds.origin.x, view.bounds.origin.y, 
          view.bounds.size.width, view.bounds.size.height, 
          NSStringFromClass([sender class]), title);
#endif
}

/**
 * UIViewControllerの四隅にボタンを設置し、中央にラベルを表示する。
 */
- (void)displayButtonLabel:(UIViewController *)sender withTitle:(NSString *)title
{
#ifdef ModeDebug
    UIButton *tlBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    tlBtn.frame = CGRectMake(ZERO_VALUE_FLOAT, 
                             ZERO_VALUE_FLOAT, 
                             100.0, 
                             50.0);
    [tlBtn setTitle:@"TopLeft" forState:UIControlStateNormal];
    [tlBtn addTarget:sender action:nil forControlEvents:UIControlEventTouchUpInside];
    [sender.view addSubview:tlBtn];
    
    UIButton *trBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    trBtn.frame = CGRectMake(sender.view.frame.size.width - 100.0, 
                             ZERO_VALUE_FLOAT, 
                             100.0, 
                             50.0);
    [trBtn setTitle:@"TopRight" forState:UIControlStateNormal];
    [trBtn addTarget:sender action:nil forControlEvents:UIControlEventTouchUpInside];
    [sender.view addSubview:trBtn];
    
    UIButton *blBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    blBtn.frame = CGRectMake(ZERO_VALUE_FLOAT, 
                             sender.view.frame.size.height - 50.0, 
                             100.0, 
                             50.0);
    [blBtn setTitle:@"ButtomLeft" forState:UIControlStateNormal];
    [blBtn addTarget:sender action:nil forControlEvents:UIControlEventTouchUpInside];
    [sender.view addSubview:blBtn];
    
    UIButton *brBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    brBtn.frame = CGRectMake(sender.view.frame.size.width - 100.0, 
                             sender.view.frame.size.height - 50.0, 
                             100.0, 
                             50.0);
    [brBtn setTitle:@"ButtomRight" forState:UIControlStateNormal];
    [brBtn addTarget:sender action:nil forControlEvents:UIControlEventTouchUpInside];
    [sender.view addSubview:brBtn];
    
    UILabel *label = [[[UILabel alloc] initWithFrame:
                       CGRectMake((sender.view.frame.size.width - 200.0) / 2.0,
                                  (sender.view.frame.size.height - 50.0) / 2.0, 
                                  200.0, 
                                  50.0)] autorelease];
    label.text = title;
    [sender.view addSubview:label];
#endif
}

/**
 * NSDictionaryのキーとオブジェクトを全て出力する。
 */
- (void)displayDictionary:(NSDictionary *)dictionary withTitle:(NSString *)title
{
#ifdef ModeDebug
    NSLog(@"----- Start:%@ -----", title);
    for (NSString *key in [dictionary allKeys]) {
        NSLog(@"key:%@ value:%@", key, [dictionary objectForKey:key]);
    }
    NSLog(@"----- End  :%@ -----", title);
#endif
}

@end
