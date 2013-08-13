//
//  Game.m
//  PanoramioPhotosQ-1
//
//  Created by Hasan_Sawaed on 8/6/13.
//  Copyright (c) 2013 Hasan_Sawaed. All rights reserved.
//

#import "Game.h"
@implementation Game

-(void) initCards{
    
    _cardPhotosArray = [NSMutableArray array];
    
    PhotoCard * photoCard = [[PhotoCard alloc]initWithCardName:@"Akko" WithCardLocation:[[CLLocation alloc] initWithLatitude:32.933052 longitude:35.082678]];
    [_cardPhotosArray addObject:photoCard];
    //
    photoCard = [[PhotoCard alloc]initWithCardName:@"Haifa" WithCardLocation:[[CLLocation alloc] initWithLatitude:32.8000 longitude:34.9833]];
    [_cardPhotosArray addObject:photoCard];
    //
    photoCard = [[PhotoCard alloc]initWithCardName:@"Tel-Aviv" WithCardLocation:[[CLLocation alloc] initWithLatitude:32.0833 longitude:34.8000]];
    [_cardPhotosArray addObject:photoCard];
    //
    photoCard = [[PhotoCard alloc]initWithCardName:@"Tiberias" WithCardLocation:[[CLLocation alloc] initWithLatitude:32.795859 longitude:35.530973]];
    [_cardPhotosArray addObject:photoCard];
    //
    photoCard = [[PhotoCard alloc]initWithCardName:@"Juresalem" WithCardLocation:[[CLLocation alloc] initWithLatitude:31.768319 longitude:35.213710]];
    [_cardPhotosArray addObject:photoCard];
    //
    photoCard = [[PhotoCard alloc]initWithCardName:@"Eilat" WithCardLocation:[[CLLocation alloc] initWithLatitude:29.557669 longitude:34.951925]];
    [_cardPhotosArray addObject:photoCard];
    
}

-(void) downloadPhotos{
    NSInteger level = 1;
    
    if (level == 1) {
        NSMutableArray* refreshedArray = [NSMutableArray array];
        
        for (PhotoCard* card in _cardPhotosArray) {
            
            NSString* city = card.cardName;
            NSString* pop = @"public";
            CLLocation* loc = card.cardLocation;
            
            PanoramioRequestController* requestedPhoto = [[PanoramioRequestController alloc] initRequestWithCity:city WithPopularity:pop WithLocation:loc];
            
            [refreshedArray addObject: [requestedPhoto updateData]];
            
        }
        [_cardPhotosArray removeAllObjects];
        _cardPhotosArray =refreshedArray;
    }
    
}

-(Photo*) randomPhoto{
    
    Photo* photo= [[Photo alloc]init];
    
    if([_cardPhotosArray count]> 0 ){
        
        NSUInteger randomCity = arc4random() % _cardPhotosArray.count;
        NSUInteger randomPhotoFromCity = arc4random() % [[_cardPhotosArray objectAtIndex:randomCity] count];
        
        photo = [[_cardPhotosArray objectAtIndex:randomCity] objectAtIndex:randomPhotoFromCity];
            [[_cardPhotosArray objectAtIndex:randomCity] removeObjectAtIndex:randomPhotoFromCity];
        }
        return photo;
    }
    
    -(BOOL) isSoulution{
        
        
        return NO;
    }
    
    
    @end
