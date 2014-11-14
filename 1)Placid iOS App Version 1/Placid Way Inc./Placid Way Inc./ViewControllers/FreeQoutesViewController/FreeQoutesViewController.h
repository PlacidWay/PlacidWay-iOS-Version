//
//  FreeQoutesViewController.h
//  Placid Way Inc.
//
//  Created by Mrs.Erum Abid Awan on 24/08/2014.
//  Copyright (c) 2014 Placid Way Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FreeQoutesViewController : UIViewController<UIScrollViewDelegate,UITextFieldDelegate,UITextViewDelegate,UIAlertViewDelegate>
{
    WebServices *webService;
    IBOutlet UITextField *tf_name,*tf_email,*tf_phone,*tf_address,*tf_city,*tf_country,*tf_subject;
    IBOutlet UITextField *tv_messsage;

    IBOutlet UIScrollView *sv_scroll;
    IBOutlet UIButton *btn_Country;
    IBOutlet UIButton *btn_Submit;


}

- (IBAction)gotoback;
- (IBAction)gotosubmit;

- (IBAction)showAllCountriesListView;

@end
