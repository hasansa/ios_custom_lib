//
//  Created by Hasan Sa on 9/18/15.
//  Copyright © 2015 HWS. All rights reserved.
//

#import "HWSSidebarViewController.h"
#import "HWSRevealViewController.h"
#import "HWSAppearanceTheme.h"
#import "Global.h"
#import "HWSLocalization.h"
//
#define kDisplayImage @"kViewControllerDisplayImage"
#define kDisplaySelectedImage @"kViewControllerSelectedImage"
#define kDisplayName @"kViewControllerDisplayName"
#define kStoryboardIdentifier @"kViewControllerXib"
#define kMenuViewControllersPlist @"MenuViewControllers"
#define kMenuSideBarSet @"kSideBarSet"
//
#define kHomeViewController     _arrOfControllersData[0][0]
#define kMapViewController      _arrOfControllersData[0][1]

@interface HWSSidebarViewController ()
{
    BOOL mapItemSelected;
}
@property (nonatomic, strong) NSDictionary * controllersDict;
@property (nonatomic, strong) NSArray * arrOfControllersData;
@property (nonatomic, strong) NSIndexPath* currentIndexPath;

@end

@implementation HWSSidebarViewController

#pragma mark -
#pragma mark setup

-(void)setupViewControllers
{
    _arrOfControllersData   =   [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:kMenuViewControllersPlist ofType:@"plist"]];
    
    //Config the SIdePanelConfig.plist file to load all the view controllers in array and load them accordingly.
    
    NSMutableDictionary * vcDict = [NSMutableDictionary dictionary];
    
    UIStoryboard * mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
    for (int i = 0; i < _arrOfControllersData.count; i++) {
        NSArray* arr = _arrOfControllersData[i];
        for (NSDictionary * item in arr)
        {
            //Extracting the class name from the plist. NSClassFromString will provide us the object of class.
            NSString * strNibName    =   item[kStoryboardIdentifier];
            UIViewController * viewController = (UIViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:strNibName];
            [vcDict setObject:viewController forKey:strNibName];
            
        }
    }
    _controllersDict = [NSDictionary dictionaryWithDictionary:vcDict];
}

#pragma mark -
#pragma mark life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    [self setupViewControllers];
    
    // set Home VC as front View Controller
    NSDictionary* item = kHomeViewController;
    NSString* strNibName = item[kStoryboardIdentifier];
    _homeViewController = _controllersDict[strNibName];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadData)
                                                 name:kLocalizationLanguageDidChangeNotification
                                               object:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reloadData
{
    mapItemSelected = NO;
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark private

- (void)setCurrentIndexPath:(NSIndexPath *)currentIndexPath
{
    if (![_currentIndexPath isEqual:currentIndexPath]) {
        
        UITableViewCell* currentCell = (UITableViewCell*)[self.tableView cellForRowAtIndexPath:_currentIndexPath];
        if (_currentIndexPath != nil) {
            [self updateSelectedCell:currentCell indexPath:_currentIndexPath withDisplayImageKey:kDisplayImage];
        }
        
        UITableViewCell* selctedCell = (UITableViewCell*)[self.tableView cellForRowAtIndexPath:currentIndexPath];
        [self updateSelectedCell:selctedCell indexPath:currentIndexPath withDisplayImageKey:kDisplaySelectedImage];
    }
}

- (void)updateSelectedCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath withDisplayImageKey:(NSString*)key
{
    UIColor*backgroundColor = ([key isEqualToString:kDisplaySelectedImage])?
    [[HWSAppearanceTheme sharedTheme] secondColor]:    // blue bakground color
    [[HWSAppearanceTheme sharedTheme] mainColor];      // white bakground color
    
    UIColor* textColor = ([key isEqualToString:kDisplaySelectedImage])?
    [UIColor whiteColor]: // white text color
    [UIColor blackColor]; // black text color
    
    cell.backgroundColor = backgroundColor;
    NSDictionary* dict = _arrOfControllersData[indexPath.section][indexPath.row];
    cell.textLabel.text = LOCALIZATION(dict[kDisplayName]);
    cell.textLabel.textColor = textColor;
    cell.imageView.image = [UIImage imageNamed:dict[key]];
    _currentIndexPath = indexPath;
}

#pragma mark - navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ( [segue isKindOfClass: [HWSRevealViewControllerSegue class]] ) {
        HWSRevealViewControllerSegue *swSegue = (HWSRevealViewControllerSegue*) segue;
        
        swSegue.performBlock = ^(HWSRevealViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc) {
            
            UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
            [navController setViewControllers: @[dvc] animated: NO ];
            [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
        };
        
    }
    
}

#pragma mark -
#pragma mark public

- (id)mapViewController
{
    NSDictionary* item = kMapViewController;
    NSString* strNibName = item[kStoryboardIdentifier];
    return _controllersDict[strNibName];
}

- (void)updateMapItemAsSelectedCell
{
    if (_currentIndexPath == nil) {
        mapItemSelected = YES;
        [self.tableView reloadData];
    }
    self.currentIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return _arrOfControllersData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_arrOfControllersData[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellIdentifier = @"Cell";//([HWSLocalization isRTL])? @"RCell" : @"Cell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.highlightedTextColor = [UIColor lightGrayColor];
    UIView* selectedBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(cell.frame), CGRectGetHeight(cell.frame))];
    selectedBackgroundView.backgroundColor = [[HWSAppearanceTheme sharedTheme] secondColor];
    cell.selectedBackgroundView = selectedBackgroundView;
    
    NSDictionary* dict = _arrOfControllersData[indexPath.section][indexPath.row];
    cell.textLabel.text = LOCALIZATION(dict[kDisplayName]);
    cell.textLabel.textColor = [UIColor blackColor];
    cell.imageView.image = [UIImage imageNamed:dict[kDisplayImage]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* customCell = (UITableViewCell*)cell;
    
    if (self.currentIndexPath == nil && !mapItemSelected) {
        [self updateSelectedCell:customCell indexPath:indexPath withDisplayImageKey:kDisplaySelectedImage];
    }
    else {
        if (self.currentIndexPath != nil && !mapItemSelected) {
            if ([indexPath isEqual:self.currentIndexPath]) {
                [self updateSelectedCell:customCell indexPath:indexPath withDisplayImageKey:kDisplaySelectedImage];
            }
        }
    }
}


#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.currentIndexPath = indexPath;
    NSDictionary* item = _arrOfControllersData[indexPath.section][indexPath.row];
    NSString* strNibName = item[kStoryboardIdentifier];
    id vc = _controllersDict[strNibName];
    [self.revealViewController setFrontViewController:vc animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), 20.0)];
        view.backgroundColor = [UIColor colorWithRed:235 / 255.0
                                               green:235 / 255.0
                                                blue:230 / 255.0
                                               alpha:1.0];
        return view;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), 20.0)];
        view.backgroundColor = [UIColor colorWithRed:235 / 255.0
                                               green:235 / 255.0
                                                blue:230 / 255.0
                                               alpha:1.0];
        return view;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return 60.0;
    
    return 10.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0;
}

@end
