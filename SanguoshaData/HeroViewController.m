//
//  HeroViewController.m
//  SanguoshaData
//
//  Created by Felix Kwan on 14/10/2016.
//  Copyright © 2016年 KwFung. All rights reserved.
//

#import "HeroViewController.h"
#import "DetailViewController.h"
#import "HeroViewCell.h"
#import "HeroViewHeader.h"
#import "HeroViewFooter.h"

@interface HeroViewController ()

@end

@implementation HeroViewController

static NSString * const reuseIdentifier = @"CustomCell";
static NSString * const reuseHeaderIdentifier = @"CustomHeader";
static NSString * const reuseFooterIdentifier = @"CustomFooter";

@synthesize heros, collectionView, searchView, searchResults, searchController;

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
    NSString *path = [[NSBundle mainBundle] pathForResource: @"HeroData" ofType: @"plist"];
    heros = [[NSArray alloc] initWithContentsOfFile: path];
    
    // Set searchBar
    searchController = [[UISearchController alloc] initWithSearchResultsController: nil];
    [searchController.searchBar sizeToFit];
    searchController.searchResultsUpdater = self;
    searchController.obscuresBackgroundDuringPresentation = false;
    self.definesPresentationContext = true;
    [self.searchView addSubview: searchController.searchBar];
    
    /* Initialize Google Mobile Ads with app ID */
    [GADMobileAds configureWithApplicationID: @"ca-app-pub-6784152634624245~8374580706"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    if (searchController.isActive) {
        
        return 1;
    } else {
        
        return heros.count;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (searchController.isActive) {
    
        return searchResults.count;
    } else {
        
        return [[heros objectAtIndex: section] count];
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HeroViewCell *cell = (HeroViewCell *)[self.collectionView dequeueReusableCellWithReuseIdentifier: reuseIdentifier forIndexPath: indexPath];
    
    // Set cell appearance
    NSDictionary *hero = (searchController.isActive) ? searchResults[indexPath.row] : [heros[indexPath.section] objectAtIndex: indexPath.row];
    cell.heroName.text = [hero objectForKey: @"Name"];
    dispatch_async(dispatch_get_main_queue(), ^{
        
        cell.imageView.image = [UIImage imageNamed: [NSString stringWithFormat: @"%@-%@-icon", cell.heroName.text, [hero objectForKey:@"Type"]]];
        cell.imageView.layer.cornerRadius = cell.imageView.frame.size.width/8;
        cell.imageView.clipsToBounds = true;
    });
    return cell;
}

// Set custom header and footer
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (kind == UICollectionElementKindSectionHeader) {
        
        HeroViewHeader *header = [self.collectionView dequeueReusableSupplementaryViewOfKind: UICollectionElementKindSectionHeader withReuseIdentifier: reuseHeaderIdentifier forIndexPath: indexPath];
        
        NSString *type = (searchController.isActive) ? @"搜尋結果" : [[heros[indexPath.section] objectAtIndex: 0] objectForKey: @"Type"];
        header.title.text = type;
        return header;
    }
    if (kind == UICollectionElementKindSectionFooter) {
        
        HeroViewFooter *footer = [self.collectionView dequeueReusableSupplementaryViewOfKind: UICollectionElementKindSectionFooter withReuseIdentifier: reuseFooterIdentifier forIndexPath: indexPath];
        
        /* Goodgle mobile ads banner setting */
        footer.bannerView.adSize = kGADAdSizeSmartBannerPortrait;
        // footer.bannerView.adUnitID = @"ca-app-pub-3940256099942544/9214589741"; // Test Ads
        footer.bannerView.adUnitID = @"ca-app-pub-6784152634624245/5086072383";
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
    for (int i = 0; i < heros.count; i++) {
        
        for (int j = 0; j < [heros[i] count]; j++) {
        
            NSDictionary *hero = [heros[i] objectAtIndex: j];
            BOOL isTarget = [[hero objectForKey: @"Name"] containsString: searchText];
            if (isTarget) {
                
                [searchResults addObject: hero];
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
    
    [self performSegueWithIdentifier: @"showDetail" sender: indexPath];
}

// Transfer hero to DetailViewController
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString: @"showDetail"]) {
        
        NSIndexPath *indexPath = (NSIndexPath *)sender;
        DetailViewController *destination = [segue destinationViewController];
        destination.hero = (searchController.isActive) ? searchResults[indexPath.row] : [heros[indexPath.section] objectAtIndex: indexPath.row];
        
    }
}

#pragma mark <UICollectionViewDelegate>

/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
 }
 */

/*
 // Uncomment this method to specify if the specified item should be selected
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
 }
 
 - (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
 }
 
 - (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
 }
 */

@end
