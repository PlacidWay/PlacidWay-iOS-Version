//
//  SearchResultViewController.m
//  Placid Way Inc.
//
//  Created by Mrs.Erum Abid Awan on 03/09/2014.
//  Copyright (c) 2014 Placid Way Inc. All rights reserved.
//

#import "SearchResultViewController.h"
#import "DetailListViewController.h"
#import "MedicalCenterInfo.h"
#import "MainViewController.h"

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
    // Do any additional setup after loading the view from its nib.
    //1
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];



}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [AppInfo sharedInfo].listMedicalCenter.count;
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
    NSLog(@"row %d",indexPath.row);
    NSLog(@"row = %d",indexPath.row%3);

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
    MedicalCenterInfo *medInfo = [[AppInfo sharedInfo].listMedicalCenter objectAtIndex:indexPath.row];

    cell.nameLabel.text = medInfo.title;
    cell.descriptionLabel.text = medInfo.description;

    NSString *url = @"";
    if (![medInfo.imageName isEqualToString:@""])
    {
        url = [medInfo.imageName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

        [cell.thumbnailImageView sd_setImageWithURL:[NSURL URLWithString:url]
                                   placeholderImage:[UIImage imageNamed:@"placeholder.png"]];

    }

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectRowAtIndexPath at index : %d",indexPath.row);
    //go to detail Screen
    DetailListViewController *dvc = [[DetailListViewController alloc]initWithNibName:[AppInfo getNibNameFromName:@"DetailListViewController"] bundle:[NSBundle mainBundle]];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:dvc];
    dvc.med_id = indexPath.row;
    [navigationController setNavigationBarHidden:YES animated:NO];
    // setup slide navigation view controller instance
    /*MWFSlideNavigationViewController * slideNavCtl = [[MWFSlideNavigationViewController alloc] initWithRootViewController:navigationController];
    slideNavCtl.panEnabled = YES;*/


    [self presentViewController:navigationController animated:NO completion:nil];
    
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"willSelectRowAtIndexPath");
    //if (indexPath.row == 0) {
      //  return nil;
   // }

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
/*- (void)detailButtonTappedOnCell:(id)sender {

    //go to detail Screen
    NSIndexPath *indexpath = [self.tableView indexPathForCell:sender];
    MedicalCenterInfo *medInfo = [[AppInfo sharedInfo].listMedicalCenter objectAtIndex:indexpath.row];


    DetailListViewController *fvc = [[DetailListViewController alloc]initWithNibName:@"DetailListViewController" bundle:[NSBundle mainBundle]];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:fvc];
    fvc.med_id = medInfo._id;
    [navigationController setNavigationBarHidden:YES animated:NO];
    // setup slide navigation view controller instance
    MWFSlideNavigationViewController * slideNavCtl = [[MWFSlideNavigationViewController alloc] initWithRootViewController:navigationController];
    slideNavCtl.panEnabled = YES;

    // self.window.rootViewController = slideNavCtl;

    [self presentViewController:slideNavCtl animated:NO completion:nil];
}
*/
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
