//
//  PLPlot.h
//  Plotly
//
//  Created by James Barclay on 6/20/14.
//  Copyright (c) 2014 Everything is Gray. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PLPlot : NSObject

-(id)initWithJSONDictionary:(NSDictionary *)jsonDictionary;

@property (readonly) NSString *plotName;
@property (readonly) NSString *plotUserURL;
@property (readonly) NSString *plotUsername;
@property (readonly) NSString *plotURL;
@property (readonly) NSString *thumbnailURL;

@end
