//
//  SearchResultViewController.h
//  Placid Way Inc.
//
//  Created by Mrs.Erum Abid Awan on 03/09/2014.
//  Copyright (c) 2014 Placid Way Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchResultViewController : UIViewController <UITableViewDataSource, UITableViewDelegate,MFMailComposeViewControllerDelegate>
{
    WebServices *webService;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataArray;

- (IBAction)back;
-(void)showDesPopUp:(id)sender;
- (void)tapAction:(UIButton*)sender;
@property (nonatomic) BOOL noMoreResultsAvail;
@property (nonatomic) BOOL loading;

-(IBAction)makeCall;
-(IBAction)openMail:(id)sender;

@end
