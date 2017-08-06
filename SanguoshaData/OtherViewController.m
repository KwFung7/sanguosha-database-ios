//
//  OtherViewController.m
//  SanguoshaData
//
//  Created by Felix Kwan on 17/10/2016.
//  Copyright © 2016年 KwFung. All rights reserved.
//

#import "OtherViewController.h"

@interface OtherViewController ()

@end

@implementation OtherViewController

@synthesize otherButton, emailButton, blogButton, aboutImage;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set image
    self.aboutImage.image = [UIImage imageNamed: @"About"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction) showSource:(id)sender {
    
    UIAlertController *alertcontroller = [UIAlertController alertControllerWithTitle: @"資料來源" message: @"\nApp版本: v1.0 \n☆ 資料/圖片來源自 三國殺官方網站 \n☆ Icon圖片來源自 Icons8.com" preferredStyle: UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle: @"OK" style: UIAlertActionStyleDefault handler: nil];
    [alertcontroller addAction: ok];
    [self presentViewController: alertcontroller animated: true completion: nil];
}

- (IBAction) showEmail:(id)sender {
    
    if ([MFMailComposeViewController canSendMail]) {
        
        MFMailComposeViewController *compose = [[MFMailComposeViewController alloc] init];
        compose.mailComposeDelegate = self;
        compose.navigationBar.tintColor = [UIColor whiteColor];
        [compose setToRecipients: [NSArray arrayWithObjects: @"lingfung09@hotmail.com", nil]];
        [self presentViewController: compose animated: true completion: nil];
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    
    [self dismissViewControllerAnimated: true completion: nil];
}

@end
