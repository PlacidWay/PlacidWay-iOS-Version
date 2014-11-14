//
//  MainViewController.h
//  Placid Way Inc.
//
//  Created by Mrs.Erum Abid Awan on 24/08/2014.
//  Copyright (c) 2014 Placid Way Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController

@property(nonatomic,strong) IBOutlet UIButton *btn_MedicalCenter;
@property(nonatomic,strong) IBOutlet UIButton *btn_FreeQoutes;
@property(nonatomic,strong) IBOutlet UIButton *btn_AboutUs;

-(IBAction)goToMedicalCenterVC:(id)sender;
-(IBAction)goToFreeQouteVC:(id)sender;
-(IBAction)goToAboutUsVC:(id)sender;


@end
