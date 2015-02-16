//
//  MedicalCenterViewController.m
//  Placid Way Inc.
//
//  Created by Mrs.Erum Abid Awan on 24/08/2014.
//  Copyright (c) 2014 Placid Way Inc. All rights reserved.
//

#import "MedicalCenterViewController.h"
#import "SearchResultViewController.h"
#import "LeveyPopListView.h"
#import "MainViewController.h"
#import "DDURLParser.h"

@interface MedicalCenterViewController ()

@end

@implementation MedicalCenterViewController
@synthesize btn_treatment;
@synthesize btn_country;
@synthesize btn_city;
@synthesize btn_search;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    webService=[[WebServices alloc]init];

    [self checkRotate:@"MedicalCenterViewController"];

    // Do any additional setup after loading the view from its nib.
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];

    [AppInfo sharedInfo].listTreatment = [[NSMutableArray alloc] init];
    [AppInfo sharedInfo].listCountry = [[NSMutableArray alloc] init];
    [AppInfo sharedInfo].listCity = [[NSMutableArray alloc] init];


    self.lb_treatment.textColor = [UIColor whiteColor];
    self.lb_treatment.text = @"Choose Treatment";

    self.lb_country.textColor = [UIColor whiteColor];
    self.lb_country.text = @"Choose Country";

    self.lb_city.textColor = [UIColor whiteColor];
    self.lb_city.text = @"Choose City";

    //
    self.lb_treatment1.textColor = [UIColor whiteColor];
    self.lb_treatment1.text = @"Choose Treatment";

    self.lb_country1.textColor = [UIColor whiteColor];
    self.lb_country1.text = @"Choose Country";

    self.lb_city1.textColor = [UIColor whiteColor];
    self.lb_city1.text = @"Choose City";

    sel_treatment = [[NSString alloc]init];
    sel_country = [[NSString alloc]init];
    sel_city = [[NSString alloc]init];

    sel_treatment = @"";
    sel_city = @"";
    sel_country = @"";

}
-(void)viewWillAppear:(BOOL)animated
{

    //dispatch_async(dispatch_get_main_queue(), ^{
        [self onStart];
    //});
}
-(void)onStart
{


     if([AppInfo sharedInfo].listTreatment.count == 0)
    {

        [webService WSGetAllTreatment:^(NSMutableArray *result)
         {
             [AppInfo sharedInfo].listTreatment=result ;
             [self getTreatmentList];
             //call country service
             if([AppInfo sharedInfo].listCountry.count == 0)
             {
                 [webService WSGetAllCountry:^(NSMutableArray *result)
                  {
                      [AppInfo sharedInfo].listCountry=result ;
                      [self getCountryList];
                  }];
             }

         }];
    }
    else
    {
        [self getTreatmentList];
        [self getCountryList];

    }
    /*if([AppInfo sharedInfo].listCountry.count == 0)
    {
        [webService WSGetAllCountry:^(NSMutableArray *result)
         {
             [AppInfo sharedInfo].listCountry=result ;
             [self getCountryList];
         }];
    }
    else
    {
        [self getCountryList];
    }*/
    /*else
     {
     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!"
     message:@"No Internet Connection."
     delegate:self
     cancelButtonTitle:@"OK"
     otherButtonTitles:nil];
     [alert show];
     }*/

}
-(void)getTreatmentList
{
    self.listTreatment = [[NSMutableArray alloc]init];
    for (int i = 0; i < [AppInfo sharedInfo].listTreatment.count; i++)
    {
        Treatment *treat = [[AppInfo sharedInfo].listTreatment objectAtIndex:i];
        [self.listTreatment addObject:treat.name];
        
    }
}
-(void)getCountryList
{
    self.listCountry = [[NSMutableArray alloc]init];
    for (int i = 0; i < [AppInfo sharedInfo].listCountry.count; i++)
    {
        Country *country = [[AppInfo sharedInfo].listCountry objectAtIndex:i];
        [self.listCountry addObject:country.name];

    }
}
-(void)getCityList
{
    self.listCity = [[NSMutableArray alloc]init];
    for (int i = 0; i < [AppInfo sharedInfo].listCity.count; i++)
    {
        City *city = [[AppInfo sharedInfo].listCity objectAtIndex:i];
        [self.listCity addObject:city.name];

    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)showTreatmentListView
{
    if (self.listTreatment.count != 0)
    {
        LeveyPopListView *lplv = [[LeveyPopListView alloc] initWithTitle:@"Choose Treatment" options:self.listTreatment handler:^(NSInteger anIndex) {

            //sel_country = @"";
            //sel_city = @"";

            //self.btn_treatment.titleLabel.text =
            self.lb_treatment.text = [NSString stringWithFormat:@"%@", self.listTreatment[anIndex]];
            self.lb_treatment1.text = [NSString stringWithFormat:@"%@", self.listTreatment[anIndex]];
            sel_treatment = self.listTreatment[anIndex];
        }];
        //    lplv.delegate = self;
        [lplv showInView:self.view animated:YES];
    }
    else
    {
        if([AppInfo sharedInfo].listTreatment.count == 0)
        {

            [webService WSGetAllTreatment:^(NSMutableArray *result)
             {
                 [AppInfo sharedInfo].listTreatment=result ;
                 [self getTreatmentList];
                 //call country service
                 if([AppInfo sharedInfo].listCountry.count == 0)
                 {
                     [webService WSGetAllCountry:^(NSMutableArray *result)
                      {
                          [AppInfo sharedInfo].listCountry=result ;
                          [self getCountryList];
                      }];
                 }

             }];
        }
        else
        {
            [self getTreatmentList];
            [self getCountryList];
            
        }

    }
}
- (IBAction)showCountryListView
{
    if (self.listCountry.count != 0)
    {
        LeveyPopListView *lplv = [[LeveyPopListView alloc] initWithTitle:@"Choose Country" options:self.listCountry handler:^(NSInteger anIndex) {
            //self.btn_country.titleLabel.text =
            self.lb_country.text = [NSString stringWithFormat:@"%@", self.listCountry[anIndex]];
            self.lb_country1.text = [NSString stringWithFormat:@"%@", self.listCountry[anIndex]];
            sel_country = self.listCountry[anIndex];
            self.lb_city.text = @"Choose City";
            self.lb_city1.text = @"Choose City";

            sel_city = @"";
            sel_city = [[NSString alloc]init];

            [AppInfo sharedInfo].listCity = [[NSMutableArray alloc] init];

            //call service of city
            if([AppInfo sharedInfo].listCity.count == 0/* && [self connected]*/)
            {
                [webService WSGetAllCityOfCountry:sel_country:^(NSMutableArray *result)
                 {
                     //Treatment *t = [result objectAtIndex:0];
                     [AppInfo sharedInfo].listCity=result ;
                     [self getCityList];
                 }];
            }
        }];
        //    lplv.delegate = self;
        [lplv showInView:self.view animated:YES];
    }

}
- (IBAction)showCityListView
{

    if (self.listCity.count != 0)
    {
        LeveyPopListView *lplv = [[LeveyPopListView alloc] initWithTitle:@"Choose City" options:self.listCity handler:^(NSInteger anIndex) {
        //self.btn_city.titleLabel.text =

        self.lb_city.text = [NSString stringWithFormat:@"%@", self.listCity[anIndex]];

        self.lb_city1.text = [NSString stringWithFormat:@"%@", self.listCity[anIndex]];

        sel_city = self.listCity[anIndex];

        }];
        //    lplv.delegate = self;
        [lplv showInView:self.view animated:YES];
    }
    else
    {
        [[AppInfo sharedInfo] showAlert:@"Choice Country First."];
    }
}

- (IBAction)goSearchVC
{
    //if([AppInfo sharedInfo].listTreatment.count == 0/* && [self connected]*/)
    {
        [webService WSGetSearchedMedicalList:sel_country city:sel_city treatment:sel_treatment:^(NSMutableArray *result)
         {
             if (![[AppInfo sharedInfo].redirectLink isEqualToString:@""])
             {

                 DDURLParser *parse = [[DDURLParser alloc] initWithURLString:[AppInfo sharedInfo].redirectLink] ;


                [webService WSGetSearchedMedicalList:
                        [parse valueForVariable:@"countryName"] city:
                        [parse valueForVariable:@"cityName"] treatment:
                        [parse valueForVariable:@"treatmentPackageName"]:^(NSMutableArray *result)
                  {
                      [AppInfo sharedInfo].listMedicalCenter=result ;

                      SearchResultViewController *svc = [[SearchResultViewController alloc]initWithNibName:[AppInfo getNibNameFromName:@"SearchResultViewController"] bundle:[NSBundle mainBundle]];
                      UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:svc];
                      [navigationController setNavigationBarHidden:YES animated:NO];
                      [self presentViewController:navigationController animated:NO completion:nil];
                      
                      //[self getCountryList];
                  }];

             }
             else
             {
                 [AppInfo sharedInfo].listMedicalCenter=result ;

                 SearchResultViewController *svc = [[SearchResultViewController alloc]initWithNibName:[AppInfo getNibNameFromName:@"SearchResultViewController"] bundle:[NSBundle mainBundle]];
                 UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:svc];
                 [navigationController setNavigationBarHidden:YES animated:NO];
                 [self presentViewController:navigationController animated:NO completion:nil];
             }
             //[self getCountryList];
         }];
    }



    
}
-(IBAction)gotoHome:(id)sender
{
    MainViewController *vc = [[MainViewController alloc] initWithNibName:[AppInfo getNibNameFromName:@"MainViewController"] bundle:nil];
    id animation = [[AppInfo sharedInfo] getRightUpAnimationTransition];
    [self.navigationController.view.layer addAnimation:animation forKey:@"BottomUpAnimation"];
    [self.navigationController pushViewController:vc animated:NO];
}
- (IBAction)gotoback
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - LeveyPopListView delegates
- (void)leveyPopListView:(LeveyPopListView *)popListView didSelectedIndex:(NSInteger)anIndex {
    //self.show.titleLabel.text = [NSString stringWithFormat:@"%@",state_province[anIndex]];


}
- (void)leveyPopListViewDidCancel {
    //self.show.titleLabel.text = @"Select Province(CA)/State(US)";
    //province = @"";
    
}
- (void)orientationChanged:(NSNotification *)notification
{
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;

    NSLog(@" deviceOrientation %ld=",deviceOrientation);

    if(UIInterfaceOrientationIsPortrait(deviceOrientation) && deviceOrientation != 2)
    {
        //do for portrait
        self.myViewFromNib = [self.nibViews objectAtIndex:0];
        self.view = self.myViewFromNib;
        NSLog(@" port ");
        //[self orientationChanged];

    }
    else if(UIInterfaceOrientationIsLandscape(deviceOrientation) || deviceOrientation == 2)
    {
        //do for Landscape
        self.myViewFromNib = [self.nibViews objectAtIndex:1];
        self.view = self.myViewFromNib;
        NSLog(@" land ");

    }
}
- (void)orientationChanged
{

    BOOL lan = ([UIScreen mainScreen].bounds.size.height > [UIScreen mainScreen].bounds.size.width ? false : true);


    if(!lan)
    {
        //do for portrait
        self.myViewFromNib = [self.nibViews objectAtIndex:0];
        self.view = self.myViewFromNib;


    }
    else if(lan)
    {
        //do for Landscape
        self.myViewFromNib = [self.nibViews objectAtIndex:1];
        self.view = self.myViewFromNib;
    }
}
-(BOOL)shouldAutorotate {
    // Preparations to rotate view go here

    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait |
    UIInterfaceOrientationMaskLandscape;
}
-(void)checkRotate:(NSString*)name
{
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(orientationChanged:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];

    self.nibViews = [[NSBundle mainBundle] loadNibNamed:[AppInfo getNibNameFromName:name]
                                                  owner:self
                                                options:nil];
    
    [self orientationChanged];
    
}

-(IBAction)makeCall
{
    NSString *phoneNumber = [@"telprompt://" stringByAppendingString:[AppInfo sharedInfo].placidCall];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
    UIDevice *device = [UIDevice currentDevice];
    if ([[device model] isEqualToString:@"iPhone"] )
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
    }
    else
    {
        UIAlertView *notPermitted=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Your device doesn't support this feature." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [notPermitted show];
    }
}
- (IBAction)openMail:(id)sender
{
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];

        mailer.mailComposeDelegate = self;

        [mailer setSubject:@"PlacidWay Inc."];

        [mailer setToRecipients:@[@"info@placidway.com"]];

        [self presentViewController:mailer animated:YES completion:NULL];

    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                        message:@"Your device doesn't support the composer sheet"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }

}
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved: you saved the email message in the drafts folder.");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed: the email message was not saved or queued, possibly due to an error.");
            break;
        default:
            NSLog(@"Mail not sent.");
            break;
    }

    // Remove the mail view
    [self dismissViewControllerAnimated:YES completion:nil];//issModalViewControllerAnimated:YES];
}

@end
