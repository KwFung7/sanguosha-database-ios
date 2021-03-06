//
//  HeroViewController.h
//  SanguoshaData
//
//  Created by Felix Kwan on 14/10/2016.
//  Copyright © 2016年 KwFung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeroViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UISearchResultsUpdating>
@property (strong, nonatomic) NSArray *heros;
@property (strong, nonatomic) NSMutableArray<NSDictionary *> *searchResults;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (strong, nonatomic) UISearchController *searchController;


@end
