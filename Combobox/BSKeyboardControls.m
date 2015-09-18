//
//  Created by Hasan Sa on 9/18/15.
//  Copyright © 2015 HWS. All rights reserved.
//

#import "BSKeyboardControls.h"
#import "iOSCombobox.h"

@interface BSKeyboardControls ()
@property (nonatomic, strong) UIToolbar *toolbar;

@property (nonatomic, strong) UIBarButtonItem *doneButton;
@property (nonatomic, strong) UIBarButtonItem *segmentedControlItem;
#ifdef USE_SEGMENT
    @property (nonatomic, strong) UISegmentedControl *segmentedControl;
#endif // USE_SEGMENT
@end

@implementation BSKeyboardControls

#pragma mark -
#pragma mark Lifecycle

- (id)init
{
    return [self initWithFields:nil];
}

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFields:nil];
}

- (id)initWithFields:(NSArray *)fields
{
    if (self = [super initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 44.0f)])
    {
        [self setToolbar:[[UIToolbar alloc] initWithFrame:self.frame]];
        [self.toolbar setBarStyle:UIBarStyleDefault];
        [self.toolbar setAutoresizingMask:(UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth)];
        [self addSubview:self.toolbar];
#ifdef USE_SEGMENT
        [self setSegmentedControl:[[UISegmentedControl alloc] initWithItems:@[ NSLocalizedStringFromTable(@"Previous", @"BSKeyboardControls", @"Previous button title."),
                                                                               NSLocalizedStringFromTable(@"Next", @"BSKeyboardControls", @"Next button title.") ]]];
        [self.segmentedControl addTarget:self action:@selector(segmentedControlValueChanged:) forControlEvents:UIControlEventValueChanged];
        [self.segmentedControl setMomentary:YES];
        [self.segmentedControl setEnabled:NO forSegmentAtIndex:BSKeyboardControlsDirectionPrevious];
        [self.segmentedControl setEnabled:NO forSegmentAtIndex:BSKeyboardControlsDirectionNext];
        [self setSegmentedControlItem:[[UIBarButtonItem alloc] initWithCustomView:self.segmentedControl]];
#endif // USE_SEGMENT
        [self setDoneButton:[[UIBarButtonItem alloc] initWithTitle:NSLocalizedStringFromTable(@"Done", @"BSKeyboardControls", @"Done button title.")
                                                             style:UIBarButtonItemStyleDone
                                                            target:self
                                                            action:@selector(doneButtonPressed:)]];
#ifdef USE_SEGMENT
        [self setVisibleControls:(BSKeyboardControlPreviousNext | BSKeyboardControlDone)];
#else
        [self setVisibleControls:BSKeyboardControlDone];
#endif // USE_SEGMENT
        [self setFields:fields];
    }
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)setActiveField:(id)activeField
{
    if (activeField != _activeField)
    {
        if ([self.fields containsObject:activeField])
        {
            _activeField = activeField;
        
            if (![activeField isFirstResponder])
            {
                [activeField becomeFirstResponder];
            }
#ifdef USE_SEGMENT

            [self updateSegmentedControlEnabledStates];
#endif // USE_SEGMENT

        }
    }
}

- (void)setFields:(NSArray *)fields
{
    if (fields != _fields)
    {
        for (UIView *field in fields)
        {
            if ([field isKindOfClass:[UITextField class]])
            {
                [(UITextField *)field setInputAccessoryView:self];
            }
            else if ([field isKindOfClass:[UITextView class]])
            {
                [(UITextView *)field setInputAccessoryView:self];
            }
            else if ([field isKindOfClass:[iOSCombobox class]])
            {
                [(iOSCombobox *)field setInputAccessoryView:self];
            }
        }
        
        _fields = fields;
    }
}

- (void)setBarStyle:(UIBarStyle)barStyle
{
    if (barStyle != _barStyle)
    {
        [self.toolbar setBarStyle:barStyle];
        
        _barStyle = barStyle;
    }
}

- (void)setBarTintColor:(UIColor *)barTintColor
{
    if (barTintColor != _barTintColor)
    {
        [self.toolbar setTintColor:barTintColor];
        
        _barTintColor = barTintColor;
    }
}

#ifdef USE_SEGMENT

