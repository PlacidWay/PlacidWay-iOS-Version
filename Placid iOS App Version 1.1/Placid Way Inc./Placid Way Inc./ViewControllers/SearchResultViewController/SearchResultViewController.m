//
//  SearchResultViewController.m
//  Placid Way Inc.
//
//  Created by Mrs.Erum Abid Awan on 03/09/2014.
//  Copyright (c) 2014 Placid Way Inc. All rights reserved.
//

#import "SearchResultViewController.h"
#import "DetailListViewController.h"
#import "MedicalCenterViewController.h"
#import "MedicalCenterInfo.h"
#import "MainViewController.h"
#import "DDURLParser.h"
#import "UIScrollView+SVInfiniteScrolling.h"
#import "UIScrollView+SVPullToRefresh.h"
#import "RNBlurModalView.h"

@interface SearchResultViewController ()

@end

@implementation SearchResultViewController

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


    // Do any additional setup after loading the view from its nib.
    self.noMoreResultsAvail =NO;
    //1
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin| UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight;
    //
    self.dataArray =[[NSMutableArray alloc] init];

    self.dataArray = [AppInfo sharedInfo].listMedicalCenter;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([ self.dataArray count] == 0)
    {
        return 0;
    }
    else {
        return [self.dataArray count];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize iOSDeviceScreenSize = [[UIScreen mainScreen] bounds].size;

    if (iOSDeviceScreenSize.height >= 768)
    {
        return 252;
    }
    else if (iOSDeviceScreenSize.height >= 568)
    {
        return 110;
    }
    return 110;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    // If You have only one(1) section, return 1, otherwise you must handle sections
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"SimpleTableCell";

    CGSize iOSDeviceScreenSize = [[UIScreen mainScreen] bounds].size;
    int nib_i = 0;
    if (iOSDeviceScreenSize.height >= 768)
    {
        simpleTableIdentifier = @"SimpleTableCelliPad";
        nib_i = 1;
    }
    SimpleTableCell *cell = (SimpleTableCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SimpleTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:nib_i];
    }
    //
    NSLog(@"row %ld",(long)indexPath.row);
    if (self.dataArray.count != 0)
    {
        if(indexPath.row < [self.dataArray count])
        {
            //set bg
            if (indexPath.row % 3 == 2)
            {
                [cell.bgImageView setImage:[UIImage imageNamed:@"list_bg_3.png"]];
                [cell.arrowImageView setImage:[UIImage imageNamed:@"arrow_3.png"]];
                [cell.frameImageView setImage:[UIImage imageNamed:@"thumb_3.png"]];

            }
            else if (indexPath.row % 3 == 1)
            {
                [cell.bgImageView setImage:[UIImage imageNamed:@"list_bg_2.png"]];
                [cell.arrowImageView setImage:[UIImage imageNamed:@"arrow_2.png"]];
                [cell.frameImageView setImage:[UIImage imageNamed:@"thumb_2.png"]];
            }
            else
            {
                [cell.bgImageView setImage:[UIImage imageNamed:@"list_bg_1.png"]];
                [cell.arrowImageView setImage:[UIImage imageNamed:@"arrow_1.png"]];
                [cell.frameImageView setImage:[UIImage imageNamed:@"thumb_1.png"]];
            }
            //
            MedicalCenterInfo *medInfo = [self.dataArray objectAtIndex:indexPath.row];

            cell.nameLabel.text = medInfo.title;
            cell.descriptionLabel.adjustsFontSizeToFitWidth = YES;

            cell.descriptionLabel.text = medInfo.description;
            cell.desPopUp.tag = indexPath.row;

            [cell.desPopUp addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
           
            cell.detailGo.tag = indexPath.row;

            [cell.detailGo addTarget:self action:@selector(goDetail:) forControlEvents:UIControlEventTouchUpInside];

            NSString *url = @"";
            if (![medInfo.imageName isEqualToString:@""])
            {
                url = [medInfo.imageName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                
                [cell.thumbnailImageView sd_setImageWithURL:[NSURL URLWithString:url]
                                           placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
                
            }
            

        }

    }
        return cell;
}
-(void)goDetail:(UIButton*)btn
{
    //go to detail Screen
    DetailListViewController *dvc = [[DetailListViewController alloc]initWithNibName:[AppInfo getNibNameFromName:@"DetailListViewController"] bundle:[NSBundle mainBundle]];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:dvc];
    dvc.med_id = btn.tag;
    [navigationController setNavigationBarHidden:YES animated:NO];


    [self presentViewController:navigationController animated:NO completion:nil];
    


}
- (void)tapAction:(UIButton*)sender {
    int index = sender.tag;
    MedicalCenterInfo *medInfo = [self.dataArray objectAtIndex:index];


    RNBlurModalView *modal = [[RNBlurModalView alloc] initWithViewController:self title:medInfo.title message:medInfo.description];
    modal.dismissButtonRight = YES;

    [modal show];
}
-(void)showDesPopUp:(id)sender{

    NSInteger index = (int)sender;
    MedicalCenterInfo *medInfo = [self.dataArray objectAtIndex:index];

    RNBlurModalView *modal = [[RNBlurModalView alloc] initWithTitle:medInfo.title message:medInfo.description];
    modal.defaultHideBlock = ^{
        NSLog(@"Code called after the modal view is hidden");
    };
}
#pragma UIScroll View Method::
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    PaginationInfo *pinfo = [AppInfo sharedInfo].pageInfo;

    if (!self.loading) {
        float endScrolling = scrollView.contentOffset.y + scrollView.frame.size.height;
        if (endScrolling >= scrollView.contentSize.height)
        {
            if (pinfo &&![pinfo.Next isEqualToString:@""])
            {
                // load more content when scroll to the bottom most
                [self.tableView addInfiniteScrollingWithActionHandler:^{
                    [self performSelector:@selector(loadBottomDataDelayed) withObject:nil afterDelay:0.0];
            }];
            }
            
        }
        else if (scrollView.contentOffset.y<=0)
        {//negative means pull
            if (pinfo && pinfo.start - 1 >= 2)
            {
                // setup pull-to-refresh
                [self.tableView addPullToRefreshWithActionHandler:^{
                    [self performSelector:@selector(loadTopDataDelayed) withObject:nil afterDelay:0.0];
                }];

            }
            
            return;
        }
    }
}
#pragma UserDefined Method for generating data which are show in Table :::
-(void)loadTopDataDelayed{
    PaginationInfo *pinfo = [AppInfo sharedInfo].pageInfo;

    if (pinfo && pinfo.start - 1 >= 2)
    {
        self.tableView.showsPullToRefresh = YES;

        NSString *url = @"http://";
        url = [url stringByAppendingString:pinfo.Next];
        DDURLParser *parse = [[DDURLParser alloc] initWithURLString:url] ;


        NSString *start = [parse valueForVariable:@"start"];
        NSLog(@"start = %@", start); //yes
        pinfo.start = [start integerValue]-1;

        [webService WSGetSearchedMedicalList:[parse valueForVariable:@"countryName"] city:[parse valueForVariable:@"cityName"] treatment:[parse valueForVariable:@"treatmentPackageName"] :^(NSMutableArray *result)
         {
             NSRange r = NSMakeRange([self.dataArray count]-50, 50);
             [self.dataArray removeObjectsInRange:r];

             NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange:
                                    NSMakeRange(0,[result count])];
             [self.dataArray insertObjects:result atIndexes:indexes];
             [self.tableView reloadData];

             [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:100 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];

             [self.tableView.pullToRefreshView stopAnimating];
             self.tableView.showsPullToRefresh = NO;

         }];

    }
    else
    {
        self.noMoreResultsAvail = YES;
        [self.tableView.pullToRefreshView stopAnimating];
        self.tableView.showsPullToRefresh = NO;
    }

}
-(void)loadBottomDataDelayed{
    PaginationInfo *pinfo = [AppInfo sharedInfo].pageInfo;

    if (pinfo &&![pinfo.Next isEqualToString:@""])
    {
        self.tableView.showsInfiniteScrolling = YES;

        NSString *url = @"http://";
        url = [url stringByAppendingString:pinfo.Next];
        DDURLParser *parse = [[DDURLParser alloc] initWithURLString:url] ;


        NSString *start = [parse valueForVariable:@"start"];
        NSLog(@"start = %@", start); //yes
        pinfo.start = [start integerValue];

        [webService WSGetSearchedMedicalList:[parse valueForVariable:@"countryName"] city:[parse valueForVariable:@"cityName"] treatment:[parse valueForVariable:@"treatmentPackageName"] :^(NSMutableArray *result)
         {


             NSRange r = NSMakeRange(0, 50);
             [self.dataArray removeObjectsInRange:r];

             [self.dataArray addObjectsFromArray:result];
             [self.tableView reloadData];


             [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:50 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];


             [self.tableView.infiniteScrollingView stopAnimating];
             self.tableView.showsInfiniteScrolling = NO;


         }];

    }
    else
    {
        self.noMoreResultsAvail = YES;
        self.tableView.showsInfiniteScrolling = NO;

    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectRowAtIndexPath at index : %ld",(long)indexPath.row);
    //go to detail Screen
    DetailListViewController *dvc = [[DetailListViewController alloc]initWithNibName:[AppInfo getNibNameFromName:@"DetailListViewController"] bundle:[NSBundle mainBundle]];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:dvc];
    dvc.med_id = indexPath.row;
    [navigationController setNavigationBarHidden:YES animated:NO];


    [self presentViewController:navigationController animated:NO completion:nil];
    
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"willSelectRowAtIndexPath");

    return indexPath;
}
//
-(void)setBorderLable:(UILabel*)lable
{
    //
    [lable.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
    [lable.layer setBorderWidth:0.5];

    //The rounded corner part, where you specify your view's corner radius:
    lable.layer.cornerRadius = 5;
    lable.clipsToBounds = YES;
    
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
    /*MedicalCenterViewController *vc = [[MedicalCenterViewController alloc] initWithNibName:[AppInfo getNibNameFromName:@"MedicalCenterViewController"] bundle:nil];
    id animation = [[AppInfo sharedInfo] getRightUpAnimationTransition];
    [self.navigationController.view.layer addAnimation:animation forKey:@"BottomUpAnimation"];
    [self.navigationController pushViewController:vc animated:NO];
     */

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
