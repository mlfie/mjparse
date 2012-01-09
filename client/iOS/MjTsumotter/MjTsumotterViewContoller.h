//
//  MjTsumotterViewContoller.h
//  MjTsumotter
//
//  Created by 寺師 佳彦 on 11/12/28.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TakePhotoViewContoller.h"
#import "AgariHistoryTableViewContoller.h"
#import "ChartAnalyzeTableViewContoller.h"
#import "AppSettingTableViewContoller.h"

@interface MjTsumotterViewContoller : UIViewController <UITabBarControllerDelegate>
{
    // View切り替え用のコントローラ
    UITabBarController                  *tabBarCtl_;
    UINavigationController              *photoNaviCtl_;
    UINavigationController              *historyNaviCtl_;
    UINavigationController              *chartNaviCtl_;
    UINavigationController              *settingNaviCtl_;
    
    TakePhotoViewContoller              *_photoViewCtl;
    AgariHistoryTableViewContoller      *_historyViewCtl;
    ChartAnalyzeTableViewContoller      *_chartViewCtl;
    AppSettingTableViewContoller        *_settingViewCtl;
}

@property(nonatomic, readonly, retain)  TakePhotoViewContoller              *photoViewCtl;
@property(nonatomic, readonly, retain)  AgariHistoryTableViewContoller      *historyViewCtl;
@property(nonatomic, readonly, retain)  ChartAnalyzeTableViewContoller      *chartViewCtl;
@property(nonatomic, readonly, retain)  AppSettingTableViewContoller        *settingViewCtl;

@end
