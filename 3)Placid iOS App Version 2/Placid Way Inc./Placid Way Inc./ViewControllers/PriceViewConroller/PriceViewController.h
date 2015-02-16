//
//  PriceViewController.h
//  Placid Way Inc.
//
//  Created by Mrs.Erum Abid Awan on 07/12/2014.
//  Copyright (c) 2014 Placid Way Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PriceViewController : UIViewController<MFMailComposeViewControllerDelegate>
{
    WebServices *webService;
    NSString *sel_treatment;
    NSString *sel_procedure;
    NSString *sel_country;


}
@property (nonatomic, strong) NSMutableArray  *listTreatment;
@property (nonatomic, strong) NSMutableArray  *listProcedure;
@property (nonatomic, strong) NSMutableArray  *listCountry;

@property (strong, nonatomic) IBOutlet UIButton *btn_treatment;
@property (strong, nonatomic) IBOutlet UIButton *btn_procedure;
@property (strong, nonatomic) IBOutlet UIButton *btn_country;
@property (strong, nonatomic) IBOutlet UIButton *btn_search;

@property (strong, nonatomic) IBOutlet UILabel *lb_treatment,*lb_treatment1;
@property (strong, nonatomic) IBOutlet UILabel *lb_procedure,*lb_procedure1;
@property (strong, nonatomic) IBOutlet UILabel *lb_country,*lb_country1;

@property(nonatomic,strong) NSArray *nibViews;
@property (nonatomic, strong) UIView *myViewFromNib;

- (IBAction)showTreatmentListView;
- (IBAction)showProcedureListView;
- (IBAction)showCountryListView;

- (IBAction)gotoback;
- (IBAction)goSearchVC;

-(IBAction)makeCall;
-(IBAction)openMail:(id)sender;

@end
