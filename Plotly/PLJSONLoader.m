//
//  PLJSONLoader.m
//  Plotly
//
//  Created by James Barclay on 6/20/14.
//  Copyright (c) 2014 Everything is Gray. All rights reserved.
//

#import "PLJSONLoader.h"
#import "PLPlot.h"
#import "TFHpple.h"

@implementation PLJSONLoader

- (NSArray *)plotsFromJSONURL:(NSURL *)url
{
    // Get the feed JSON string from plot.ly/feed
    NSString *jsonString = [self getPlotlyFeedJSON:url];
    NSLog(@"jsonString: %@", jsonString);

    // Convert our JSON String to an NSData object
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"jsonData: %@", jsonData);

//    NSError *error = nil;
//    NSMutableArray *mutableArray = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
//
//    if (error) {
//        NSLog(@"JSONObjectWithData error: %@", error);
//    }
//
//    for (NSMutableDictionary *mutableDct in mutableArray) {
//        NSString *arrayString = mutableDct[@"raw"];
//        if (arrayString) {
//            NSData *data = [arrayString dataUsingEncoding:NSUTF8StringEncoding];
//            NSError *error = nil;
//            mutableDct[@"raw"] = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
//            NSLog(@"mutableDct[\"@raw\"]: %@", mutableDct[@"raw"]);
//            if (error) {
//                NSLog(@"JSONObjectWithData for array error: %@", error);
//            }
//        }
//    }

    // Serialize JSON from our NSData object
    NSError *error = nil;
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    if (error) {
        NSLog(@"JSONObjectWithData error: %@", error);
    }

    NSLog(@"jsonDictionary: %@", jsonDictionary);

    // Initialize a mutable array to hold our plots
    NSMutableArray *plots = [[NSMutableArray alloc] init];

    // Get an array of dictionaries with the key "nodeChildArray"
    NSArray *array = [jsonDictionary objectForKey:@"raw"];
    NSLog(@"array: %@", array);

    // Iterate through our array of dicts
    for (NSDictionary *dct in array) {
        // Create a new PLPlot object for each and init with info from dict
        PLPlot *plot = [[PLPlot alloc] initWithJSONDictionary:dct];
        // Add the PLPlot object to our mutable array
        [plots addObject:plot];
    }

    return plots;
}

- (NSString *)getPlotlyFeedJSON:(NSURL *)url
{
    NSData *plotlyFeedHtmlData = [NSData dataWithContentsOfURL:url];

    TFHpple *plotlyHtmlParser = [TFHpple hppleWithHTMLData:plotlyFeedHtmlData];

    NSString *feedXpathQueryString = @"//script[@id='feeditem-json']";
    NSArray *feedNodes = [plotlyHtmlParser searchWithXPathQuery:feedXpathQueryString];
    NSString *json = [feedNodes componentsJoinedByString:@""];
    NSString *jsonWithoutBackslashes = [json stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    NSLog(@"json: %@", jsonWithoutBackslashes);
    return jsonWithoutBackslashes;
}

@end
