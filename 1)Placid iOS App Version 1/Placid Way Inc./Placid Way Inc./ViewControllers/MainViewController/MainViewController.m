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
    // Do any additional setup after loading the view from its nib.
    //[self performSelector:@selector(showFirstViewController) withObject:nil afterDelay:1.5];

    //[[AppInfo sharedInfo] setBorderButton:btn_MedicalCenter];
    //[[AppInfo sharedInfo] setBorderButton:btn_FreeQoutes];
    //[[AppInfo sharedInfo] setBorderButton:btn_AboutUs];


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

@end
