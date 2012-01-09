//
//  AgariHistoryTableViewContoller.m
//  MjTsumotter
//
//  Created by 寺師 佳彦 on 11/12/28.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AgariHistoryTableViewContoller.h"
#import "MjTsumotterAppDelegate.h"

// TableViewの位置、サイズを定義
static const float  TABLE_VIEW_ORIGIN_X         = ZERO_VALUE_FLOAT;
static const float  TABLE_VIEW_ORIGIN_Y         = ZERO_VALUE_FLOAT;
static const float  TABLE_VIEW_SIZE_WIDTH       = IPHONE_DEVICE_SIZE_WIDTH;
static const float  TABLE_VIEW_SIZE_HEIGHT      = IPHONE_DEVICE_SIZE_HEIGHT - STATUS_BAR_SIZE_HEIGHT - NAVIGATION_BAR_SIZE_HEIGHT - TAB_BAR_SIZE_HEIGHT;

@implementation AgariHistoryTableViewContoller

@synthesize tableView                   = _tableView;

- (id)init
{
    self = [super init];
    if (self != nil) {
        self.title = @"履歴";
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

- (void)viewDidLoad
{
    [super viewDidLoad];

    // テーブルを定義
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(TABLE_VIEW_ORIGIN_X, 
                                                                   TABLE_VIEW_ORIGIN_Y, 
                                                                   TABLE_VIEW_SIZE_WIDTH, 
                                                                   TABLE_VIEW_SIZE_HEIGHT) 
                                                  style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView flashScrollIndicators];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:kDateFormatDateTime];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    if (indexPath.row < 5) {
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        
        NSString *fileName  = [NSString stringWithFormat:@"sample%d", indexPath.row];
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:fileName 
                                                              ofType:kFileTypeJpeg];
        cell.imageView.image = [UIImage imageWithContentsOfFile:imagePath];
        
        cell.textLabel.text = [formatter stringFromDate:[NSDate date]];
        
        cell.detailTextLabel.text = @"48000オール";
    }

    [formatter release];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    detail_ = [[AgariDetailTableViewController alloc] initWithIndex:indexPath.row];
    [self.navigationController pushViewController:detail_ animated:YES];
}

- (void)dealloc
{
    [_tableView release];
    [detail_ release];
    [super dealloc];
}

@end
