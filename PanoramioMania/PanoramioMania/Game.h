//
//  Game.h
//  PanoramioPhotosQ-1
//
//  Created by Hasan_Sawaed on 8/6/13.
//  Copyright (c) 2013 Hasan_Sawaed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PanoramioRequestController.h"
#import "PhotoCard.h"
@import MapKit;

@interface Game : NSObject

@property (strong , nonatomic) NSMutableArray* cardPhotosArray;
@property (assign , nonatomic) NSInteger score;
@property (assign , nonatomic) NSInteger level;
@property  (assign , nonatomic) NSInteger levelPhotosCount;
@property (strong , nonatomic) NSString* solution;
//
-(void) initCards;
-(void) downloadPhotos;
-(Photo*) randomPhoto;
-(BOOL) isSoulution;


@end
