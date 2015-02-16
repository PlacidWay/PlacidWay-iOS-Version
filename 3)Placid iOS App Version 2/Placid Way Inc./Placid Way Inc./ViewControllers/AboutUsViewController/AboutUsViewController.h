//
//  AboutUsViewController.h
//  Placid Way Inc.
//
//  Created by Mrs.Erum Abid Awan on 08/09/2014.
//  Copyright (c) 2014 Placid Way Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutUsViewController : UIViewController<MFMailComposeViewControllerDelegate>
{
    IBOutlet UITextView *tv_about_us,*tv_about_us2;
    UIPinchGestureRecognizer *pinchGestureRecognizer;

    float fontSize;

}
@property(nonatomic,strong) NSArray *nibViews;
@property (nonatomic, strong) UIView *myViewFromNib;

- (IBAction)back;

-(IBAction)makeCall;
-(IBAction)openMail:(id)sender;

@end
