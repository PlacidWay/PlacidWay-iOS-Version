//
//  DetailListViewController.m
//  Placid Way Inc.
//
//  Created by Mrs.Erum Abid Awan on 03/09/2014.
//  Copyright (c) 2014 Placid Way Inc. All rights reserved.
//

#import "DetailListViewController.h"
//#import "MenuLeftViewController.h"
#import "FreeQoutesViewController.h"
#import "MainViewController.h"
#import "KGModal.h"

@interface DetailListViewController ()

@end

@implementation DetailListViewController

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
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;

    loadingIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(screenWidth/2, screenHeight/2, 20,20)];
    [loadingIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [loadingIndicator setHidesWhenStopped:YES];
    //self.slideNavigationViewController.delegate = self;
    //self.slideNavigationViewController.dataSource = self;
    fontSize = 14;

    pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGesture:)];

    [self.tv_centerDetail addGestureRecognizer:pinchGestureRecognizer];

    NSLog(@"ID :%d",self.med_id);


    medInfo = [[AppInfo sharedInfo].listMedicalCenter objectAtIndex:self.med_id];


    self.lbl_contact_email.textColor = [UIColor whiteColor];
    self.lbl_contact_info.textColor = [UIColor whiteColor];
    self.lbl_location.textColor = [UIColor whiteColor];

    NSString *loc = @"";
    if (![medInfo.city isEqualToString:@""]) {
        loc = [loc stringByAppendingString:[NSString stringWithFormat:@"%@",medInfo.city]];
        if (![medInfo.state isEqualToString:@""] ||
            ![medInfo.country isEqualToString:@""])
        {
            loc = [loc stringByAppendingString:@" | "];
        }
    }
    if (![medInfo.state isEqualToString:@""])
    {
        loc = [loc stringByAppendingString:[NSString stringWithFormat:@"%@",medInfo.state]];
        if (![medInfo.country isEqualToString:@""])
        {
            loc = [loc stringByAppendingString:@" | "];
        }
    }
    if (![medInfo.country isEqualToString:@""])
    {
        loc = [loc stringByAppendingString:[NSString stringWithFormat:@"%@",medInfo.country]];

    }

    self.lbl_location.text = loc;
    self.lbl_contact_info.text = [AppInfo sharedInfo].placidCall;//@"+1-303-500-3821";//medInfo.phone;
    self.lbl_contact_email.text = [AppInfo sharedInfo].placidMail;//@"info@placidway.com";//medInfo.phone;


    if ([[[AppInfo sharedInfo].listMedicalCenter objectAtIndex:self.med_id] isKindOfClass:[FeaturedCenterInfo class]])
    {

        FeaturedCenterInfo *finfo = [[AppInfo sharedInfo].listMedicalCenter objectAtIndex:self.med_id];
        self.lbl_center_title.text = finfo.center_name;

    }
    else
       self.lbl_center_title.text = medInfo.title;

    webService=[[WebServices alloc]init];
    //self.web.scalesPageToFit=YES;

    html = @"http://placidway:placidway@";
    html = [html stringByAppendingString:UrlBase2];
    html = [html stringByAppendingString:medInfo.detail_link];
    [self.web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:html]]];
    [self.web addSubview:loadingIndicator];

    /*[webService WSGetDetailLink:medInfo.detail_link :^(NSMutableArray *result)
    {
         //self.tv_centerDetail.text = loc;

         NSString *htmlFile = [result objectAtIndex:0];//[[NSBundle mainBundle] pathForResource:@"web" ofType:@"txt"];
        html = htmlFile;

         NSString *embedHTML =[NSString stringWithFormat:htmlFile];

         NSString* htmlString = [NSString stringWithContentsOfFile:embedHTML encoding:NSUTF8StringEncoding error:nil];
        
         [self.web loadHTMLString:htmlFile baseURL:nil];

         //[self getCountryList];
     }];*/
    [KGModal sharedInstance].closeButtonType = KGModalCloseButtonTypeRight;

    //[self.window makeKeyAndVisible];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willShow:) name:KGModalWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didShow:) name:KGModalDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willHide:) name:KGModalWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didHide:) name:KGModalDidHideNotification object:nil];

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
- (void)pinchGesture:(UIPinchGestureRecognizer *)gestureRecognizer
{

    float fs = fontSize * [gestureRecognizer scale];

    if ( fs < MAXFONTSIZE &&
        fs > MINFONTSIZE)
        self.tv_centerDetail.font = [UIFont fontWithName:self.tv_centerDetail.font.fontName size:fs];
}
-(IBAction)btnMaxTapped:(id)sender
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;

    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth*0.85, screenHeight*0.85)];

    CGRect welcomeLabelRect = contentView.bounds;
    welcomeLabelRect.origin.y = 20;
    welcomeLabelRect.size.height = 20;
    UIFont *welcomeLabelFont = [UIFont boldSystemFontOfSize:17];
    UILabel *welcomeLabel = [[UILabel alloc] initWithFrame:welcomeLabelRect];
    welcomeLabel.text = @"Welcome to KGModal!";
    welcomeLabel.font = welcomeLabelFont;
    welcomeLabel.textColor = [UIColor whiteColor];
    welcomeLabel.textAlignment = NSTextAlignmentCenter;
    welcomeLabel.backgroundColor = [UIColor clearColor];
    welcomeLabel.shadowColor = [UIColor blackColor];
    welcomeLabel.shadowOffset = CGSizeMake(0, 1);
    //[contentView addSubview:welcomeLabel];

    CGRect infoLabelRect = CGRectInset(contentView.bounds, 5, 5);
    infoLabelRect.origin.y = CGRectGetMaxY(welcomeLabelRect)+5;
    infoLabelRect.size.height -= CGRectGetMinY(infoLabelRect) + 50;
    UILabel *infoLabel = [[UILabel alloc] initWithFrame:infoLabelRect];
    infoLabel.text = @"KGModal is an easy drop in control that allows you to display any view "
    "in a modal popup. The modal will automatically scale to fit the content view "
    "and center it on screen with nice animations!";
    infoLabel.numberOfLines = 6;
    infoLabel.textColor = [UIColor whiteColor];
    infoLabel.textAlignment = NSTextAlignmentCenter;
    infoLabel.backgroundColor = [UIColor clearColor];
    infoLabel.shadowColor = [UIColor blackColor];
    infoLabel.shadowOffset = CGSizeMake(0, 1);
    //[contentView addSubview:infoLabel];

    CGFloat btnY = CGRectGetMaxY(infoLabelRect)+5;
    CGFloat btnH = CGRectGetMaxY(contentView.frame)-5 - btnY;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(infoLabelRect.origin.x, btnY, infoLabelRect.size.width, btnH);
    [btn setTitle:@"Close Button Right" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(changeCloseButtonType:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:btn];

    UIWebView *webview=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, screenWidth*0.85, screenHeight*0.85)];

    //[webview loadHTMLString:html baseURL:nil];
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:html]]];
    [webview addSubview:loadingIndicator];

    [contentView addSubview:webview];

    //[[self.view webview] loadRequest:nsrequest];
    //    [[KGModal sharedInstance] setCloseButtonLocation:KGModalCloseButtonLocationRight];
    [[KGModal sharedInstance] showWithContentView:contentView andAnimated:YES];

}
- (BOOL)webView:(UIWebView *)wv shouldStartLoadWithRequest:(NSURLRequest *)rq
{
    [loadingIndicator startAnimating];
    return YES;
}

