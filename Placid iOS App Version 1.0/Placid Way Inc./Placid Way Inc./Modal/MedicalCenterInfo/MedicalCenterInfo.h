//
//  MedicalCenterInfo.h
//  Placid Way Inc.
//
//  Created by Mrs.Erum Abid Awan on 03/09/2014.
//  Copyright (c) 2014 Placid Way Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MedicalCenterInfo : NSObject

@property(nonatomic,assign)int _id;
@property(nonatomic,copy)NSMutableString *imageName;
@property(nonatomic,copy)NSMutableString *title;
@property(nonatomic,copy)NSMutableString *description;
@property(nonatomic,copy)NSMutableString *phone;
@property(nonatomic,copy)NSMutableString *state;
@property(nonatomic,copy)NSMutableString *city;
@property(nonatomic,copy)NSMutableString *country;
@property(nonatomic,copy)NSMutableString *detail_link;
@property(nonatomic,copy)UIImage *img;


@end
