//
//  PLDetailViewController.m
//  Plotly
//
//  Created by James Barclay on 6/19/14.
//  Copyright (c) 2014 Everything is Gray. All rights reserved.
//

#import "PLDetailViewController.h"
#import "PLConstants.h"

@interface PLDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *plotNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *plotImage;

@end

@implementation PLDetailViewController

#pragma mark - Managing the detail item

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Get the image asynchronously, set when done
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSInvocationOperation *operation = [[NSInvocationOperation alloc]
                                        initWithTarget:self
                                        selector:@selector(loadPlotImage)
                                        object:nil];
    [queue addOperation:operation];

    // Set the title
    self.title = self.plot.plotName;

    // Set the label texts
    self.plotNameLabel.text = self.plot.plotName;

    // Create a clickable link for the
    // plot.ly user (opens in webview)
    UIButton *plotUserLink = [[UIButton alloc] initWithFrame:CGRectMake(50, 400, 300, 28)];

    NSMutableAttributedString *plotUsernameTitle = [[NSMutableAttributedString alloc] initWithString:self.plot.plotUsername];

    [plotUsernameTitle addAttribute:NSUnderlineStyleAttributeName
                              value:[NSNumber numberWithInteger:NSUnderlineStyleSingle]
                              range:NSMakeRange(0, [plotUsernameTitle length])];

    [plotUsernameTitle addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.5058 green:0.7725 blue:0.9176 alpha:1.0] range:NSMakeRange(0, [plotUsernameTitle length])];
    [plotUserLink setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [plotUserLink setAttributedTitle:plotUsernameTitle forState:UIControlStateNormal];

    [plotUserLink addTarget:self action:@selector(openPlotUserWebView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:plotUserLink];

    // Create a clickable link for the plot
    // (opens in webview)
    UIButton *linkButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 450, 300, 28)];

    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:[kPlotlyURL stringByAppendingString:self.plot.plotURL]];
    [title addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [title length])];
    [title addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.5058 green:0.7725 blue:0.9176 alpha:1.0] range:NSMakeRange(0, [title length])];
    [linkButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [linkButton setAttributedTitle:title forState:UIControlStateNormal];
    linkButton.titleLabel.font = [UIFont systemFontOfSize:12];

    [linkButton addTarget:self action:@selector(openPlotWebView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:linkButton];
}

- (void)loadPlotImage
{
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:self.plot.thumbnailURL]];
    UIImage *image = [[UIImage alloc] initWithData:imageData];
    [self performSelectorOnMainThread:@selector(displayPlotImage:) withObject:image waitUntilDone:NO];
}

- (void)displayPlotImage:(UIImage *)image
{
    self.plotImage.image = image;
}

- (void)openPlotWebView
{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[kPlotlyURL stringByAppendingString:self.plot.plotURL]]]];
    [self.view addSubview:webView];
}

- (void)openPlotUserWebView
{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[kPlotlyURL stringByAppendingString:self.plot.plotUserURL]]]];
    [self.view addSubview:webView];
}

@end
