//
//  CardViewController.m
//  SanguoshaData
//
//  Created by Felix Kwan on 15/10/2016.
//  Copyright © 2016年 KwFung. All rights reserved.
//

#import "CardViewController.h"
#import "CardDetailViewController.h"
#import "HeroViewCell.h"
#import "HeroViewHeader.h"
#import "HeroViewFooter.h"

@interface CardViewController ()

@end

@implementation CardViewController

static NSString * const reuseIdentifier = @"CustomCell";
static NSString * const reuseHeaderIdentifier = @"CustomHeader";
static NSString * const reuseFooterIdentifier = @"CustomFooter";

@synthesize cards, collectionView, searchView, searchResults, searchController;

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    self.navigationController.hidesBarsOnSwipe = false;
    [self.navigationController setNavigationBarHidden: false];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.delegate = self;
    
    // Load background
    UIImage *background = [UIImage imageNamed: @"Background"];
    self.collectionView.backgroundColor = [UIColor colorWithPatternImage: background];
    
    // Load hero data from HeroData.plist
    NSString *path = [[NSBundle mainBundle] pathForResource: @"CardData" ofType: @"plist"];
    cards = [[NSArray alloc] initWithContentsOfFile: path];
    
    // Set searchBar
    searchController = [[UISearchController alloc] initWithSearchResultsController: nil];
    [searchController.searchBar sizeToFit];
    searchController.searchResultsUpdater = self;
    searchController.dimsBackgroundDuringPresentation = false;
    self.definesPresentationContext = true;
    [self.searchView addSubview: searchController.searchBar];
    
    /* Initialize Google Mobile Ads with app ID */
    [GADMobileAds configureWithApplicationID: @"ca-app-pub-4561364336152901~4956407679"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    if (searchController.isActive) {
        
        return 1;
    } else {
        
        return cards.count;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (searchController.isActive) {
        
        return searchResults.count;
    } else {
        
        return [[cards objectAtIndex: section] count];
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HeroViewCell *cell = (HeroViewCell *)[self.collectionView dequeueReusableCellWithReuseIdentifier: reuseIdentifier forIndexPath: indexPath];
    
    // Set cell appearance
    NSDictionary *card = (searchController.isActive) ? searchResults[indexPath.row] : [cards[indexPath.section] objectAtIndex: indexPath.row];
    cell.heroName.text = [card objectForKey: @"Name"];
    dispatch_async(dispatch_get_main_queue(), ^{
        
        cell.imageView.image = [UIImage imageNamed: [NSString stringWithFormat: @"%@-%@-icon", cell.heroName.text, [card objectForKey:@"Type"]]];
        cell.imageView.layer.cornerRadius = cell.imageView.frame.size.width/6;
        cell.imageView.clipsToBounds = true;
    });
    return cell;
}

// Set custom header
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (kind == UICollectionElementKindSectionHeader) {
        
        HeroViewHeader *header = [self.collectionView dequeueReusableSupplementaryViewOfKind: UICollectionElementKindSectionHeader withReuseIdentifier: reuseHeaderIdentifier forIndexPath: indexPath];
        
        NSString *type = (searchController.isActive) ? @"搜尋結果" : [[cards[indexPath.section] objectAtIndex: 0] objectForKey: @"Type"];
        header.title.text = type;
        return header;
    }
    
    if (kind == UICollectionElementKindSectionFooter) {
        
        HeroViewFooter *footer = [self.collectionView dequeueReusableSupplementaryViewOfKind: UICollectionElementKindSectionFooter withReuseIdentifier: reuseFooterIdentifier forIndexPath: indexPath];
        
        /* Goodgle mobile ads banner setting */
        footer.bannerView.adSize = kGADAdSizeSmartBannerPortrait;
        /* Testing footer.bannerView.adUnitID = @"ca-app-pub-3940256099942544/2934735716"; */
        footer.bannerView.adUnitID = @"ca-app-pub-4561364336152901/6433140870";
        footer.bannerView.rootViewController = self;
        [footer.bannerView loadRequest: [GADRequest request]];
        return footer;
    }
    return nil;
}


// FilterContent
- (void)filterContentForSearchText: (NSString *) searchText {
    
    searchResults = [NSMutableArray new];
    
    // Find each hero data
    for (int i = 0; i < cards.count; i++) {
        
        for (int j = 0; j < [cards[i] count]; j++) {
            
            NSDictionary *card = [cards[i] objectAtIndex: j];
            BOOL isTarget = [[card objectForKey: @"Name"] containsString: searchText];
            if (isTarget) {
                
                [searchResults addObject: card];
            }
        }
    }
}

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    NSString *searchText = self.searchController.searchBar.text;
    [self filterContentForSearchText: searchText];
    [collectionView reloadData];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier: @"showCardDetail" sender: indexPath];
}

// Transfer hero to DetailViewController
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString: @"showCardDetail"]) {
        
        NSIndexPath *indexPath = (NSIndexPath *)sender;
        CardDetailViewController *destination = [segue destinationViewController];
        destination.card = (searchController.isActive) ? searchResults[indexPath.row] : [cards[indexPath.section] objectAtIndex: indexPath.row];
        
    }
}

@end
