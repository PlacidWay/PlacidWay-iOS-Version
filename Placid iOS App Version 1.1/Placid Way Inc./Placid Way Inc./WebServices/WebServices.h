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
#import "Treatment.h"
#import "Country.h"
#import "City.h"
#import "MedicalCenterInfo.h"
#import "Procedure.h"
#import "AverageCenterInfo.h"
#import "FeaturedCenterInfo.h"
#import "PaginationInfo.h"

@interface WebServices : NSObject
{

}

@property(nonatomic,copy)NSMutableArray *response;

-(void)WSGetAllTreatment:(void (^)(NSMutableArray *result))callback;
-(void)WSGetAllCountry:(void (^)(NSMutableArray *result))callback;
-(void)WSGetAllCityOfCountry:(NSString*)country :(void (^)(NSMutableArray *result))callback;
-(void)WSGetSearchedMedicalList:(NSString*)country city:(NSString*)city treatment:(NSString*)treatment :(void (^)(NSMutableArray *result))callback;
-(void)WSContactUs:(NSString*)name email:(NSString*)email phone:(NSString*)phone address:(NSString*)address city:(NSString*)city country:(NSString*)country subject:(NSString*)subject message:(NSString*)message :(void (^)(NSMutableArray *result))callback;
-(void)WSGetDetailLink:(NSString*)detail_link :(void (^)(NSMutableArray *result))callback;
//
-(void)WSGetPricingTreatment:(void (^)(NSMutableArray *result))callback;
-(void)WSGetPricingProcedureByTreatment:(NSString*)treatment :(void (^)(NSMutableArray *result))callback;
-(void)WSGetPricingCountryByProcedure:(NSString*)procedure  treatment:(NSString*)treatment :(void (^)(NSMutableArray *result))callback;
-(void)WSGetPricingSearchList:(NSString*)treatment procedure:(NSString*)procedure country:(NSString*)country :(void (^)(NSMutableArray *result))callback;
-(void)WSGetPricingpaginationList:(NSString*)purl isFeature:(BOOL)isFeature :(void (^)(NSMutableArray *result))callback;

-(void)WSGetPriceAvgSearchedMedicalList:(NSString*)url :(void (^)(NSMutableArray *result))callback;
@end
