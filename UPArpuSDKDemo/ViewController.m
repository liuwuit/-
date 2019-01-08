//
//  ViewController.m
//  UpArpuSDKDemo
//
//  Created by Martin Lau on 09/04/2018.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#import "ViewController.h"
#import "UPADShowViewController.h"
#import "UPArpuRewardedVideoVideoViewController.h"
#import "UPADShowViewController.h"
#import "UPArpuRewardedVideoVideoViewController.h"
#import "UPArpuBannerViewController.h"
#import "UPArpuInterstitialViewController.h"

@import UpArpuSDK;
@import UpArpuRewardedVideo;
@import UpArpuSplash;
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, UPArpuSplashDelegate>
    @property(nonatomic, readonly) UITableView *tableView;
    @property(nonatomic, readonly) NSArray<NSArray<NSString*>*>* placementNames;
    @end

static NSString *const kCellIdentifier = @"cell";
@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    _placementNames = @[@[kGDTPlacement, kBaiduPlacement, kTTPlacementName, kAllPlacementName],
                        @[kUnityAdsPlacementName, kFacebookPlacement, kAdMobPlacement, kInmobiPlacement, kFlurryPlacement, kApplovinPlacement, kMintegralPlacement, kMintegralVideoPlacement, kMopubPlacementName, kGDTPlacement, kChartboostPlacementName, kTapjoyPlacementName, kIronsourcePlacementName, kVunglePlacementName, kAdcolonyPlacementName, kTTPlacementName, kTTVideoPlacement, kOnewayPlacementName, kYeahmobiPlacement, kAppnextPlacement, kBaiduPlacement],
                        @[kFacebookPlacement, kAdMobPlacement, kInmobiPlacement, kFlurryPlacement, kApplovinPlacement, kGDTPlacement, kMopubPlacementName, kTTPlacementName, kYeahmobiPlacement, kAppnextPlacement, kBaiduPlacement],
                        @[kFacebookPlacement, kAdMobPlacement, kInmobiPlacement, kFlurryPlacement, kApplovinPlacement, kMintegralPlacement, kMopubPlacementName, kGDTPlacement, kChartboostPlacementName, kTapjoyPlacementName, kIronsourcePlacementName, kVunglePlacementName, kAdcolonyPlacementName, kUnityAdsPlacementName, kTTPlacementName, kOnewayPlacementName, kYeahmobiPlacement, kAppnextPlacement, kBaiduPlacement, kAllPlacementName],
                        @[kTTFeedPlacementName, kTTDrawPlacementName, kMPPlacement, kFacebookPlacement, kAdMobPlacement, kInmobiPlacement, kFlurryPlacement, kApplovinPlacement, kMintegralPlacement, kMopubPlacementName, kGDTPlacement, kGDTTemplatePlacement, kYeahmobiPlacement, kAppnextPlacement, kAllPlacementName]];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"GDPR" style:UIBarButtonItemStylePlain target:self action:@selector(policyButtonTapped)];
    self.navigationItem.rightBarButtonItem = item;
}

-(void)policyButtonTapped {
    [[UPArpuAPI sharedInstance] presentDataConsentDialogInViewController:self];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return [_placementNames count];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_placementNames[section] count];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0f;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25.0f;
}

-(NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @[@"Splash", @"Interstitial", @"Banner", @"RV", @"Native"][section];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    cell.textLabel.text = _placementNames[[indexPath section]][[indexPath row]];
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if ([indexPath section] == 3) {
        UPArpuRewardedVideoVideoViewController *tVC = [[UPArpuRewardedVideoVideoViewController alloc] initWithPlacementName:_placementNames[[indexPath section]][[indexPath row]]];
        [self.navigationController pushViewController:tVC animated:YES];
    } else if ([indexPath section] == 4) {        UPADShowViewController *tVC = [[UPADShowViewController alloc] initWithPlacementName: _placementNames[[indexPath section]][[indexPath row]]];
        [self.navigationController pushViewController:tVC animated:YES];
    } else if ([indexPath section] == 2) {
        UPArpuBannerViewController *tVC = [[UPArpuBannerViewController alloc] initWithPlacementName:_placementNames[[indexPath section]][[indexPath row]]];
        [self.navigationController pushViewController:tVC animated:YES];
    } else if ([indexPath section] == 1) {
        UPArpuInterstitialViewController *tVC = [[UPArpuInterstitialViewController alloc] initWithPlacementName:_placementNames[[indexPath section]][[indexPath row]]];
        [self.navigationController pushViewController:tVC animated:YES];
    } else if ([indexPath section] == 0) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(.0f, .0f, CGRectGetWidth([UIScreen mainScreen].bounds), 100.0f)];
        label.text = @"Splash Container View";
        label.backgroundColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        
        [[UPArpuAdManager sharedManager] loadADWithPlacementID:@[@"b5c1b0470c7e4a", @"b5c1b047a970fe", @"b5c1b048c498b9", @"b5c22f0e5cc7a0"][[indexPath row]] extra:nil customData:nil delegate:self window:[UIApplication sharedApplication].keyWindow containerView:label];
    }
}

#pragma mark - UPArpu Splash Delegate method(s)
-(void) didFinishLoadingADWithPlacementID:(NSString *)placementID {
    NSLog(@"AppDelegate::didFinishLoadingADWithPlacementID:%@", placementID);
}

-(void) didFailToLoadADWithPlacementID:(NSString*)placementID error:(NSError*)error {
    NSLog(@"AppDelegate::didFailToLoadADWithPlacementID:%@ error:%@", placementID, error);
}

-(void)splashDidShowForPlacementID:(NSString*)placementID {
    NSLog(@"AppDelegate::splashDidShowForPlacementID:%@", placementID);
}

-(void)splashDidClickForPlacementID:(NSString*)placementID {
    NSLog(@"AppDelegate::splashDidClickForPlacementID:%@", placementID);
}

-(void)splashDidCloseForPlacementID:(NSString*)placementID {
    NSLog(@"AppDelegate::splashDidCloseForPlacementID:%@", placementID);
}
    @end
