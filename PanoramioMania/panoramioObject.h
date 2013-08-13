//
//  panoramioObject.h
//  Chatty
//
//  Created by amir hayek on 6/22/13.
//  Copyright (c) 2013 amir hayek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "Location.h"
@interface PanoramioObject : NSObject

@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSString* imageUrl;
@property (strong, nonatomic) NSString* imageDate;
@property (strong, nonatomic) CLLocation* location;
@property(strong, nonatomic) Location* photoLocation;

@property (nonatomic, strong) UIImage *image;

@end
