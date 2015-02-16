//
//  PaginationInfo.h
//  Placid Way Inc.
//
//  Created by Mrs.Erum Abid Awan on 27/12/2014.
//  Copyright (c) 2014 Placid Way Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PaginationInfo : NSObject

@property(nonatomic,assign)NSInteger start;
@property(nonatomic,assign)NSInteger end;
@property(nonatomic,assign)NSInteger total;
@property(nonatomic,copy)NSMutableString *Next;

@end
