//
//  OtherViewController.h
//  SanguoshaData
//
//  Created by Felix Kwan on 17/10/2016.
//  Copyright © 2016年 KwFung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface OtherViewController : UIViewController <MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *otherButton;
@property (weak, nonatomic) IBOutlet UIButton *emailButton;
@property (weak, nonatomic) IBOutlet UIButton *blogButton;
@property (weak, nonatomic) IBOutlet UIImageView *aboutImage;

@end
