//
//  PLJSONLoader.h
//  Plotly
//
//  Created by James Barclay on 6/20/14.
//  Copyright (c) 2014 Everything is Gray. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PLJSONLoader : NSObject

- (NSArray *)plotsFromJSONURL:(NSURL *)url;
- (NSString *)getPlotlyFeedJSON:(NSURL *)url;

@end
