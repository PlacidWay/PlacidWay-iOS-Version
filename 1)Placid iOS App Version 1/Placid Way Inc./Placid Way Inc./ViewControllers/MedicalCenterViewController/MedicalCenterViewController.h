//
//  MedicalCenterViewController.h
//  Placid Way Inc.
//
//  Created by Mrs.Erum Abid Awan on 24/08/2014.
//  Copyright (c) 2014 Placid Way Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MedicalCenterViewController : UIViewController
{
    WebServices *webService;
    NSString *sel_treatment;
    NSString *sel_country;
    NSString *sel_city;


}
@property (nonatomic, strong) NSMutableArray  *listTreatment;
@property (nonatomic, strong) NSMutableArray  *listCountry;
@property (nonatomic, strong) NSMutableArray  *listCity;



@property (strong, nonatomic) IBOutlet UIButton *btn_treatment;
@property (strong, nonatomic) IBOutlet UIButton *btn_country;
@property (strong, nonatomic) IBOutlet UIButton *btn_city;
@property (strong, nonatomic) IBOutlet UIButton *btn_search;

@property (strong, nonatomic) IBOutlet UILabel *lb_treatment;
@property (strong, nonatomic) IBOutlet UILabel *lb_country;
@property (strong, nonatomic) IBOutlet UILabel *lb_city;

- (IBAction)showTreatmentListView;
- (IBAction)showCountryListView;
- (IBAction)showCityListView;

- (IBAction)gotoback;

- (IBAction)goSearchVC;
@end
