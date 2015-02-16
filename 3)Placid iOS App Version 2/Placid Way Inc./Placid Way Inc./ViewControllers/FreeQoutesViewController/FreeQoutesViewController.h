//
//  FreeQoutesViewController.h
//  Placid Way Inc.
//
//  Created by Mrs.Erum Abid Awan on 24/08/2014.
//  Copyright (c) 2014 Placid Way Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FreeQoutesViewController : UIViewController<UIScrollViewDelegate,UITextFieldDelegate,UITextViewDelegate,UIAlertViewDelegate,MFMailComposeViewControllerDelegate>
{
    WebServices *webService;
    IBOutlet UITextField *tf_name,*tf_email,*tf_phone,*tf_address,*tf_city,*tf_country,*tf_subject;
    IBOutlet UITextField *tv_messsage;

    IBOutlet UITextField *tf_name1,*tf_email1,*tf_phone1,*tf_address1,*tf_city1,*tf_country1,*tf_subject1;
    IBOutlet UITextField *tv_messsage1;

    IBOutlet UIScrollView *sv_scroll,*sv_scroll1;
    IBOutlet UIButton *btn_Country;
    IBOutlet UIButton *btn_Submit;
    IBOutlet UIImageView *bg;

    BOOL lan;


}
@property(nonatomic,strong) NSArray *nibViews;
@property (nonatomic, strong) UIView *myViewFromNib;

- (IBAction)gotoback;
- (IBAction)gotosubmit;

- (IBAction)showAllCountriesListView;

-(IBAction)makeCall;
-(IBAction)openMail:(id)sender;

@end
