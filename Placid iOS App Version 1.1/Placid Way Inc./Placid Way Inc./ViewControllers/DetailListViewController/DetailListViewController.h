//
//  DetailListViewController.h
//  Placid Way Inc.
//
//  Created by Mrs.Erum Abid Awan on 03/09/2014.
//  Copyright (c) 2014 Placid Way Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "MWFSlideNavigationViewController.h"
#import <MessageUI/MessageUI.h>

@interface DetailListViewController : UIViewController<UITextViewDelegate,MFMailComposeViewControllerDelegate,UIWebViewDelegate>/*<MWFSlideNavigationViewControllerDelegate, MWFSlideNavigationViewControllerDataSource>*/
{
    UIPinchGestureRecognizer *pinchGestureRecognizer;

    float fontSize;
    WebServices *webService;
    MedicalCenterInfo *medInfo;
    NSString *html;
    UIActivityIndicatorView *loadingIndicator;

}

@property (nonatomic, weak) IBOutlet UITextView *tv_centerDetail;
@property (nonatomic, weak) IBOutlet UILabel *lbl_contact_info;
@property (nonatomic, weak) IBOutlet UILabel *lbl_contact_email;

@property (nonatomic, weak) IBOutlet UILabel *lbl_center_title;

@property (nonatomic, weak) IBOutlet UILabel *lbl_location;

@property (nonatomic, weak) IBOutlet UIButton *btn_arrow;

@property(nonatomic,strong) IBOutlet UIWebView *web;

//@property (nonatomic, strong) IBOutlet UIBarButtonItem * slideLeftButton;
@property (nonatomic, assign) int med_id;

- (IBAction)gotoback;
//- (IBAction)slideLeft;
-(IBAction)goToFreeQouteVC:(id)sender;
-(IBAction)makeCall;

-(IBAction)makeCall;
-(IBAction)openMail:(id)sender;

@end
