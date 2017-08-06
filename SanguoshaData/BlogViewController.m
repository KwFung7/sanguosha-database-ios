//
//  BlogViewController.m
//  SanguoshaData
//
//  Created by Felix Kwan on 17/10/2016.
//  Copyright © 2016年 KwFung. All rights reserved.
//

#import "BlogViewController.h"

@interface BlogViewController ()

@end

@implementation BlogViewController

@synthesize webView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString: @"http://kwfelix.blogspot.hk"];
    NSURLRequest *request = [NSURLRequest requestWithURL: url];
    [webView loadRequest: request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)prefersStatusBarHidden {
    
    return true;
}

@end
