//
//  PLDetailViewController.m
//  Plotly
//
//  Created by James Barclay on 6/19/14.
//  Copyright (c) 2014 Everything is Gray. All rights reserved.
//

#import "PLDetailViewController.h"

@interface PLDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *plotNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *plotUsernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *plotURLLabel;
@property (weak, nonatomic) IBOutlet UIImageView *plotImage;
//- (void)configureView;

@end

@implementation PLDetailViewController

#pragma mark - Managing the detail item

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Set the title
    self.title = self.plot.plotName;

    // Set the label texts
    self.plotNameLabel.text = self.plot.plotName;
//    self.plotUsernameLabel.text = self.plot.plotUsername;
//    self.plotURLLabel.text = self.plot.plotURL;
    self.plotURLLabel.text = self.plot.thumbnailURL; // should use URL to plot here

    // Set the image
    self.plotImage.image = [UIImage imageNamed:@"foo.png"]; // obviously use the plot here
}

//- (void)setDetailItem:(id)newDetailItem
//{
//    if (_detailItem != newDetailItem) {
//        _detailItem = newDetailItem;
//        
//        // Update the view.
//        [self configureView];
//    }
//}
//
//- (void)configureView
//{
//    // Update the user interface for the detail item.
//
//    if (self.detailItem) {
//        self.detailDescriptionLabel.text = [self.detailItem description];
//    }
//}
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//	// Do any additional setup after loading the view, typically from a nib.
//    [self configureView];
//}
//
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

@end
