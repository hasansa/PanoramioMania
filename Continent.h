//
//  Continent.h
//  PanoramioMania
//
//  Created by Hasan_Sawaed on 8/9/13.
//  Copyright (c) 2013 Hasan_Sawaed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Continent : NSObject

@property (nonatomic, strong) NSString * continentName;
@property (nonatomic, strong) NSMutableArray *countries;
@end



