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

@end

@implementation PLDetailViewController

#pragma mark - Managing the detail item

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSString *plotlyURL = @"http://plot.ly";
    NSURL *url = [NSURL URLWithString:self.plot.thumbnailURL];
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    UIImage *plotImage = [[UIImage alloc] initWithData:data];

    // Set the title
    self.title = self.plot.plotName;

    // Set the label texts
    self.plotNameLabel.text = self.plot.plotName;
    self.plotUsernameLabel.text = self.plot.plotUsername;
    self.plotURLLabel.text = [plotlyURL stringByAppendingString:self.plot.plotURL];

    // Set the image
    self.plotImage.image = plotImage;
}

@end
