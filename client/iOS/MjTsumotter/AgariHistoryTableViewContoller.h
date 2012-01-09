//
//  AgariHistoryTableViewContoller.h
//  MjTsumotter
//
//  Created by 寺師 佳彦 on 11/12/28.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AgariDetailTableViewController.h"

@interface AgariHistoryTableViewContoller : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    UITableView                     *_tableView;
    AgariDetailTableViewController  *detail_;
}

@property(nonatomic, readonly, retain)  UITableView                     *tableView;

@end
