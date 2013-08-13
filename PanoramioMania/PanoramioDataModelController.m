//
//  PanoramioDataModelController.m
//  PanoramioMania
//
//  Created by Hasan_Sawaed on 8/9/13.
//  Copyright (c) 2013 Hasan_Sawaed. All rights reserved.
//

#import "PanoramioDataModelController.h"


@interface PanoramioDataModelController()
    
    @property (strong , nonatomic) NSDictionary* panoramioDictionary;
    
    @end

@implementation PanoramioDataModelController
    
-(void) readPanoramioPlistData{
    
    NSString* panoarmioManiaFileDirectory = [[NSBundle mainBundle] pathForResource:@"PanoramioMania" ofType:@"plist"];
    
    _panoramioDictionary = [[NSDictionary alloc] initWithContentsOfFile:panoarmioManiaFileDirectory];
    
    //
    
    Continent* continent;
    Country* country;
    City* city;
    Location* location;
    
    //
    
    _allLocations = [NSMutableArray array];
    
    NSArray* continentArray = [_panoramioDictionary objectForKey:@"Continent"];
    
    for (NSDictionary* continentDic in continentArray) {
        continent = [[Continent alloc] init];
        continent.continentName = [continentDic objectForKey:@"ContinentName"];
        continent.countries =  [NSMutableArray array];
        
      
        
        for (NSDictionary* countryDic in [continentDic objectForKey:@"Countries"]){
            country = [[Country alloc]init];
            NSString* name =[countryDic objectForKey:@"CountryName"];
            country.countryName = name;
            country.cities = [NSMutableArray array];
            country.continent = continent;
            
      
            
            for (NSDictionary* cityDic in [countryDic objectForKey:@"Cities"] ){
                city = [[City alloc]init];
                city.cityName = [cityDic objectForKey:@"CityName"];
                city.locations = [NSMutableArray array];
                city.country = country;
                
     
                
                for (NSDictionary* locationDic in [cityDic objectForKey:@"Location"] ){
                    location = [[Location alloc]init];
                    location.location = [[CLLocation alloc]
                                         initWithLatitude:[[locationDic objectForKey:@"lat"]doubleValue]
                                         longitude:[[locationDic objectForKey:@"lon"] doubleValue]];
                    location.difficultyOffset = 0.015;
                    location.city = city;
                    
                    [_allLocations addObject:location];
                    
                    [city.locations addObject:location];
                }
             
                [country.cities addObject:city];
            }
            
            [continent.countries addObject:country];
        }
    }
}
    @end
