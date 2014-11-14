//
//  MWFSecondaryViewController.m
//  MWFSlideNavigationViewControllerDemo
//
//  Created by Meiwin Fu on 26/1/12.
//  Copyright (c) Meiwin Fu (blockthirty). All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "MenuLeftViewController.h"
#import "MWFSlideNavigationViewController.h"

@implementation MenuLeftViewController
@synthesize slideNoneButton = _slideNoneButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
- (void) loadView {
    [super loadView];

    tableData = [NSArray arrayWithObjects:@"Egg Benedict", @"Mushroom Risotto", @"Full Breakfast", @"Hamburger", @"Ham and Egg Sandwich", @"Creme Brelee", @"White Chocolate Donut", @"Starbucks Coffee", @"Vegetable Curry", @"Instant Noodle with Egg", @"Noodle with BBQ Pork", @"Japanese Noodle with Pork", @"Green Tea", @"Thai Shrimp Cake", @"Angry Birds Cake", @"Ham and Cheese Panini", nil];

    
    self.slideNoneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.slideNoneButton.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.slideNoneButton setTitle:@"Close" forState:UIControlStateNormal];
    [self.slideNoneButton addTarget:self action:@selector(slideNone:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.slideNoneButton];

    //

    
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    menuItems = @[@"Center Details", @"Treatment And Prices", @"Qualifications", @"Testimonals",@"Awards and Media",@"Local Attractions"];

    
    self.title = @"Menu";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor clearColor];

    CGSize s = self.view.bounds.size;
    self.slideNoneButton.frame = CGRectMake(20, 10, s.width-40, 50);

    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                          style:UITableViewStyleGrouped];
    self.tableView = tableView;
    //[tableView release];

    //
    self.tableView.dataSource = self;

    
    [self.view addSubview:self.tableView];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    // If You have only one(1) section, return 1, otherwise you must handle sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [menuItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    // Configure the cell...
    cell.textLabel.text = [menuItems objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15.0f];//[UIFont fontWithName:@"System-Plain" size:8.0f];

    return cell;
}
- (void)viewDidUnload
{
    [super viewDidUnload];

    self.slideNoneButton = nil;
}

#pragma mark Actions
- (void) slideNone:(id)sender {

    // if viewController provided is not nil, it will be ignored
    /*
    [self.slideNavigationViewController slideForViewController:self 
                                                     direction:MWFSlideDirectionNone 
                                   portraitOrientationDistance:100 
                                  landscapeOrientationDistance:100];
    */
    [self.slideNavigationViewController slideWithDirection:MWFSlideDirectionNone];
}
@end
