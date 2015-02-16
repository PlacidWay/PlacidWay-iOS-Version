//
//  MainViewController.h
//  Placid Way Inc.
//
//  Created by Mrs.Erum Abid Awan on 24/08/2014.
//  Copyright (c) 2014 Placid Way Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface MainViewController : UIViewController<MFMailComposeViewControllerDelegate>

@property(nonatomic,strong) NSArray *nibViews;
@property (nonatomic, strong) UIView *myViewFromNib;

@property(nonatomic,strong) IBOutlet UIButton *btn_MedicalCenter;
@property(nonatomic,strong) IBOutlet UIButton *btn_FreeQoutes;
@property(nonatomic,strong) IBOutlet UIButton *btn_AboutUs;

-(IBAction)goToMedicalCenterVC:(id)sender;
-(IBAction)goToFreeQouteVC:(id)sender;
-(IBAction)goToPricingVC:(id)sender;
-(IBAction)goToAboutUsVC:(id)sender;

-(IBAction)makeCall;
-(IBAction)openMail:(id)sender;

@end
