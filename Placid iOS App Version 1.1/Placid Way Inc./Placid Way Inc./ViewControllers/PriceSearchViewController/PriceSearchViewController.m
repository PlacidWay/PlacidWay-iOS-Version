//
//  PriceSearchViewController.m
//  Placid Way Inc.
//
//  Created by Mrs.Erum Abid Awan on 10/12/2014.
//  Copyright (c) 2014 Placid Way Inc. All rights reserved.
//

#import "PriceSearchViewController.h"
#import "DetailListViewController.h"
#import "SearchResultViewController.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "DDURLParser.h"
#import "UIScrollView+SVInfiniteScrolling.h"
#import "UIScrollView+SVPullToRefresh.h"
#import "RNBlurModalView.h"

@interface PriceSearchViewController ()

@end

@implementation PriceSearchViewController
@synthesize segmentedControl;
@synthesize tableList;
@synthesize tableView;


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
    webService=[[WebServices alloc]init];
    // Do any additional setup after loading the view from its nib.
    self.noMoreResultsAvail =NO;
    //1
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin| UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight;
    tableList = [[NSMutableArray alloc] init];


    isFeature = true;

    tableList = [AppInfo sharedInfo].listFeaturePriceMedicalCenter;

    [segmentedControl addTarget:self
                         action:@selector(segmentAction:)
               forControlEvents:UIControlEventValueChanged];


}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    rowA = 0;
    rowF = 0;
    if ([[AppInfo sharedInfo].listFeaturePriceMedicalCenter count] > 0) {
        [segmentedControl setSelectedSegmentIndex:0];
        isFeature = true;
    }
    else
    {
        isFeature = false;
        [segmentedControl setSelectedSegmentIndex:1];
    }
    [self performSelector:@selector(segmentAction:) withObject:nil afterDelay:0.0];


}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableList.count;
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
    static NSString *simpleTableIdentifier = @"SimpleTableCellPrice";

    CGSize iOSDeviceScreenSize = [[UIScreen mainScreen] bounds].size;
    int nib_i = 2;
    if (iOSDeviceScreenSize.height >= 768)
    {
        simpleTableIdentifier = @"SimpleTableCelliPad";
        nib_i = 1;
    }
    SimpleTableCell *cell = (SimpleTableCell *)[self.tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SimpleTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:nib_i];
    }
    //
    NSLog(@"row %d",indexPath.row);

    if (indexPath.row > 3 ) {
        if (isFeature) {
            rowF = indexPath.row;
        }
        else
            rowA = indexPath.row;
    }

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
    cell.desPopUp.tag = indexPath.row;

    [cell.desPopUp addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];

    cell.detailGo.tag = indexPath.row;

    [cell.detailGo addTarget:self action:@selector(goDetail:) forControlEvents:UIControlEventTouchUpInside];

    NSString *url = @"";

    if ([[tableList objectAtIndex:indexPath.row] isKindOfClass:[FeaturedCenterInfo class]])
    {
        FeaturedCenterInfo *medInfo = [tableList objectAtIndex:indexPath.row];

        cell.nameLabel.text = medInfo.center_name;
        cell.descriptionLabel.text = medInfo.details;
        cell.priceLabel.text = @"$";
        cell.priceLabel.text = [cell.priceLabel.text stringByAppendingString:medInfo.price];
        
        url = [url stringByAppendingString:medInfo.img_url];


    }
    else if ([[tableList objectAtIndex:indexPath.row] isKindOfClass:[AverageCenterInfo class]])
    {
        AverageCenterInfo *medInfo = [tableList objectAtIndex:indexPath.row];

        cell.nameLabel.text = medInfo.center_name;
        cell.descriptionLabel.text = medInfo.details;
        cell.priceLabel.text = @"$";
        cell.priceLabel.text = [cell.priceLabel.text stringByAppendingString:medInfo.price];
        url = [url stringByAppendingString:medInfo.img_url];
        
    }

    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    [cell.thumbnailImageView setImageWithURL:[NSURL URLWithString:url] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    


    return cell;
}

