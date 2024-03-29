//
//  PLPlot.m
//  Plotly
//
//  Created by James Barclay on 6/20/14.
//  Copyright (c) 2014 Everything is Gray. All rights reserved.
//

#import "PLPlot.h"

@implementation PLPlot

-(id)initWithJSONDictionary:(NSDictionary *)jsonDictionary
{
    if (self = [self init]) {
        _plotName = [jsonDictionary objectForKey:@"plot_name"];
        _plotUserURL = [jsonDictionary objectForKey:@"user_url"];
        _plotUsername = [jsonDictionary objectForKey:@"username"];
        _plotURL = [jsonDictionary objectForKey:@"plot_url"];
        _thumbnailURL = [jsonDictionary objectForKey:@"thumbnail_url"];
    }

    return self;
}

@end
