//
//  AboutUsViewController.h
//  Placid Way Inc.
//
//  Created by Mrs.Erum Abid Awan on 08/09/2014.
//  Copyright (c) 2014 Placid Way Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutUsViewController : UIViewController
{
    IBOutlet UITextView *tv_about_us;
    UIPinchGestureRecognizer *pinchGestureRecognizer;

    float fontSize;

}
- (IBAction)back;

@end
