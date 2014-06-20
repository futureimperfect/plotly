//
//  PLJSONLoader.m
//  Plotly
//
//  Created by James Barclay on 6/20/14.
//  Copyright (c) 2014 Everything is Gray. All rights reserved.
//

#import "PLJSONLoader.h"
#import "PLPlot.h"

@implementation PLJSONLoader

-(NSArray *)plotsFromJSONString:(NSString *)jsonString
{
    // Convert our JSON String to an NSData object
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];

    // Serialize JSON from our NSData object
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];

    // Initialize a mutable array to hold our plots
    NSMutableArray *plots = [[NSMutableArray alloc] init];

    // Get an array of dictionaries with the key "nodeChildArray"
    NSArray *array = [jsonDictionary objectForKey:@"nodeChildArray"];

    // Iterate through our array of dicts
    for (NSDictionary *dct in array) {
        // Create a new PLPlot object for each and init with info from dict
        PLPlot *plot = [[PLPlot alloc] initWithJSONDictionary:dct];
        // Add the PLPlot object to our mutable array
        [plots addObject:plot];
    }
    return plots;
}

@end
