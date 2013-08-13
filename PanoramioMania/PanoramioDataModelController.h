//
//  PanoramioDataModelController.h
//  PanoramioMania
//
//  Created by Hasan_Sawaed on 8/9/13.
//  Copyright (c) 2013 Hasan_Sawaed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"

@interface PanoramioDataModelController : NSObject
@property (strong , nonatomic) NSMutableArray* allLocations;

-(void) readPanoramioPlistData;
@end
