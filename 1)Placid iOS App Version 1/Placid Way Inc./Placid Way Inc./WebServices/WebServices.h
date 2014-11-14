//
//  WebServices.h
//  Placid Way Inc.
//
//  Created by Mrs.Erum Abid Awan on 24/08/2014.
//  Copyright (c) 2014 Placid Way Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBJson.h"
#import "UrlManager.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "Treatment.h"
#import "Country.h"
#import "City.h"
#import "MedicalCenterInfo.h"

@interface WebServices : NSObject
{
    MBProgressHUD *hud;
}

@property(nonatomic,copy)NSMutableArray *response;

-(void)WSGetAllTreatment:(void (^)(NSMutableArray *result))callback;
-(void)WSGetAllCountry:(void (^)(NSMutableArray *result))callback;
-(void)WSGetAllCityOfCountry:(NSString*)country :(void (^)(NSMutableArray *result))callback;
-(void)WSGetSearchedMedicalList:(NSString*)country city:(NSString*)city treatment:(NSString*)treatment :(void (^)(NSMutableArray *result))callback;
-(void)WSContactUs:(NSString*)name email:(NSString*)email phone:(NSString*)phone address:(NSString*)address city:(NSString*)city country:(NSString*)country subject:(NSString*)subject message:(NSString*)message :(void (^)(NSMutableArray *result))callback;
-(void)WSGetDetailLink:(NSString*)detail_link :(void (^)(NSMutableArray *result))callback;
@end
