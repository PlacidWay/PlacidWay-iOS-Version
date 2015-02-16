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
    [self checkRotate:@"FreeQoutesViewController"];

    //[self setScrollBound:0];
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


    [self setBorderTextField:tv_messsage1];
    [self setBorderTextField:tf_name1];
    [self setBorderTextField:tf_email1];
    [self setBorderTextField:tf_phone1];
    [self setBorderTextField:tf_address1];
    [self setBorderTextField:tf_city1];
    [self setBorderTextField:tf_country1];
    [self setBorderTextField:tf_subject1];


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
-(void)setScrollAreaL:(NSInteger)h
{
    int i = tf_name1.frame.size.height;
    CGSize iOSDeviceScreenSize = [[UIScreen mainScreen] bounds].size;

    if (iOSDeviceScreenSize.height >= 1024)
        sv_scroll1.contentSize = CGSizeMake(616, 10*i + h);
    else if (iOSDeviceScreenSize.height >= 568)
        sv_scroll1.contentSize = CGSizeMake(320, 5*i + h);
    else
        sv_scroll1.contentSize = CGSizeMake(320, 10*i + h);
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
    if (!lan)
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
    else
    {
    if([tf_name1.text length]<=0)
    {
        [self showAlert:@"Enter Full Name"];
        [tf_name1 becomeFirstResponder];

        return;
    }
    else if([tf_email1.text length]<=0)
    {
        [self showAlert:@"Enter Email"];
        [tf_email1 becomeFirstResponder];

        return;
    }
    else if([tf_phone1.text length]<=0)
    {
        [self showAlert:@"Enter Phone"];
        [tf_phone1 becomeFirstResponder];

        return;
    }
    else if([tf_address1.text length]<=0)
    {
        [self showAlert:@"Enter Address Name"];
        [tf_address1 becomeFirstResponder];

        return;
    }
    else if([tf_city1.text length]<=0)
    {
        [self showAlert:@"Enter City"];
        [tf_city1 becomeFirstResponder];

        return;
    }
    else if([tf_country1.text length]<=0)
    {
        [self showAlert:@"Enter Country"];
        [tf_country1 becomeFirstResponder];

        return;
    }
    else if([tf_subject1.text length]<=0)
    {
        [self showAlert:@"Enter Subject"];
        [tf_subject1 becomeFirstResponder];

        return;
    }
    else if([tv_messsage1.text length]<=0)
    {
        [self showAlert:@"Enter Message"];
        [tv_messsage1 becomeFirstResponder];

        return;
    }
    else if(![self validateEmailWithString:tf_email1.text])
    {
        [self showAlert:@"Please Enter Valid Email Address."];
        [tf_email1 becomeFirstResponder];

    }
    else
    {
        [sv_scroll1 setContentOffset:CGPointMake(0, 0) animated:YES];

        [webService WSContactUs:tf_name1.text email:tf_email1.text phone:tf_phone1.text address:tf_address1.text city:tf_city1.text country:tf_country1.text subject:tf_subject1.text message:tv_messsage1.text:^(NSMutableArray *result)

         {
             NSString *msg = [result objectAtIndex:0];
             [self showAlert:msg];

         }];

    }
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
    if(!lan)
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
    else
    {
        if([textField isEqual:tf_name1]){
            [sv_scroll1 setContentOffset:CGPointMake(0, 0) animated:YES];
        }
        else if([textField isEqual:tf_email1]){
            [sv_scroll1 setContentOffset:CGPointMake(0,40) animated:YES];
        }
        else if([textField isEqual:tf_phone1]){
            [sv_scroll1 setContentOffset:CGPointMake(0,60) animated:YES];
        }
        else if([textField isEqual:tf_address1]){
            [sv_scroll1 setContentOffset:CGPointMake(0,140) animated:YES];
        }
        else if([textField isEqual:tf_city1]){
            [sv_scroll1 setContentOffset:CGPointMake(0,180) animated:YES];
        }
        else if([textField isEqual:tf_country1]){
            [sv_scroll1 setContentOffset:CGPointMake(0,210) animated:YES];
        }
        else if([textField isEqual:tf_subject1]){
            [sv_scroll1 setContentOffset:CGPointMake(0,230) animated:YES];
        }
        else if([textField isEqual:tv_messsage1]){
            [sv_scroll1 setContentOffset:CGPointMake(0,260) animated:YES];
        }

    }

}
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    //[sv_scroll setContentOffset:CGPointMake(0,0) animated:YES];
    //[self.view endEditing:YES];
    //return YES;
    if (!lan)//port
    {
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
            [self.view endEditing:YES];
            [tf_country becomeFirstResponder];
        }
        else if (theTextField == tf_country) {
            [tf_subject becomeFirstResponder];
        }
        else if (theTextField == tf_subject) {
            [tv_messsage becomeFirstResponder];
        }

    }
    else//land
    {
        if (theTextField == tv_messsage1) {
            [self.view endEditing:YES];
            [sv_scroll setContentOffset:CGPointMake(0,0) animated:YES];

        }
        else if (theTextField == tf_name1) {
            [tf_email1 becomeFirstResponder];
        }
        else if (theTextField == tf_email1) {
            if([self validateEmailWithString:tf_email1.text])
                [tf_phone1 becomeFirstResponder];
            else
            {
                [self showAlert:@"Please Enter Valid Email Address."];
                [tf_email1 becomeFirstResponder];
            }
        }
        else if (theTextField == tf_phone1) {
            [tf_address1 becomeFirstResponder];
        }
        else if (theTextField == tf_address1) {
            [tf_city1 becomeFirstResponder];
        }
        else if (theTextField == tf_city1) {
            [self.view endEditing:YES];
            [tf_country1 becomeFirstResponder];
        }
        else if (theTextField == tf_country1) {
            [tf_subject1 becomeFirstResponder];
        }
        else if (theTextField == tf_subject1) {
            [tv_messsage1 becomeFirstResponder];
        }

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

    if (!lan)
    {
        [self setScrollArea:keyboardSize.height];
    }
    else
        [self setScrollAreaL:keyboardSize.height];
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
    [self.view endEditing:YES];
    LeveyPopListView *lplv = [[LeveyPopListView alloc] initWithTitle:@"Select Country*" options:[[AppInfo sharedInfo] listAllCountries] handler:^(NSInteger anIndex) {
        [NSString stringWithFormat:@"%@", [[AppInfo sharedInfo] listAllCountries][anIndex]];
        tf_country.text = [[AppInfo sharedInfo] listAllCountries][anIndex];
        tf_country1.text = [[AppInfo sharedInfo] listAllCountries][anIndex];


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
- (void)orientationChanged:(NSNotification *)notification
{
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;

    NSLog(@" deviceOrientation %d=",deviceOrientation);

    if(UIInterfaceOrientationIsPortrait(deviceOrientation) && deviceOrientation != 2)
    {
        lan = false;
        //do for portrait
        self.myViewFromNib = [self.nibViews objectAtIndex:0];
        self.view = self.myViewFromNib;
        NSLog(@" port ");
        //[self orientationChanged];
        NSLog(@" tf_name %@",tf_name.text);
        NSLog(@" tf_name1 %@",tf_name1.text);

        NSLog(@" tf_email %@",tf_email.text);
        NSLog(@" tf_email1 %@",tf_email1.text);

        [tf_name setText:tf_name1.text];
        [tf_email setText:tf_email1.text];
        [tf_phone setText:tf_phone1.text];
        [tf_address setText:tf_address1.text];
        [tf_city setText:tf_city1.text];
        [tf_country setText:tf_country1.text];
        [tf_subject setText:tf_subject1.text];
        [tv_messsage setText:tv_messsage1.text];

        NSLog(@" tf_name %@",tf_name.text);
        NSLog(@" tf_name1 %@",tf_name1.text);

        NSLog(@" tf_email %@",tf_email.text);
        NSLog(@" tf_email1 %@",tf_email1.text);

    }
    else if(UIInterfaceOrientationIsLandscape(deviceOrientation) || deviceOrientation == 2)
    {
        lan = true;
        //do for Landscape
        self.myViewFromNib = [self.nibViews objectAtIndex:1];
        self.view = self.myViewFromNib;
        NSLog(@" land ");
        NSLog(@" tf_name %@",tf_name.text);
        NSLog(@" tf_name1 %@",tf_name1.text);

        NSLog(@" tf_email %@",tf_email.text);
        NSLog(@" tf_email1 %@",tf_email1.text);

        [tf_name1 setText:tf_name.text];
        [tf_email1 setText:tf_email.text];
        [tf_phone1 setText:tf_phone.text];
        [tf_address1 setText:tf_address.text];
        [tf_city1 setText:tf_city.text];
        [tf_country1 setText:tf_country.text];
        [tf_subject1 setText:tf_subject.text];
        [tv_messsage1 setText:tv_messsage.text];

        NSLog(@" tf_name %@",tf_name.text);
        NSLog(@" tf_name1 %@",tf_name1.text);

        NSLog(@" tf_email %@",tf_email.text);
        NSLog(@" tf_email1 %@",tf_email1.text);
    }
}
- (void)orientationChanged
{

    lan = ([UIScreen mainScreen].bounds.size.height > [UIScreen mainScreen].bounds.size.width ? false : true);


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
