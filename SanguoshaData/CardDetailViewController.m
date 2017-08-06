//
//  CardDetailViewController.m
//  SanguoshaData
//
//  Created by Felix Kwan on 16/10/2016.
//  Copyright © 2016年 KwFung. All rights reserved.
//

#import "CardDetailViewController.h"
#import "DetailViewCell.h"

@interface CardDetailViewController ()

@end

@implementation CardDetailViewController

static NSString * const reuseDetailIdentifier = @"CustomDetailCell";
@synthesize imageView, tableView, card;

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    self.navigationController.hidesBarsOnSwipe = true;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Set navigation title
    self.navigationItem.title = [card objectForKey: @"Name"];
    
    //Set image
    imageView.image = [UIImage imageNamed: [NSString stringWithFormat: @"%@-%@-detail", [card objectForKey: @"Name"], [card objectForKey:@"Type"]]];
    
    //Set automatic dimension table cell
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    // Load background
    UIImage *background = [UIImage imageNamed: @"Background"];
    self.tableView.backgroundColor = [UIColor colorWithPatternImage: background];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DetailViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier: reuseDetailIdentifier forIndexPath: indexPath];
    //Hide titleLabel at first cell
    [cell.titleButton setHidden: true];
    cell.backgroundColor = [UIColor clearColor];
    
    //Set details in table cell
    switch (indexPath.row) {
        case 0:
            cell.detailLabel.text = [NSString stringWithFormat: @"\n%@\n", [card objectForKey: @"Info"]];
            break;
        case 1:
            cell.detailLabel.text = [NSString stringWithFormat: @"\n\n%@\n", [card objectForKey: @"Detail"]];
            [cell.titleButton setHidden: false];
            [cell.titleButton setTitle: @"玩法" forState: UIControlStateNormal];
            break;
        case 2:
            cell.detailLabel.text = [NSString stringWithFormat: @"\n\n%@", [card objectForKey: @"Qa"]];
            [cell.titleButton setHidden: false];
            [cell.titleButton setTitle: @"Q&A" forState: UIControlStateNormal];
            break;
        default:
            cell.detailLabel.text = @"";
    }
    return cell;
}

- (BOOL)prefersStatusBarHidden {
    
    return true;
}

@end
