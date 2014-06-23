//
//  PLDetailViewController.h
//  Plotly
//
//  Created by James Barclay on 6/19/14.
//  Copyright (c) 2014 Everything is Gray. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PLPlot.h"

@interface PLDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) PLPlot *plot;

@end
