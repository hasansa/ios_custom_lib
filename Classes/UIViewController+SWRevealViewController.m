//
//  Created by Hasan Sa on 9/18/15.
//  Copyright © 2015 HWS. All rights reserved.
//

#import "UIViewController+SWRevealViewController.h"
#import "SWRevealViewController.h"

@interface UIViewController()
@property (nonatomic, strong) PoiSearchViewController* searchViewController;
@end

@implementation UIViewController (SWRevealViewController)

- (SWRevealViewController*)revealViewController
{
    UIViewController *parent = self;
    Class revealClass = [SWRevealViewController class];
    
    while ( nil != (parent = [parent parentViewController]) && ![parent isKindOfClass:revealClass] )
    {   
    }
    
    return (id)parent;
}

- (PoiSearchViewController*)searchViewController
{
    return self.revealViewController.searchViewController;
}

- (id)homeViewController
{
    return self.revealViewController.homeViewController;
}

- (IBAction)revealToggle:(id)sender
{
    [self.revealViewController revealToggle:sender];
}

- (IBAction)rightRevealToggle:(id)sender
{
    [self.revealViewController rightRevealToggle:sender];
}

@end
