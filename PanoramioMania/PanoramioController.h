//
//  PanoramioController.h
//  Chatty
//
//  Created by amir hayek on 6/22/13.
//  Copyright (c) 2013 amir hayek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "panoramioObject.h"
#import "NSMutableArray+Shuffle.h"

@protocol PanoramioControllerDelegate <NSObject>

-(void)didFinishpanoramioConnectionWithObjects:(PanoramioObject*)object;

@end

@interface PanoramioController : NSObject


-(void)panoramioConnectionWithLocation:(Location*)location;

@property (assign, nonatomic) double valueOffset;
@property (assign, nonatomic) int numberMaxImages;

@property (assign, nonatomic) id <PanoramioControllerDelegate> delegate;

@end
