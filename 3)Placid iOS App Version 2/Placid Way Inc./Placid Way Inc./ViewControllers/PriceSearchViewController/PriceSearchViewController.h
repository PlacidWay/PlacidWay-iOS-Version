//
//  PriceSearchViewController.h
//  Placid Way Inc.
//
//  Created by Mrs.Erum Abid Awan on 10/12/2014.
//  Copyright (c) 2014 Placid Way Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PriceSearchViewController :UIViewController <UITableViewDataSource, UITableViewDelegate,MFMailComposeViewControllerDelegate>
{
    BOOL isFeature;
    NSString *html;
    WebServices *webService;
    int rowF;
    int rowA;

}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (nonatomic, strong) NSMutableArray *tableList;

- (IBAction)back;
//-(void)showDesPopUp:(id)sender;
- (void)tapAction:(UIButton*)sender;
@property (nonatomic) BOOL noMoreResultsAvail;
@property (nonatomic) BOOL loading;

-(IBAction)makeCall;
-(IBAction)openMail:(id)sender;

@end
