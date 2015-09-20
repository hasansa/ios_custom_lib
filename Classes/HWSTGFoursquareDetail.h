//
//  Created by Hasan Sa on 9/18/15.
//  Copyright © 2015 HWS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWSImagePager.h"

@protocol HWSTGFoursquareLocationDetailDelegate;

@interface HWSTGFoursquareDetail : UIView <UIScrollViewDelegate>

@property (nonatomic) CGFloat defaultimagePagerHeight;

/**
 How fast is the table view scrolling with the image picker
*/
@property (nonatomic) CGFloat parallaxScrollFactor;

@property (nonatomic) CGFloat headerFade;

@property (nonatomic, strong) HWSImagePager *imagePager;

@property (nonatomic) int nbImages;

@property (nonatomic) int currentImage;

@property (nonatomic) CGRect defaultimagePagerFrame;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *backgroundView;

@property (nonatomic, strong) UIColor *backgroundViewColor;

@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, weak) id<UITableViewDataSource> tableViewDataSource;

@property (nonatomic, weak) id<UITableViewDelegate> tableViewDelegate;

@property (nonatomic, weak) id<HWSTGFoursquareLocationDetailDelegate> delegate;

@end

@protocol HWSTGFoursquareLocationDetailDelegate <NSObject>

@optional

- (void)locationDetail:(HWSTGFoursquareDetail *)locationDetail
       imagePagerDidLoad:(HWSImagePager *)imagePager;

- (void)locationDetail:(HWSTGFoursquareDetail *)locationDetail
      tableViewDidLoad:(UITableView *)tableView;

- (void)locationDetail:(HWSTGFoursquareDetail *)locationDetail
      headerViewDidLoad:(UIView *)headerView;
@end