- (void)webViewDidFinishLoading:(UIWebView *)wv
{
    [loadingIndicator stopAnimating];
}

- (void)webView:(UIWebView *)wv didFailLoadWithError:(NSError *)error
{
    [loadingIndicator stopAnimating];
}
- (void)willShow:(NSNotification *)notification{
    NSLog(@"will show");
}

- (void)didShow:(NSNotification *)notification{
    NSLog(@"did show");
}

- (void)willHide:(NSNotification *)notification{
    NSLog(@"will hide");
}

- (void)didHide:(NSNotification *)notification{
    NSLog(@"did hide");
}

- (void)changeCloseButtonType:(id)sender{
    UIButton *button = (UIButton *)sender;
    KGModal *modal = [KGModal sharedInstance];
    KGModalCloseButtonType type = modal.closeButtonType;

    if(type == KGModalCloseButtonTypeLeft){
        modal.closeButtonType = KGModalCloseButtonTypeRight;
        [button setTitle:@"Close Button Right" forState:UIControlStateNormal];
    }else if(type == KGModalCloseButtonTypeRight){
        modal.closeButtonType = KGModalCloseButtonTypeNone;
        [button setTitle:@"Close Button None" forState:UIControlStateNormal];
    }else{
        modal.closeButtonType = KGModalCloseButtonTypeLeft;
        [button setTitle:@"Close Button Left" forState:UIControlStateNormal];
    }
}

