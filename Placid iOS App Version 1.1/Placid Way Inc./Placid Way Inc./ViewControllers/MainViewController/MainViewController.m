//
//  MainViewController.m
//  Placid Way Inc.
//
//  Created by Mrs.Erum Abid Awan on 24/08/2014.
//  Copyright (c) 2014 Placid Way Inc. All rights reserved.
//

#import "MainViewController.h"
#import "MedicalCenterViewController.h"
#import "FreeQoutesViewController.h"
#import "AboutUsViewController.h"
#import "PriceViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize btn_MedicalCenter;
@synthesize btn_FreeQoutes;
@synthesize btn_AboutUs;

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

    [self checkRotate:@"MainViewController"];

}
-(IBAction)goToMedicalCenterVC:(id)sender
{
    MedicalCenterViewController *fvc = [[MedicalCenterViewController alloc]initWithNibName:[AppInfo getNibNameFromName:@"MedicalCenterViewController"]  bundle:[NSBundle mainBundle]];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:fvc];
    [navigationController setNavigationBarHidden:YES animated:NO];
    [self presentViewController:navigationController animated:YES completion:nil];
}
-(IBAction)goToFreeQouteVC:(id)sender
{
    FreeQoutesViewController *freeQoutevc = [[FreeQoutesViewController alloc]initWithNibName:[AppInfo getNibNameFromName:@"FreeQoutesViewController"] bundle:[NSBundle mainBundle]];

    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:freeQoutevc];
    [navigationController setNavigationBarHidden:YES animated:NO];
    [self presentViewController:navigationController animated:YES completion:nil];

}
-(IBAction)goToPricingVC:(id)sender
{
    PriceViewController *pricvc = [[PriceViewController alloc]initWithNibName:[AppInfo getNibNameFromName:@"PriceViewController"] bundle:[NSBundle mainBundle]];

    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:pricvc];
    [navigationController setNavigationBarHidden:YES animated:NO];
    [self presentViewController:navigationController animated:YES completion:nil];
}
-(IBAction)goToAboutUsVC:(id)sender
{
    AboutUsViewController *aboutvc = [[AboutUsViewController alloc]initWithNibName:[AppInfo getNibNameFromName:@"AboutUsViewController"]  bundle:[NSBundle mainBundle]];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:aboutvc];
    [navigationController setNavigationBarHidden:YES animated:NO];
    [self presentViewController:navigationController animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)orientationChanged:(NSNotification *)notification
{
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;

    NSLog(@" deviceOrientation %d=",deviceOrientation);

    if(UIInterfaceOrientationIsPortrait(deviceOrientation) && deviceOrientation <= 2)
    {
        //do for portrait
        self.myViewFromNib = [self.nibViews objectAtIndex:0];
        self.view = self.myViewFromNib;
        NSLog(@" port ");
        //[self orientationChanged];

    }
    else if(UIInterfaceOrientationIsLandscape(deviceOrientation) && deviceOrientation > 2)
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
