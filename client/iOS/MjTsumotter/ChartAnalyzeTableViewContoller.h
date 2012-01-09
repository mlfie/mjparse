//
//  ChartAnalyzeTableViewContoller.h
//  MjTsumotter
//
//  Created by 寺師 佳彦 on 11/12/28.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChartAnalyzeTableViewContoller : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    UITableView                 *_tableView;
}

@property(nonatomic, readwrite, retain) UITableView                     *tableView;

@end
