//
//  PLMasterViewController.m
//  Plotly
//
//  Created by James Barclay on 6/19/14.
//  Copyright (c) 2014 Everything is Gray. All rights reserved.
//

#import "PLMasterViewController.h"
#import "PLDetailViewController.h"

#import "TFHpple.h"
#import "PLPlot.h"
#import "PLJSONLoader.h"

//#import "PLFeed.h"
//#import "PLContributor.h"

@interface PLMasterViewController () {
    NSArray *_plots;
}
@end

@implementation PLMasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Create a new PLJSONLoader with http://plot.ly/feed
    PLJSONLoader *jsonLoader = [[PLJSONLoader alloc] init];
    NSURL *url = [NSURL URLWithString:@"http://plot.ly/feed"];

    // Load the JSON data on a background queue
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        _plots = [jsonLoader plotsFromJSONURL:url];
        // Reload the table data on the main UI thread
        [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    });
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlotCell"];

    PLPlot *plot = [_plots objectAtIndex:indexPath.row];

    cell.textLabel.text = plot.plotName;
    // cell.detailTextLabel.text = plot.username; // should use username here
    cell.imageView.image = [UIImage imageNamed:@"foo.png"]; // should use thumbnail here

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_plots count];
}

//- (void)loadFeed
//{
//    NSURL *plotlyFeedUrl = [NSURL URLWithString:@"http://www.raywenderlich.com/tutorials"];
//    NSData *plotlyFeedHtmlData = [NSData dataWithContentsOfURL:plotlyFeedUrl];
//
//    TFHpple *plotlyParser = [TFHpple hppleWithHTMLData:plotlyFeedHtmlData];
//
//    NSString *feedXpathQueryString = @"//div[@class='content-wrapper']/ul/li/a";
//    NSArray *feedNodes = [plotlyParser searchWithXPathQuery:feedXpathQueryString];
//
//    NSMutableArray *newPlotlyFeed = [[NSMutableArray alloc] initWithCapacity:0];
//    for (TFHppleElement *element in feedNodes) {
//        PLFeed *feed = [[PLFeed alloc] init];
//        [newPlotlyFeed addObject:feed];
//
//        feed.title = [[element firstChild] content];
//        feed.url = [element objectForKey:@"href"];
//    }
//
//    // 8
//    _objects = newPlotlyFeed;
//    [self.tableView reloadData];
//
//}
//
//- (void)loadPlots
//{
////    NSURL *plotsURL = [NSURL URLWithString:@"http://plot.ly/feed"];
//    NSURL *plotsURL = [NSURL URLWithString:@"http://www.raywenderlich.com/about"];
//    NSData *plotsHtmlData = [NSData dataWithContentsOfURL:plotsURL];
//
//    TFHpple *plotsParser = [TFHpple hppleWithHTMLData:plotsHtmlData];
//
//    NSString *plotsXpathQueryString = @"//ul[@class='team-members']/li";
//    NSArray *plotsNodes = [plotsParser searchWithXPathQuery:plotsXpathQueryString];
//
//    NSMutableArray *newPlots = [[NSMutableArray alloc] initWithCapacity:0];
//    for (TFHppleElement *element in plotsNodes) {
//        PLContributor *plot = [[PLContributor alloc] init];
//        [newPlots addObject:plot];
//
//        for (TFHppleElement *child in element.children)
//        {
//            if ([child.tagName isEqualToString:@"img"])
//                 {
//                     @try {
//                         plot.imageUrl = [@"http://www.raywenderlich.com" stringByAppendingString:[child objectForKey:@"src"]];
//                     }
//                     @catch (NSException *exception) {}
//                 } else if ([child.tagName isEqualToString:@"h3"]) {
//                     plot.name = [[child firstChild] content];
//                 }
//        }
//    }
//    _plots = newPlots;
//    [self.tableView reloadData];
//}
//
//- (void)awakeFromNib
//{
//    [super awakeFromNib];
//}
//
////- (void)viewDidLoad
////{
////    [super viewDidLoad];
////	// Do any additional setup after loading the view, typically from a nib.
////    self.navigationItem.leftBarButtonItem = self.editButtonItem;
////
////    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
////    self.navigationItem.rightBarButtonItem = addButton;
////}
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//
//    [self loadFeed];
//    [self loadPlots];
//    [self getPlotlyFeedJson];
//}
//
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
////- (void)insertNewObject:(id)sender
////{
////    if (!_objects) {
////        _objects = [[NSMutableArray alloc] init];
////    }
////    [_objects insertObject:[NSDate date] atIndex:0];
////    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
////    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
////}
//
//#pragma mark - Table View
//
//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    switch (section) {
//        case 0:
//            return @"Feeds";
//            break;
//        case 1:
//            return @"Plots";
//            break;
//    }
//    return nil;
//}
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 2;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    switch (section) {
//        case 0:
//            return _objects.count;
//            break;
//        case 1:
//            return _plots.count;
//            break;
//    }
//    return 0;
//}
//
////- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
////{
////    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
////
////    NSDate *object = _objects[indexPath.row];
////    cell.textLabel.text = [object description];
////    return cell;
////}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"Cell";
//
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//
//    if (cell == nil)
//    {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    }
//
//    if (indexPath.section == 0) {
//        PLFeed *thisFeed = [_objects objectAtIndex:indexPath.row];
//        cell.textLabel.text = thisFeed.title;
//        cell.detailTextLabel.text = thisFeed.url;
//    } else if (indexPath.section == 1) {
//        PLContributor *thisPlot = [_plots objectAtIndex:indexPath.row];
//        cell.textLabel.text = thisPlot.name;
//    }
//
//    return cell;
//}
//
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Return NO if you do not want the specified item to be editable.
//    return YES;
//}
//
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [_objects removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//    }
//}
//
///*
//// Override to support rearranging the table view.
//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
//{
//}
//*/
//
///*
//// Override to support conditional rearranging of the table view.
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Return NO if you do not want the item to be re-orderable.
//    return YES;
//}
//*/
//
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([[segue identifier] isEqualToString:@"showDetail"]) {
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        NSDate *object = _objects[indexPath.row];
//        [[segue destinationViewController] setDetailItem:object];
//    }
//}

@end