- (void)setSegmentedControlTintControl:(UIColor *)segmentedControlTintControl
{
    if (segmentedControlTintControl != _segmentedControlTintControl)
    {
        [self.segmentedControl setTintColor:segmentedControlTintControl];
        
        _segmentedControlTintControl = segmentedControlTintControl;
    }
}

- (void)setPreviousTitle:(NSString *)previousTitle
{
    if (![previousTitle isEqualToString:_previousTitle])
    {
        [self.segmentedControl setTitle:previousTitle forSegmentAtIndex:BSKeyboardControlsDirectionPrevious];
        
        _previousTitle = previousTitle;
    }
}

- (void)setNextTitle:(NSString *)nextTitle
{
    if (![nextTitle isEqualToString:_nextTitle])
    {
        [self.segmentedControl setTitle:nextTitle forSegmentAtIndex:BSKeyboardControlsDirectionNext];
        
        _nextTitle = nextTitle;
    }
}
#endif // USE_SEGMENT
- (void)setDoneTitle:(NSString *)doneTitle
{
    if (![doneTitle isEqualToString:_doneTitle])
    {
        [self.doneButton setTitle:doneTitle];
        
        _doneTitle = doneTitle;
    }
}

- (void)setDoneTintColor:(UIColor *)doneTintColor
{
    if (doneTintColor != _doneTintColor)
    {
        [self.doneButton setTintColor:doneTintColor];
        
        _doneTintColor = doneTintColor;
    }
}

- (void)setVisibleControls:(BSKeyboardControl)visibleControls
{
    if (visibleControls != _visibleControls)
    {
        _visibleControls = visibleControls;

        [self.toolbar setItems:[self toolbarItems]];
    }
}

#pragma mark -
#pragma mark Private Methods

#ifdef USE_SEGMENT
- (void)segmentedControlValueChanged:(id)sender
{
    switch (self.segmentedControl.selectedSegmentIndex)
    {
        case BSKeyboardControlsDirectionPrevious:
            [self selectPreviousField];
            break;
        case BSKeyboardControlsDirectionNext:
            [self selectNextField];
            break;
        default:
            break;
    }
}
#endif // USE_SEGMENT
- (void)doneButtonPressed:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(keyboardControlsDonePressed:)])
    {
        [self.delegate keyboardControlsDonePressed:self];
    }
}

#ifdef USE_SEGMENT

- (void)updateSegmentedControlEnabledStates
{
    NSInteger index = [self.fields indexOfObject:self.activeField];
    if (index != NSNotFound)
    {
        [self.segmentedControl setEnabled:(index > 0) forSegmentAtIndex:BSKeyboardControlsDirectionPrevious];
        [self.segmentedControl setEnabled:(index < [self.fields count] - 1) forSegmentAtIndex:BSKeyboardControlsDirectionNext];
    }
}


- (void)selectPreviousField
{
    NSInteger index = [self.fields indexOfObject:self.activeField];
    if (index > 0)
    {
        index -= 1;
        UIView *field = [self.fields objectAtIndex:index];
        [self setActiveField:field];
        
        if ([self.delegate respondsToSelector:@selector(keyboardControls:selectedField:inDirection:)])
        {
            [self.delegate keyboardControls:self selectedField:field inDirection:BSKeyboardControlsDirectionPrevious];
        }
    }
}

- (void)selectNextField
{
    NSInteger index = [self.fields indexOfObject:self.activeField];
    if (index < [self.fields count] - 1)
    {
        index += 1;
        UIView *field = [self.fields objectAtIndex:index];
        [self setActiveField:field];
        
        if ([self.delegate respondsToSelector:@selector(keyboardControls:selectedField:inDirection:)])
        {
            [self.delegate keyboardControls:self selectedField:field inDirection:BSKeyboardControlsDirectionNext];
        }
    }
}
#endif // USE_SEGMENT

- (NSArray *)toolbarItems
{
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:3];
    if (self.visibleControls & BSKeyboardControlPreviousNext)
    {
        [items addObject:self.segmentedControlItem];
    }
    
    if (self.visibleControls & BSKeyboardControlDone)
    {
        [items addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil]];
        [items addObject:self.doneButton];
    }
    
    return items;
}

@end