/*- (void) slideLeft:(id)sender {
    [self _slide:MWFSlideDirectionLeft];
}
#pragma mark Actions
- (void) _slide:(MWFSlideDirection)direction {

    // MWFDemoSecondaryViewController * secCtl = [[MWFDemoSecondaryViewController alloc] init];
     UINavigationController * navCtl = [[UINavigationController alloc] initWithRootViewController:secCtl];
     [self.slideNavigationViewController slideForViewController:navCtl
     direction:direction
     portraitOrientationDistance:180
     //landscapeOrientationDistance:100];

    [self.slideNavigationViewController slideWithDirection:direction];
}
- (IBAction) slideLeft
{
    [self _slide:MWFSlideDirectionLeft];
}
- (void) close:(id)sender {
    [self _slide:MWFSlideDirectionNone];
}*/
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
-(IBAction)goToFreeQouteVC:(id)sender
{
    FreeQoutesViewController *freeQoutevc = [[FreeQoutesViewController alloc]initWithNibName:[AppInfo getNibNameFromName:@"FreeQoutesViewController"] bundle:[NSBundle mainBundle]];

    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:freeQoutevc];
    [navigationController setNavigationBarHidden:YES animated:NO];
    [self presentViewController:navigationController animated:YES completion:nil];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*#pragma mark - MWFSlideNavigationViewControllerDelegate
#define VIEWTAG_OVERLAY 1100
- (void) slideNavigationViewController:(MWFSlideNavigationViewController *)controller willPerformSlideFor:(UIViewController *)targetController withSlideDirection:(MWFSlideDirection)slideDirection distance:(CGFloat)distance orientation:(UIInterfaceOrientation)orientation {

    if (slideDirection == MWFSlideDirectionNone) {

        UIView * overlay = [self.navigationController.view viewWithTag:VIEWTAG_OVERLAY];
        [overlay removeFromSuperview];

    } else {

        UIView * overlay = [[UIView alloc] initWithFrame:self.navigationController.view.bounds];
        overlay.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        overlay.tag = VIEWTAG_OVERLAY;
        UITapGestureRecognizer * gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close:)];
        [overlay addGestureRecognizer:gr];
        overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self.navigationController.view addSubview:overlay];

    }
}
- (void) slideNavigationViewController:(MWFSlideNavigationViewController *)controller animateSlideFor:(UIViewController *)targetController withSlideDirection:(MWFSlideDirection)slideDirection distance:(CGFloat)distance orientation:(UIInterfaceOrientation)orientation
{
    UIView * overlay = [self.navigationController.view viewWithTag:VIEWTAG_OVERLAY];
    if (slideDirection == MWFSlideDirectionNone)
    {
        overlay.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    }
    else
    {
        overlay.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    }
}
- (NSInteger) slideNavigationViewController:(MWFSlideNavigationViewController *)controller distanceForSlideDirecton:(MWFSlideDirection)direction portraitOrientation:(BOOL)portraitOrientation
{
    if (portraitOrientation)
    {
        return 180;
    }
    else
    {
        return 100;
    }
}
#pragma mark - MWFSlideNavigationViewControllerDataSource
- (UIViewController *) slideNavigationViewController:(MWFSlideNavigationViewController *)controller viewControllerForSlideDirecton:(MWFSlideDirection)direction
{
    MenuLeftViewController * secCtl = [[MenuLeftViewController alloc] init];
    UINavigationController * navCtl = [[UINavigationController alloc] initWithRootViewController:secCtl];
    return navCtl;
}
*/
@end
