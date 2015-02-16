//
//  AboutUsViewController.m
//  Placid Way Inc.
//
//  Created by Mrs.Erum Abid Awan on 08/09/2014.
//  Copyright (c) 2014 Placid Way Inc. All rights reserved.
//

#import "AboutUsViewController.h"
#import "MainViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

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
    tv_about_us.textColor = [UIColor whiteColor];//[[AppInfo sharedInfo] colorWithHex:0x93dff2 alpha:1.0];
    fontSize = 14;


    pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGesture:)];

    [tv_about_us addGestureRecognizer:pinchGestureRecognizer];

}
- (void)pinchGesture:(UIPinchGestureRecognizer *)gestureRecognizer
{

    float fs = fontSize * [gestureRecognizer scale];

    if ( fs < MAXFONTSIZE &&
         fs > MINFONTSIZE)
        tv_about_us.font = [UIFont fontWithName:tv_about_us.font.fontName size:fs];
}
-(IBAction)gotoHome:(id)sender
{
    MainViewController *vc = [[MainViewController alloc] initWithNibName:[AppInfo getNibNameFromName:@"MainViewController"] bundle:nil];
    id animation = [[AppInfo sharedInfo] getRightUpAnimationTransition];
    [self.navigationController.view.layer addAnimation:animation forKey:@"BottomUpAnimation"];
    [self.navigationController pushViewController:vc animated:NO];
}
- (IBAction)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
