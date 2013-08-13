//
//  PanoramioController.m
//  Chatty
//
//  Created by amir hayek on 6/22/13.
//  Copyright (c) 2013 amir hayek. All rights reserved.
//

#import "PanoramioController.h"



//#define valueOffset 0.001
//#define numberMaxImages 10

#define ksizeImageMedium @"medium"
#define webPanoramio @"http://www.panoramio.com/map/get_panoramas.php"

#define kPanoramioImageTitle @"photo_title"
#define kPanoramioImageUrl @"photo_file_url"
#define kPanoramioImageDate @"upload_date"
#define kPanoramioLatitude @"latitude"
#define kPanoramioLongtitude @"longitude"

@interface PanoramioController ()

@property (strong, nonatomic) NSMutableArray* dataArray;

@end

@implementation PanoramioController


-(void)panoramioConnectionWithLocation:(Location*)location
{
    float x1,y1,x2,y2;
    
    x1 = location.location.coordinate.longitude-_valueOffset;
    x2 = location.location.coordinate.longitude+_valueOffset;
    y1 = location.location.coordinate.latitude-_valueOffset;
    y2 = location.location.coordinate.latitude+_valueOffset;
    
    NSString *postMedium = [NSString stringWithFormat:@"?set=public&from=0&to=%d&minx=%f&miny=%f&maxx=%f&maxy=%f&size=%@&mapfilter=true", _numberMaxImages,x1,y1,x2,y2,ksizeImageMedium];
    
    NSString *hostStrMedium = [webPanoramio stringByAppendingString:postMedium];
    
    NSURL* urlMedium = [NSURL URLWithString:hostStrMedium];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlMedium];
    
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * response, NSData *data, NSError *error)
    {
        if(data==nil){
            NSLog(@"panoramio not reachable, error: %@",error.userInfo);
        }else{
            NSError* error;
            NSDictionary* jsonMedium = [NSJSONSerialization JSONObjectWithData:data
                                                                       options:kNilOptions
                                                                         error:&error];
            NSArray* photosMedium = [jsonMedium objectForKey:@"photos"];
            
            if (_dataArray==nil) {
                _dataArray=[[NSMutableArray alloc] init];
            }else{
                [_dataArray removeAllObjects];
            }
            
            for (NSDictionary* photoDict in photosMedium) {
                PanoramioObject* panObj = [[PanoramioObject alloc] init];
                [panObj setPhotoLocation:location];
                [panObj setTitle:[photoDict objectForKey:kPanoramioImageTitle]];
                [panObj setImageDate:[photoDict objectForKey:kPanoramioImageDate]];
                [panObj setImageUrl:[photoDict objectForKey:kPanoramioImageUrl]];
                CLLocationDegrees latitude = [[photoDict objectForKey:kPanoramioLatitude] doubleValue];
                CLLocationDegrees longtitude = [[photoDict objectForKey:kPanoramioLongtitude] doubleValue];
                CLLocation* location = [[CLLocation alloc] initWithLatitude:latitude longitude:longtitude];
                [panObj setLocation:location];
                
                [_dataArray addObject:panObj];
            }
            
            if (_delegate) {
                if ([_dataArray count] > 0) {
               
                [_dataArray shuffle];
                    
                [_delegate didFinishpanoramioConnectionWithObjects:[_dataArray objectAtIndex:0]];
                }
            }
        }
    }];
}


@end
