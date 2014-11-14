//
//  Treatment.h
//  Placid Way Inc.
//
//  Created by Mrs.Erum Abid Awan on 24/08/2014.
//  Copyright (c) 2014 Placid Way Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Treatment : NSObject
{
    int _id;
    NSMutableString *name;
}

@property(nonatomic,assign)int _id;
@property(nonatomic,copy)NSMutableString *name;

@end
