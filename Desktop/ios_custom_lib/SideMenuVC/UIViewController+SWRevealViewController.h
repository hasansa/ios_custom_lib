//
//  Created by Hasan Sa on 9/18/15.
//  Copyright © 2015 HWS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SWRevealViewController;
@class PoiSearchViewController;

@interface UIViewController (SWRevealViewController)

- (SWRevealViewController*)revealViewController;
- (PoiSearchViewController*)searchViewController;

- (IBAction)revealToggle:(id)sender;
- (IBAction)rightRevealToggle:(id)sender;

@end
