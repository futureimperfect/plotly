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

- (NSArray *)plotsFromJSONURL:(NSURL *)url {
    // Create a NSURLRequest with the given URL
    NSURLRequest *request = [NSURLRequest requestWithURL:url
                                             cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                         timeoutInterval:15.0];

    // Get the data
    NSURLResponse *response;
    NSError *error = nil;
	NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (error) {
        NSLog(@"NSURLConnection error: %@", error);
    }

    // Now create an NSArray from the JSON data
    NSArray *jsonArray = [[NSArray alloc] initWithArray:[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error]];
    if (error) {
        NSLog(@"NSJSONSerialization error: %@", error);
    }

    // Create a new array to hold the plots
    NSMutableArray *plots = [[NSMutableArray alloc] init];

    // Iterate through the array of dictionaries
    for (NSDictionary *dict in jsonArray) {
        // Create a new PLPlot object and initialise it with information from the dictionary
        PLPlot *plot = [[PLPlot alloc] initWithJSONDictionary:dict];
        // Add the PLPlot object to the array
        [plots addObject:plot];
    }

    // Return the array of PLPlot objects
    return plots;
}

@end