-(void)goDetail:(UIButton*)btn
{

    if (!isFeature)
    {
        AverageCenterInfo *avg = [[AppInfo sharedInfo].listAveragePriceMedicalCenter objectAtIndex:btn.tag];
        DDURLParser *parse = [[DDURLParser alloc] initWithURLString:avg.search_link] ;


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

         }];


    }
    else
    {
        //go to detail Screen
        [AppInfo sharedInfo].listMedicalCenter = [AppInfo sharedInfo].listFeaturePriceMedicalCenter;

        DetailListViewController *dvc = [[DetailListViewController alloc]initWithNibName:[AppInfo getNibNameFromName:@"DetailListViewController"] bundle:[NSBundle mainBundle]];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:dvc];
        dvc.med_id = btn.tag;
        [navigationController setNavigationBarHidden:YES animated:NO];


        [self presentViewController:navigationController animated:NO completion:nil];
    }
    
}
- (void)tapAction:(UIButton*)btn {
    RNBlurModalView *modal;

    if ([[tableList objectAtIndex:btn.tag] isKindOfClass:[FeaturedCenterInfo class]])
    {
        FeaturedCenterInfo *medInfo = [tableList objectAtIndex:btn.tag];

        NSString *detailInfo = @"Price : $";
        detailInfo = [detailInfo stringByAppendingString:medInfo.price];
        detailInfo = [detailInfo stringByAppendingString:@"\n"];
        detailInfo = [detailInfo stringByAppendingString:medInfo.details];

        modal = [[RNBlurModalView alloc] initWithViewController:self title:medInfo.center_name message:detailInfo];
    }
    else if ([[tableList objectAtIndex:btn.tag] isKindOfClass:[AverageCenterInfo class]])
    {
        AverageCenterInfo *medInfo = [tableList objectAtIndex:btn.tag];
        NSString *detailInfo = @"Price : $";
        detailInfo = [detailInfo stringByAppendingString:medInfo.price];
        detailInfo = [detailInfo stringByAppendingString:@"\n"];
        detailInfo = [detailInfo stringByAppendingString:medInfo.details];

        modal = [[RNBlurModalView alloc] initWithViewController:self title:medInfo.center_name message:detailInfo];
    }
    modal.dismissButtonRight = YES;
    
    [modal show];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectRowAtIndexPath at index : %d",indexPath.row);

    if (!isFeature)
    {
        AverageCenterInfo *avg = [[AppInfo sharedInfo].listAveragePriceMedicalCenter objectAtIndex:indexPath.row];

        NSString *url = @"http://";
        url = [url stringByAppendingString:avg.search_link];

        DDURLParser *parse = [[DDURLParser alloc] initWithURLString:url] ;

        [webService WSGetSearchedMedicalList:[parse valueForVariable:@"countryName"] city:
         [parse valueForVariable:@"cityName"] treatment:
         [parse valueForVariable:@"treatmentPackageName"]:^(NSMutableArray *result)
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

         }];

    }
    else
    {
        //go to detail Screen
        [AppInfo sharedInfo].listMedicalCenter = [AppInfo sharedInfo].listFeaturePriceMedicalCenter;

        DetailListViewController *dvc = [[DetailListViewController alloc]initWithNibName:[AppInfo getNibNameFromName:@"DetailListViewController"] bundle:[NSBundle mainBundle]];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:dvc];
        dvc.med_id = indexPath.row;
        [navigationController setNavigationBarHidden:YES animated:NO];

        [self presentViewController:navigationController animated:NO completion:nil];
    }


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
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)segmentAction:(id)sender
{

    if(segmentedControl.selectedSegmentIndex == 0)
    {
        isFeature = true;
        tableList = [AppInfo sharedInfo].listFeaturePriceMedicalCenter;
        [tableView reloadData];

        if ([AppInfo sharedInfo].listFeaturePriceMedicalCenter.count > 0)
        {
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:rowF inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        }
    }
    else if(segmentedControl.selectedSegmentIndex == 1 )
    {
        isFeature = false;
        tableList = [AppInfo sharedInfo].listAveragePriceMedicalCenter;
        [tableView reloadData];

        if ([AppInfo sharedInfo].listAveragePriceMedicalCenter.count > 0)
        {
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:rowA inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        }

    }
}
#pragma UIScroll View Method::
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{

    if (!self.loading) {
        float endScrolling = scrollView.contentOffset.y + scrollView.frame.size.height;
        if (endScrolling >= scrollView.contentSize.height)
        {
            if (isFeature)
            {
                PaginationInfo *pinfo = [AppInfo sharedInfo].pageFInfo;
                if (pinfo &&![pinfo.Next isEqualToString:@""])
                {
                    // load more content when scroll to the bottom most
                    [self.tableView addInfiniteScrollingWithActionHandler:^{
                        [self performSelector:@selector(loadPriceBottomDataDelayed) withObject:nil afterDelay:0.0];
                    }];
                }

            }
            else if (!isFeature)
            {
                PaginationInfo *pinfo = [AppInfo sharedInfo].pageAInfo;
                if (pinfo &&![pinfo.Next isEqualToString:@""])
                {
                    // load more content when scroll to the bottom most
                    [self.tableView addInfiniteScrollingWithActionHandler:^{
                        [self performSelector:@selector(loadPriceBottomDataDelayed) withObject:nil afterDelay:0.0];
                    }];
                }

            }


        }
        else if (scrollView.contentOffset.y<=0)
        {//negative means pull
            if (isFeature)
            {
                PaginationInfo *pinfo = [AppInfo sharedInfo].pageFInfo;
                if (pinfo && pinfo.start - 1 >= 2)
                {
                    // setup pull-to-refresh
                    [self.tableView addPullToRefreshWithActionHandler:^{
                        [self performSelector:@selector(loadPriceTopDataDelayed) withObject:nil afterDelay:0.0];
                    }];
                    
                }


            }
            else if (!isFeature)
            {
                PaginationInfo *pinfo = [AppInfo sharedInfo].pageAInfo;
                if (pinfo && pinfo.start - 1 >= 2)
                {
                    // setup pull-to-refresh
                    [self.tableView addPullToRefreshWithActionHandler:^{
                        [self performSelector:@selector(loadPriceTopDataDelayed) withObject:nil afterDelay:0.0];
                    }];
                    
                }

            }

            return;
        }
    }
}
#pragma UserDefined Method for generating data which are show in Table :::
-(void)loadPriceTopDataDelayed{
    if (isFeature)
    {
        PaginationInfo *pinfo = [AppInfo sharedInfo].pageFInfo;

        if (pinfo && pinfo.start - 1 >= 2)
        {
            self.tableView.showsPullToRefresh = YES;

            [webService WSGetPricingpaginationList:pinfo.Next isFeature:isFeature  :^(NSMutableArray *result)
             {
                 NSRange r = NSMakeRange([self.tableList count]-50, 50);
                 [self.tableList removeObjectsInRange:r];

                 NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange:
                                        NSMakeRange(0,[result count])];
                 [self.tableList insertObjects:result atIndexes:indexes];
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
    else if (!isFeature)
    {
        PaginationInfo *pinfo = [AppInfo sharedInfo].pageAInfo;

        if (pinfo && pinfo.start - 1 >= 2)
        {
            self.tableView.showsPullToRefresh = YES;

            [webService WSGetPricingpaginationList:pinfo.Next isFeature:isFeature  :^(NSMutableArray *result)
             {
                 NSRange r = NSMakeRange([self.tableList count]-50, 50);
                 [self.tableList removeObjectsInRange:r];

                 NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange:
                                        NSMakeRange(0,[result count])];
                 [self.tableList insertObjects:result atIndexes:indexes];
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


}
-(void)loadPriceBottomDataDelayed{
    if (isFeature)
    {
        PaginationInfo *pinfo = [AppInfo sharedInfo].pageFInfo;

        if (pinfo &&![pinfo.Next isEqualToString:@""])
        {
            self.tableView.showsInfiniteScrolling = YES;

            [webService WSGetPricingpaginationList:pinfo.Next isFeature:isFeature  :^(NSMutableArray *result)
             {


                 NSRange r = NSMakeRange(0, 50);
                 [self.tableList removeObjectsInRange:r];

                 [self.tableList addObjectsFromArray:result];
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
    else if (!isFeature)
    {
        PaginationInfo *pinfo = [AppInfo sharedInfo].pageAInfo;

        if (pinfo &&![pinfo.Next isEqualToString:@""])
        {
            self.tableView.showsInfiniteScrolling = YES;

            [webService WSGetPricingpaginationList:pinfo.Next isFeature:isFeature  :^(NSMutableArray *result)
             {


                 NSRange r = NSMakeRange(0, 50);
                 [self.tableList removeObjectsInRange:r];

                 [self.tableList addObjectsFromArray:result];
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
