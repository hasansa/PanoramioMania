//
//  GameController.h
//  PanoramioMania
//
//  Created by Hasan_Sawaed on 8/10/13.
//  Copyright (c) 2013 Hasan_Sawaed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PanoramioController.h"
#import "panoramioObject.h"

#import "AsyncImageView.h"
#import "NSMutableArray+Shuffle.h"

#import "PanoramioDataModelController.h"


@protocol GameControllerDelegate <NSObject>

-(void)didFinishShuffling:(PanoramioObject*)object;

@end

@interface GameController : NSObject <PanoramioControllerDelegate>
//
@property(strong ,nonatomic) PanoramioDataModelController* panoramioData;
@property(strong , nonatomic) Location* loc;
//
@property (strong , nonatomic) NSMutableArray* gameArray;
@property(assign , nonatomic) NSInteger myLevel;
@property(assign , nonatomic) NSInteger myScore;
@property(assign ,nonatomic) NSInteger myLives;

@property (assign, nonatomic) id <GameControllerDelegate> delegate;


-(void) initLevels;
-(NSInteger) levelQuizCnt;
-(void) addObjectsToTheGameArray;

@end
