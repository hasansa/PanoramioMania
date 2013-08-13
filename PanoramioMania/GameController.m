//
//  GameController.m
//  PanoramioMania
//
//  Created by Hasan_Sawaed on 8/10/13.
//  Copyright (c) 2013 Hasan_Sawaed. All rights reserved.
//

#import "GameController.h"
#define kLevel1 10
#define kLevel2 20
#define kLevel3 30
#define kLevel4 40

#define kMaxPhotosNumber 50

@interface GameController ()

@property(strong , nonatomic) PanoramioController* panoramioController;
@property(assign , nonatomic) double difficultyOffset;

@end

@implementation GameController


-(void) initLevels
{
    _gameArray = [NSMutableArray array];
    
    _panoramioData = [[PanoramioDataModelController alloc] init];
    [_panoramioData readPanoramioPlistData];
    
    _panoramioController = [[PanoramioController alloc]init];
    [_panoramioController setDelegate:self];
    
    [_panoramioController setNumberMaxImages:kMaxPhotosNumber];
    
    [self setup];
    
}


- (void)setup {
    
    
    if ([_gameArray count] > 0)
    {
        if (_delegate)
        {
            [_delegate didFinishShuffling:[_gameArray lastObject]];
        }
    }
    else
    {
        [self addObjectsToTheGameArray];
        
    }
    
    
}


-(void) addObjectsToTheGameArray{
    
    switch (_myLevel) {
            
        case 1:
        {
            _difficultyOffset = 0.1;
            [_panoramioController setValueOffset:_difficultyOffset];
            
            
        }
            break;
        case 2:
        {
            _difficultyOffset = 0.25;
            [_panoramioController setValueOffset:_difficultyOffset];
            
            
            
        }
            break;
        case 3:
        {
            _difficultyOffset = 0.45;
            [_panoramioController setValueOffset:_difficultyOffset];
            
            
        }
            break;
        case 4:
        {
            _difficultyOffset = 0.95;
            [_panoramioController setValueOffset:_difficultyOffset];
            
            
        }
            break;
            
        default:
            break;
    }
    
    
    _loc = [[[_panoramioData allLocations] shuffle] objectAtIndex:0];
    
    [_panoramioController panoramioConnectionWithLocation:_loc];
    
    
    
}
-(NSInteger) levelQuizCnt{
    
    NSInteger levelQuizCnt = -1;
    
    switch (_myLevel) {
        case 1:
        {
            levelQuizCnt = kLevel1;
            
        }
            break;
        case 2:
        {
            levelQuizCnt = kLevel2;
        }
            
            break;
        case 3:
        {
            levelQuizCnt = kLevel3;
        }
            break;
        case 4:
        {
            levelQuizCnt = kLevel4;
        }
            break;
            
        default:
            break;
    }
    return levelQuizCnt;
}
#pragma mark - PanoramioDelegate

-(void)didFinishpanoramioConnectionWithObjects:(PanoramioObject*)object{
    
    if (object != nil){
        if(![self isExist:object]){
            [_gameArray addObject: object];
            
            [self setup];
            
        }
    }else
        [self addObjectsToTheGameArray];
    
}

-(Boolean) isExist:(PanoramioObject*) object{
    
    for (PanoramioObject* obj in _gameArray) {
        if ([obj.title isEqualToString:object.title]){
            return  YES;
        }
    }
    return NO;
}




@end
