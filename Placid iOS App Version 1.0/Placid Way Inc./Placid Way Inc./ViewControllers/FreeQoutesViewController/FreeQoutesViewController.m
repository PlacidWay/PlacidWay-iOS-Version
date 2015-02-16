//
//  FreeQoutesViewController.m
//  Placid Way Inc.
//
//  Created by Mrs.Erum Abid Awan on 24/08/2014.
//  Copyright (c) 2014 Placid Way Inc. All rights reserved.
//

#import "FreeQoutesViewController.h"
#import "LeveyPopListView.h"
#import "MainViewController.h"
#import "ADTransition.h"
#import "ADTransitioningDelegate.h"
#import "ADCubeTransition.h"

@interface FreeQoutesViewController ()

@end

@implementation FreeQoutesViewController

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

   // [self setScrollBound:0];
    webService=[[WebServices alloc]init];

    [[AppInfo sharedInfo] getListofAllCountries];

    [self setBorderTextField:tv_messsage];
    [self setBorderTextField:tf_name];
    [self setBorderTextField:tf_email];
    [self setBorderTextField:tf_phone];
    [self setBorderTextField:tf_address];
    [self setBorderTextField:tf_city];
    [self setBorderTextField:tf_country];
    [self setBorderTextField:tf_subject];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self registerForKeyboardNotifications];

}
-(void)setScrollBound:(NSInteger)h
{
    CGSize iOSDeviceScreenSize = [[UIScreen mainScreen] bounds].size;

    if (iOSDeviceScreenSize.height >= 568)
    {
        sv_scroll.bounds = CGRectMake(0, 0, 320, 430+h);
    }
    else
    {
        sv_scroll.bounds = CGRectMake(0, 0, 320, 340+h);
    }

}
-(void)setScrollArea:(NSInteger)h
{
    int i = tf_name.frame.size.height;
    CGSize iOSDeviceScreenSize = [[UIScreen mainScreen] bounds].size;

    if (iOSDeviceScreenSize.height >= 1024)
        sv_scroll.contentSize = CGSizeMake(616, 15*i + h);
    else if (iOSDeviceScreenSize.height >= 568)
        sv_scroll.contentSize = CGSizeMake(320, 8*i + h);
    else
        sv_scroll.contentSize = CGSizeMake(320, 15*i + h);

}
-(void)setBorderTextField:(UITextField*)textField
{
    //textField.textColor = [UIColor whiteColor];
    [textField setReturnKeyType:UIReturnKeyDone];

    textField.textColor = [UIColor whiteColor];//[[AppInfo sharedInfo] colorWithHex:0x93dff2 alpha:1.0];

    textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:textField.placeholder attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];

}
-(void)setBorderTextView:(UITextView*)textView
{
    //
    [textView.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
    [textView.layer setBorderWidth:0.5];

    //The rounded corner part, where you specify your view's corner radius:
    textView.layer.cornerRadius = 5;
    textView.clipsToBounds = YES;
    
}
- (IBAction)gotoback
{
    /*MainViewController *vc = [[MainViewController alloc] initWithNibName:[AppInfo getNibNameFromName:@"MainViewController"] bundle:nil];
    id animation = [[AppInfo sharedInfo] getRightUpAnimationTransition];
    [self.navigationController.view.layer addAnimation:animation forKey:@"BottomUpAnimation"];
    [self.navigationController pushViewController:vc animated:NO];*/
    [self dismissViewControllerAnimated:YES completion:nil];

    //UIViewController * newViewController = [[UIViewController alloc] init];

    /*MainViewController *vc = [[MainViewController alloc] initWithNibName:[AppInfo getNibNameFromName:@"MainViewController"] bundle:nil];
    ADTransition * transition = [[ADCubeTransition alloc] initWithDuration:0.25f orientation:ADTransitionRightToLeft sourceRect:self.view.frame];
    ADTransitioningDelegate * transitioningDelegate = [[ADTransitioningDelegate alloc] initWithTransition:transition];
    vc.transitioningDelegate = transitioningDelegate;
    [self.navigationController pushViewController:vc animated:YES];*/
}
-(IBAction)gotoHome:(id)sender
{
    MainViewController *vc = [[MainViewController alloc] initWithNibName:[AppInfo getNibNameFromName:@"MainViewController"] bundle:nil];
    id animation = [[AppInfo sharedInfo] getRightUpAnimationTransition];
    [self.navigationController.view.layer addAnimation:animation forKey:@"BottomUpAnimation"];
    [self.navigationController pushViewController:vc animated:NO];
}
- (IBAction)gotosubmit
{
    if([tf_name.text length]<=0)
    {
        [self showAlert:@"Enter Full Name"];
        [tf_name becomeFirstResponder];

        return;
    }
    else if([tf_email.text length]<=0)
    {
        [self showAlert:@"Enter Email"];
        [tf_email becomeFirstResponder];

        return;
    }
    else if([tf_phone.text length]<=0)
    {
        [self showAlert:@"Enter Phone"];
        [tf_phone becomeFirstResponder];

        return;
    }
    else if([tf_address.text length]<=0)
    {
        [self showAlert:@"Enter Address Name"];
        [tf_address becomeFirstResponder];

        return;
    }
    else if([tf_city.text length]<=0)
    {
        [self showAlert:@"Enter City"];
        [tf_city becomeFirstResponder];

        return;
    }
    else if([tf_country.text length]<=0)
    {
        [self showAlert:@"Enter Country"];
        [tf_country becomeFirstResponder];

        return;
    }
    else if([tf_subject.text length]<=0)
    {
        [self showAlert:@"Enter Subject"];
        [tf_subject becomeFirstResponder];

        return;
    }
    else if([tv_messsage.text length]<=0)
    {
        [self showAlert:@"Enter Message"];
        [tv_messsage becomeFirstResponder];

        return;
    }
    else if(![self validateEmailWithString:tf_email.text])
    {
        [self showAlert:@"Please Enter Valid Email Address."];
        [tf_email becomeFirstResponder];

    }
    else
    {
        [sv_scroll setContentOffset:CGPointMake(0, 0) animated:YES];

        [webService WSContactUs:tf_name.text email:tf_email.text phone:tf_phone.text address:tf_address.text city:tf_city.text country:tf_country.text subject:tf_subject.text message:tv_messsage.text:^(NSMutableArray *result)

         {
             NSString *msg = [result objectAtIndex:0];
             [self showAlert:msg];
             
         }];
    }



}

- (BOOL)validateEmailWithString:(NSString*)_email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:_email];
}
//
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if([textField isEqual:tf_name]){
        [sv_scroll setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    else if([textField isEqual:tf_email]){
        [sv_scroll setContentOffset:CGPointMake(0,20) animated:YES];
    }
    else if([textField isEqual:tf_phone]){
        [sv_scroll setContentOffset:CGPointMake(0,40) animated:YES];
    }
    else if([textField isEqual:tf_address]){
        [sv_scroll setContentOffset:CGPointMake(0,60) animated:YES];
    }
    else if([textField isEqual:tf_city]){
        [sv_scroll setContentOffset:CGPointMake(0,80) animated:YES];
    }
    else if([textField isEqual:tf_country]){
        [sv_scroll setContentOffset:CGPointMake(0,100) animated:YES];
    }
    else if([textField isEqual:tf_subject]){
        [sv_scroll setContentOffset:CGPointMake(0,120) animated:YES];
    }
    else if([textField isEqual:tv_messsage]){
        [sv_scroll setContentOffset:CGPointMake(0,140) animated:YES];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    //[sv_scroll setContentOffset:CGPointMake(0,0) animated:YES];
    //[self.view endEditing:YES];
    //return YES;

    if (theTextField == tv_messsage) {
        [self.view endEditing:YES];
        [sv_scroll setContentOffset:CGPointMake(0,0) animated:YES];

    }
    else if (theTextField == tf_name) {
        [tf_email becomeFirstResponder];
    }
    else if (theTextField == tf_email) {
        if([self validateEmailWithString:tf_email.text])
            [tf_phone becomeFirstResponder];
        else
        {
            [self showAlert:@"Please Enter Valid Email Address."];
            [tf_email becomeFirstResponder];
        }
    }
    else if (theTextField == tf_phone) {
        [tf_address becomeFirstResponder];
    }
    else if (theTextField == tf_address) {
        [tf_city becomeFirstResponder];
    }
    else if (theTextField == tf_city) {
        [tf_country becomeFirstResponder];
    }
    else if (theTextField == tf_country) {
        [tf_subject becomeFirstResponder];
    }
    else if (theTextField == tf_subject) {
        [tv_messsage becomeFirstResponder];
    }
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{

    NSString *msg = [alertView message];

    NSString *data = @"Success";

    if ([msg rangeOfString:@"Success" options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        NSLog(@"Matched : %@",data);
        [self dismissViewControllerAnimated:YES completion:nil];

    }
    else
    {
        NSLog(@"Not Matched : %@",data);
    }

}
- (void)registerForKeyboardNotifications {

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

}

- (void)deregisterFromKeyboardNotifications {

    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidHideNotification
                                                  object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
}
- (void)viewWillDisappear:(BOOL)animated {

    [self deregisterFromKeyboardNotifications];

    [super viewWillDisappear:animated];
    
}

- (void)keyboardWasShown:(NSNotification *)notification {

    NSDictionary* info = [notification userInfo];

    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;

    [self setScrollArea:keyboardSize.height];
}

- (void)keyboardWillBeHidden:(NSNotification *)notification {

    //[Scroll setContentOffset:CGPointZero animated:YES];
    
}
-(void)showAlert:(NSString*)msg
{
    UIAlertView *Alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [Alert show];
}
- (IBAction)showAllCountriesListView
{
    LeveyPopListView *lplv = [[LeveyPopListView alloc] initWithTitle:@"Select Country*" options:[[AppInfo sharedInfo] listAllCountries] handler:^(NSInteger anIndex) {
        [NSString stringWithFormat:@"%@", [[AppInfo sharedInfo] listAllCountries][anIndex]];
        tf_country.text = [[AppInfo sharedInfo] listAllCountries][anIndex];

    }];
    //    lplv.delegate = self;
    [lplv showInView:self.view animated:YES];
}
#pragma mark - LeveyPopListView delegates
- (void)leveyPopListView:(LeveyPopListView *)popListView didSelectedIndex:(NSInteger)anIndex
{
    //self.show.titleLabel.text = [NSString stringWithFormat:@"%@",state_province[anIndex]];
}
- (void)leveyPopListViewDidCancel
{
    //self.show.titleLabel.text = @"Select Province(CA)/State(US)";
    //province = @"";
}
@end
