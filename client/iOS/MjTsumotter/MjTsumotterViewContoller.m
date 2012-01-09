//
//  MjTsumotterViewContoller.m
//  MjTsumotter
//
//  Created by 寺師 佳彦 on 11/12/28.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MjTsumotterViewContoller.h"
#import "MjTsumotterAppDelegate.h"

@implementation MjTsumotterViewContoller

@synthesize photoViewCtl        = _photoViewCtl;
@synthesize historyViewCtl      = _historyViewCtl;
@synthesize chartViewCtl        = _chartViewCtl;
@synthesize settingViewCtl      = _settingViewCtl;

- (id)init
{
    self = [super init];
    if (self != nil) {
        _photoViewCtl       = [[TakePhotoViewContoller alloc] init];
        _historyViewCtl     = [[AgariHistoryTableViewContoller alloc] init];
        _chartViewCtl       = [[ChartAnalyzeTableViewContoller alloc] init];
        _settingViewCtl     = [[AppSettingTableViewContoller alloc] init];
    }        
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    [super loadView];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    photoNaviCtl_               = [[UINavigationController alloc] initWithRootViewController:self.photoViewCtl];
    NSString *photoImagePath    = [[NSBundle mainBundle] pathForResource:@"UITabBarCamera" 
                                                                  ofType:kFileTypePng];
    photoNaviCtl_.tabBarItem    = [[UITabBarItem alloc] initWithTitle:self.photoViewCtl.title 
                                                                image:[UIImage imageWithContentsOfFile:photoImagePath] 
                                                                  tag:0];
    [photoImagePath release];
    
    historyNaviCtl_             = [[UINavigationController alloc] initWithRootViewController:self.historyViewCtl];
    NSString *historyImagePath  = [[NSBundle mainBundle] pathForResource:@"UITabBarHistory" 
                                                                  ofType:kFileTypePng];
    historyNaviCtl_.tabBarItem  = [[UITabBarItem alloc] initWithTitle:self.historyViewCtl.title 
                                                                image:[UIImage imageWithContentsOfFile:historyImagePath] 
                                                                  tag:1];
    [historyImagePath release];
    
    chartNaviCtl_               = [[UINavigationController alloc] initWithRootViewController:self.chartViewCtl];
    NSString *chartImagePath    = [[NSBundle mainBundle] pathForResource:@"UITabBarChart" 
                                                                  ofType:kFileTypePng];
    chartNaviCtl_.tabBarItem    = [[UITabBarItem alloc] initWithTitle:self.chartViewCtl.title 
                                                                image:[UIImage imageWithContentsOfFile:chartImagePath]
                                                                  tag:2];
    [chartImagePath release];
    
    settingNaviCtl_             = [[UINavigationController alloc] initWithRootViewController:self.settingViewCtl];
    NSString *settingImagePath  = [[NSBundle mainBundle] pathForResource:@"UITabBarSetting" 
                                                                  ofType:kFileTypePng];
    settingNaviCtl_.tabBarItem  = [[UITabBarItem alloc] initWithTitle:self.settingViewCtl.title 
                                                                image:[UIImage imageWithContentsOfFile:settingImagePath] 
                                                                  tag:3];
    [settingImagePath release];
    
    tabBarCtl_                  = [[UITabBarController alloc] init];
    tabBarCtl_.view.frame       = CGRectMake(tabBarCtl_.view.frame.origin.x,
                                             tabBarCtl_.view.frame.origin.y -  STATUS_BAR_SIZE_HEIGHT,
                                             tabBarCtl_.view.frame.size.width, 
                                             tabBarCtl_.view.frame.size.height);
    tabBarCtl_.viewControllers  = [NSArray arrayWithObjects:
                                   photoNaviCtl_, 
                                   historyNaviCtl_, 
                                   chartNaviCtl_, 
                                   settingNaviCtl_, 
                                   nil];
    [photoNaviCtl_ release];
    [historyNaviCtl_ release];
    [chartNaviCtl_ release];
    [settingNaviCtl_ release];
    tabBarCtl_.delegate = self;
    tabBarCtl_.selectedIndex = 0;
    [self.view addSubview:tabBarCtl_.view];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    switch (viewController.tabBarItem.tag) {
        case 0:
            [self.photoViewCtl takePhoto:self];
            break;
        default:
            break;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.photoViewCtl takePhoto:self];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc
{
    [_photoViewCtl release];
    [_historyViewCtl release];
    [_chartViewCtl release];
    [_settingViewCtl release];
    [super dealloc];
}

@end
