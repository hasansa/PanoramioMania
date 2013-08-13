//
//  Country.h
//  PanoramioMania
//
//  Created by Hasan_Sawaed on 8/9/13.
//  Copyright (c) 2013 Hasan_Sawaed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Continent.h"

@class Continent;

@interface Country : NSObject

@property (nonatomic, strong) NSString * countryName;
@property (nonatomic, strong) NSMutableArray *cities;
@property (nonatomic, strong) Continent *continent;

@end
