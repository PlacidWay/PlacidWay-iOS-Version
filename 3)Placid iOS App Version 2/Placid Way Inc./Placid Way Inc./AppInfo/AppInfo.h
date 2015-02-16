//
//  AppInfo.h
//  Placid Way Inc.
//
//  Created by Mrs.Erum Abid Awan on 24/08/2014.
//  Copyright (c) 2014 Placid Way Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PaginationInfo.h"

#define MINFONTSIZE 14
#define MAXFONTSIZE 30

@interface AppInfo : NSObject

@property (nonatomic, strong) NSMutableArray *listTreatment;
@property (nonatomic, strong) NSMutableArray *listProcedure;
@property (nonatomic, strong) NSMutableArray *listCountry;
@property (nonatomic, strong) NSMutableArray *listCity;
@property (nonatomic, strong) NSMutableArray *listMedicalCenter;
@property (nonatomic, strong) NSMutableArray *listAllCountries;
@property (nonatomic, strong) NSMutableArray *listPriceMedicalCenter;
@property (nonatomic, strong) NSMutableArray *listAveragePriceMedicalCenter;
@property (nonatomic, strong) NSMutableArray *listFeaturePriceMedicalCenter;

@property (nonatomic, strong) NSString *redirectLink;

@property (nonatomic, strong) NSString *placidCall;
@property (nonatomic, strong) NSString *placidMail;


@property (nonatomic, strong) PaginationInfo *pageInfo;

@property (nonatomic, strong) PaginationInfo *pageFInfo;
@property (nonatomic, strong) PaginationInfo *pageAInfo;

+(AppInfo*)sharedInfo;
+(NSString*)getNibNameFromName:(NSString*)name;
-(NSMutableArray*)getListofAllCountries;
-(void)setBorderButton:(UIButton*)button;
-(void)showAlert:(NSString*)msg;
-(void)showErrorAlert;
-(void)showPricingAlert;
-(void)showConnectionErrorAlert;
-(id)getLeftUpAnimationTransition;
-(id)getRightUpAnimationTransition;
-(UIColor*)colorWithHex:(UInt32)hex alpha:(CGFloat)alpha;

@end
