//
//  DetailViewController.h
//  SanguoshaData
//
//  Created by Felix Kwan on 12/10/2016.
//  Copyright © 2016年 KwFung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSDictionary *hero;

@end
