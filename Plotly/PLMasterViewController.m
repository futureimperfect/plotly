//
//  PLMasterViewController.m
//  Plotly
//
//  Created by James Barclay on 6/19/14.
//  Copyright (c) 2014 Everything is Gray. All rights reserved.
//

#import "PLMasterViewController.h"
#import "PLDetailViewController.h"

#import "PLPlot.h"
#import "PLJSONLoader.h"
#import "PLConstants.h"

@interface PLMasterViewController () {
    NSArray *_plots;
}
@end

@implementation PLMasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIRefreshControl *refresher = [[UIRefreshControl alloc] init];
    refresher.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    [refresher addTarget:self action:@selector(loadPlots) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresher;
    [self loadPlots];
}

- (void)stopRefresh
{
    [self.refreshControl endRefreshing];
}

- (void)loadPlots
{
    // Create a new PLJSONLoader with http://plot.ly/feed_json_list
    PLJSONLoader *jsonLoader = [[PLJSONLoader alloc] init];
    NSURL *url = [NSURL URLWithString:[kPlotlyURL stringByAppendingString:@"/feed_json_list"]];

    // Load the JSON data on a background queue
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        _plots = [jsonLoader plotsFromJSONURL:url];
        // Reload the table data on the main UI thread
        [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    });

    [self performSelector:@selector(stopRefresh) withObject:nil afterDelay:1.5];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        PLDetailViewController *vc = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:(id)sender];
        vc.plot = [_plots objectAtIndex:indexPath.row];
    }
}

#pragma mark - Table View Controller Methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    PLPlot *plot = [_plots objectAtIndex:indexPath.row];

    // Set the texts
    cell.textLabel.text = plot.plotName;
    cell.detailTextLabel.text = plot.plotUsername;

    // Set a random cell image
    NSMutableArray *imagesArray = [[NSMutableArray alloc] initWithObjects:@"black.png", @"blue.png", @"green.png", @"red.png", @"yellow.png", nil];
    int random = arc4random() % imagesArray.count;
    cell.imageView.image = [UIImage imageNamed:[imagesArray objectAtIndex:random]];

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_plots count];
}

@end
