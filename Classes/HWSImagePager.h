//
//  Created by Hasan Sa on 9/18/15.
//  Copyright © 2015 HWS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class HWSImagePager;

@protocol HWSImagePagerDataSource <NSObject>

@required
- (NSArray *) arrayWithImages;
- (UIViewContentMode) contentModeForImage:(NSUInteger)image;

@optional
- (UIImage *) placeHolderImageForImagePager;
- (NSString *) captionForImageAtIndex:(NSUInteger)index;

@end

@protocol HWSImagePagerDelegate <NSObject>

@optional
- (void) imagePager:(HWSImagePager *)imagePager didScrollToIndex:(NSUInteger)index;
- (void) imagePager:(HWSImagePager *)imagePager didSelectImageAtIndex:(NSUInteger)index;

@end

@interface HWSImagePager : UIView

// Delegate and Datasource
@property (weak) IBOutlet id <HWSImagePagerDataSource> dataSource;
@property (weak) IBOutlet id <HWSImagePagerDelegate> delegate;

// General
@property (assign) UIViewContentMode contentMode;
@property (nonatomic, retain) UIPageControl *pageControl;
@property (nonatomic, assign) NSUInteger currentPage;
@property (nonatomic, assign) BOOL indicatorDisabled;
@property (nonatomic, assign) BOOL hidePageControlForSinglePages; // Defaults YES

// Slideshow
@property (assign) NSUInteger slideshowTimeInterval; // Defaults 0.0f (off)
@property (assign) BOOL slideshowShouldCallScrollToDelegate; // Defaults YES

// Caption Label
@property (nonatomic, strong) UIColor *captionTextColor; // Defaults Black
@property (nonatomic, strong) UIColor *captionBackgroundColor; // Defaults White (with an alpha of .7f)
@property (nonatomic, strong) UIFont *captionFont; // Defaults to Helvetica 12.0f points

- (void) reloadData;
- (void) setCurrentPage:(NSUInteger)currentPage animated:(BOOL)animated;
- (void) updateCaptionLabelForImageAtIndex:(NSUInteger)index;

@end

