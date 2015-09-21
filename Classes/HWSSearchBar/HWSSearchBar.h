//
//  Created by Hasan Sa on 9/18/15.
//  Copyright © 2015 HWS. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  The different states for an HWSSearchBarState.
 */

typedef NS_ENUM(NSUInteger, HWSSearchBarState)
{
    /**
     *  The default or normal state. The search field is hidden.
     */
    
    HWSSearchBarStateNormal = 0,
    
    /**
     *  The state where the search field is visible.
     */
    
    HWSSearchBarStateSearchBarVisible,
    
    /**
     *  The state where the search field is visible and there is text entered.
     */
    
    HWSSearchBarStateSearchBarHasContent,
    
    /**
     *  The search bar is transitioning between states.
     */
    
    HWSSearchBarStateTransitioning
};

typedef NS_ENUM(NSUInteger, HWSSearch)
{
    HWSSearchNotFound = 0,
    
    HWSSearchFound
};


@class HWSSearchBar;

/**
 *  The delegate is responsible for providing values to the search bar that it can use to determine its size.
 */

@protocol HWSSearchBarDelegate <NSObject>

/**
 *  The delegate is asked to provide the destination frame for the search bar when the search bar is transitioning to the visible state.
 *
 *  @param searchBar The search bar that will begin transitioning.
 *
 *  @return The frame in the coordinate system of the search bar's superview.
 */

- (CGRect)destinationFrameForSearchBar:(HWSSearchBar *)searchBar;

/**
 *  The delegate is informed about the imminent state transitioning of the status bar.
 *
 *  @param searchBar        The search bar that will begin transitioning.
 *  @param destinationState The state that the bar will be in once transitioning completes. The current state of the search bar can be queried and will return the state before transitioning.
 */

- (void)searchBar:(HWSSearchBar *)searchBar willStartTransitioningToState:(HWSSearchBarState)destinationState;

/**
 *  The delegate is informed about the state transitioning of the status bar that has just occured.
 *
 *  @param searchBar        The search bar that went through state transitioning.
 *  @param destinationState The state that the bar was in before transitioning started. The current state of the search bar can be queried and will return the state after transitioning.
 */

- (void)searchBar:(HWSSearchBar *)searchBar didEndTransitioningFromState:(HWSSearchBarState)previousState;

@optional
- (void)searchBar:(HWSSearchBar *)searchBar willShowkeyboardAddTapGestureRecognizer:(UIGestureRecognizer*)gestureRecognizer;
- (void)searchBar:(HWSSearchBar *)searchBar didShowkeyboardWithFrame:(CGRect)frame;
- (void)searchBar:(HWSSearchBar *)searchBar willHidekeyboardRemoveTapGestureRecognizer:(UIGestureRecognizer*)gestureRecognizer;
- (void)didHidekeyboard;


/**
 *  The delegate is informed that the search bar's return key was pressed. This should be used to start querries.
 *
 *  Important: If the searchField property is explicitly supplied with a delegate property this method will not be called.
 *
 *  @param searchBar        The search bar whose return key was pressed.
 */

- (void)searchBarDidTapReturn:(HWSSearchBar *)searchBar;

/**
 *  The delegate is informed that the search bar's text has changed.
 *
 *  Important: If the searchField property is explicitly supplied with a delegate property this method will not be called.
 *
 *  @param searchBar        The search bar whose text did change.
 */

- (void)searchBarTextDidChange:(HWSSearchBar *)searchBar;


/**
 *  The delegate is informed that the search bar's text did end editing.
 *
 *  Important: If the searchField property is explicitly supplied with a delegate property this method will not be called.
 *
 *  @param searchBar        The search bar whose text did end editing.
 */

- (void)searchBarDidEndEditing:(HWSSearchBar *)searchBar;

@end

/**
 *  An animating search bar.
 */

@interface HWSSearchBar : UIView

/**
 *  The current state of the search bar.
 */

@property (nonatomic, readonly) HWSSearchBarState state;

/**
 *  The text field used for entering search queries. Visible only when search is active.
 */

@property (nonatomic, readonly) UITextField *searchField;

/**
 *  The (optional) delegate is responsible for providing values necessary for state change animations of the search bar. @see HWSSearchBarDelegate.
 */

@property (nonatomic, weak) id<HWSSearchBarDelegate>	delegate;

@property (nonatomic) HWSSearch search;

- (void)showSearchBar;
- (void)hideSearchBar;

@end
