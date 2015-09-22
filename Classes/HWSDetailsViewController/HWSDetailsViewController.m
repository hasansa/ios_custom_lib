//
//  Created by Hasan Sa on 9/18/15.
//  Copyright © 2015 HWS. All rights reserved.
//

#import "HWSDetailsViewController.h"
#import "HWSTGFoursquareDetail.h"
#import "HWSDetailLocationCell.h"
#import "HWSInfoLocationCell.h"
#import "HWSTipCell.h"

#import "Global.h"
#import "HWSUserDefaults.h"
#import "HWSAppearanceTheme.h"
#import "HWSLocalization.h"
#import "HWSRevealViewController.h"

#define BASE_URL @"<BASE-URL-HERE>"

@interface HWSDetailsViewController () <UITableViewDataSource,
                                UITableViewDelegate,
                                HWSTGFoursquareLocationDetailDelegate,
                                HWSImagePagerDelegate,
                                HWSImagePagerDataSource,
                                HWSDetailLocationCellDelegate,
                                HWSInfoLocationCellDelegate>
{
    NSString* phoneURL;
    NSString* emailURL;
    NSArray * _allPoisId;
    NSMutableArray * _dataArray;
}

@property (nonatomic, strong) HWSTGFoursquareDetail *tgFoursquareDetail;

@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *headerTitle;

@property (nonatomic, strong) NSDictionary * dictionaryDetails;
@property (nonatomic, strong) NSString * currentIdentifier;
@property (nonatomic , strong) NSDictionary * dictionaryData;

@end

@implementation HWSDetailsViewController

- (void)setCurrentPoi:(NSDictionary *)currentPoi
{
    _currentPoi = currentPoi;
    
    // generate phone URL if EXIST
    NSMutableArray* tmpArr = [NSMutableArray array];
    [tmpArr addObjectsFromArray :[self.currentPoi[@"info"][kStation] componentsSeparatedByString:@","]];
    [tmpArr addObjectsFromArray :[self.currentPoi[@"info"][kNurse] componentsSeparatedByString:@","]];

    phoneURL = [NSString stringWithFormat:@"tel://%@",
                [tmpArr firstObject]];
    
    // generate email URL if EXIST
    emailURL = [NSString stringWithFormat:@"mailto:?to=%@",
                [[self.currentPoi[@"info"][kEmail]  componentsSeparatedByString:@","] firstObject]];
    
    
}

#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.tgFoursquareDetail = [[HWSTGFoursquareDetail alloc] initWithFrame:self.view.bounds];
    self.tgFoursquareDetail.tableViewDataSource = self;
    self.tgFoursquareDetail.tableViewDelegate = self;
    
    self.tgFoursquareDetail.delegate = self;
    self.tgFoursquareDetail.parallaxScrollFactor = 0.3; // little slower than normal.
    
    [self.view addSubview:self.tgFoursquareDetail];
    
    [self.view bringSubviewToFront:_headerView];
    
    UIButton *buttonBack = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonBack.frame = CGRectMake(10, 22, 44, 44);
    [buttonBack setImage:[UIImage imageNamed:@"back-arrow"] forState:UIControlStateNormal];
    [buttonBack addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonBack];
    
    self.tgFoursquareDetail.headerView = _headerView;
    
    _headerView.backgroundColor = [[HWSAppearanceTheme sharedTheme] secondColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.headerTitle.text = _currentPoi[@"title"];
    [self.tgFoursquareDetail.tableView reloadData];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    if (![self loadUserFavoritesDefaults]) {
        _dataArray = [NSMutableArray array];
        _dictionaryData = [NSDictionary dictionary];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - private

- (CGFloat)requiredDescriptionHeight
{
    if (_currentPoi.description == nil)
        return 0;
    
    UILabel*myLabel = [HWSTipCell tipCell].contentLbl;
    CGSize maximumLabelSize = CGSizeMake(myLabel.frame.size.width, FLT_MAX);
    NSString *description = [NSString stringWithFormat:@"\n%@\n", _currentPoi.description];
    CGSize expectedLabelSize = [description boundingRectWithSize:maximumLabelSize
                                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                                  attributes:@{NSFontAttributeName:myLabel.font}
                                                                     context:nil].size;
    
    return 1.20 * expectedLabelSize.height;
    
}

- (void)showAlert
{
    NSString* title = (!_editIsEnabled)? LOCALIZATION(@"alert_save") : LOCALIZATION(@"alert_edit");
#if !__IPHONE_9_0
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:title
                                                     message:nil
                                                    delegate:self
                                           cancelButtonTitle:LOCALIZATION(@"alert_cancel")
                                           otherButtonTitles:LOCALIZATION(@"alert_ok"), nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [[alert textFieldAtIndex:0] setText:_currentPoi.title];
    [[alert textFieldAtIndex:0] setClearButtonMode:UITextFieldViewModeAlways];
    [alert show];
#else
    
    // Create Alert
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:title
                                                                            message:nil
                                                                     preferredStyle:UIAlertControllerStyleAlert];
    // Create the text Field.
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         textField.text = _currentPoi[@"title"];
         [textField setClearButtonMode:UITextFieldViewModeAlways];
     }];
    
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:LOCALIZATION(@"alert_cancel")
                                                          style:UIAlertActionStyleCancel
                                                        handler:^(UIAlertAction * _Nonnull action) {
                                                            
                                                        }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:LOCALIZATION(@"alert_ok")
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             
                                                             NSString *newtitle = alertController.textFields.firstObject.text;
                                                             
                                                             [self saveDataWithTitle:newtitle];
                                                             [self.navigationController popViewControllerAnimated:YES];
                                                         }];
    
    // Add the actions.
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:true completion:nil];
#endif
}

#pragma mark - UITableView

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        case 2:
            return 150.0;
        case 1:
            return [self requiredDescriptionHeight];
        default:
            return 100;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.row == 0){
        HWSDetailLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailLocationCell"];
        
        if(cell == nil){
            cell = [HWSDetailLocationCell detailLocationCell];
        }
        [cell displayDataForPoiTitle:_currentPoi[@"title"] categories:_currentPoi[@"categories"] editMode:_editIsEnabled];
        
        cell.delegate = self;
        return cell;
    }
    else if(indexPath.row == 1){
        HWSTipCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tipCell"];
        
        if(cell == nil){
            cell = [HWSTipCell tipCell];
        }
        NSString *description = _currentPoi.description;
        if (description != nil) {
            description = [NSString stringWithFormat:@"\n%@\n", _currentPoi.description];
        }
        [cell displayDataForPoiDescriptionText:description];
        
        return cell;
    }
    else if(indexPath.row == 2){
        HWSInfoLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addressLocationDetail"];
        
        if(cell == nil){
            cell = [HWSInfoLocationCell addressLocationDetailCell];
        }
        
        cell.delegate = self;
        [cell displayDataForPoiInfo:_currentPoi[@"info"]];
        
        return cell;
    }
    else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reusable"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reusable"];
        }
        
        cell.textLabel.text = @"Default cell";
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.contentView.backgroundColor = [UIColor whiteColor];
}

#pragma mark - DetailLocationCellDelegate

- (void)save
{
    [self showAlert];
}

- (void)navigate
{
    [self.revealViewController navigateToLocation:self.currentPoi[@"location"]];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)show
{
    [self.revealViewController presentPoi:self.currentPoi];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - InfoLocationCellDelegate

- (void)call
{
    if (nil != phoneURL) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneURL]];
    }
}

- (void)email
{
    if (nil != emailURL) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:emailURL]];
    }
}

- (void)visitWeb
{
//    WebPageViewController * wvc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
//                                   instantiateViewControllerWithIdentifier:@"webPageViewController"];
//    wvc.title = self.currentPoi.title;
//    wvc.urlString = _currentPoi.info[kUrl];
//    [self.navigationController pushViewController:wvc animated:YES];
}

#pragma mark - LocationDetailViewDelegate

- (void)locationDetail:(HWSTGFoursquareDetail *)locationDetail imagePagerDidLoad:(HWSImagePager *)imagePager
{
    imagePager.dataSource = self;
    imagePager.delegate = self;
    imagePager.pageControl.currentPageIndicatorTintColor = [UIColor lightGrayColor];
    imagePager.pageControl.pageIndicatorTintColor = [UIColor blackColor];
    imagePager.slideshowTimeInterval = 0.0f;
    imagePager.slideshowShouldCallScrollToDelegate = YES;
    
    self.tgFoursquareDetail.nbImages = (int)[self.tgFoursquareDetail.imagePager.dataSource.arrayWithImages count];
    self.tgFoursquareDetail.currentImage = 0;
    [imagePager updateCaptionLabelForImageAtIndex:self.tgFoursquareDetail.currentImage];
}

- (void)locationDetail:(HWSTGFoursquareDetail *)locationDetail tableViewDidLoad:(UITableView *)tableView
{
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

- (void)locationDetail:(HWSTGFoursquareDetail *)locationDetail headerViewDidLoad:(UIView *)headerView
{
    [headerView setAlpha:0.0];
    [headerView setHidden:YES];
}

#pragma mark - KIImagePager DataSource
- (NSArray *) arrayWithImages
{
    NSString* poiImgUrl = [NSString stringWithFormat:@"%@res/%@/%@/%@/",
                           BASE_URL,
                           [[HWSUserDefaults sharedDefaults] projectID],
                           self.currentPoi[@"location"][@"campusId"],
                           self.currentPoi[@"location"][@"facilityId"]];
    
    
    NSArray* galleriesArr = self.currentPoi[@"info"][kGalleries];
    NSMutableArray* gallariesURLs = [NSMutableArray arrayWithCapacity:galleriesArr.count];
    
    for (int i = 0; i < galleriesArr.count; i++) {
        [gallariesURLs addObject:[NSString stringWithFormat:@"%@%@", poiImgUrl, galleriesArr[i]]];
    }
    if (gallariesURLs.count > 0)
        return [NSArray arrayWithArray:gallariesURLs];
    else {
//        NSDictionary* userInfo = [[JsonDataManager sharedManager] homeDict][@"homescreeninfos"];
//        return @[kDetailsIconUrlByAppendName(userInfo[@"facimage"])];
        return nil;
    }
}

- (UIViewContentMode) contentModeForImage:(NSUInteger)image
{
    return UIViewContentModeScaleAspectFill;
}

- (NSString *) captionForImageAtIndex:(NSUInteger)index
{
    return nil;
  return @[@"First screenshot",
             @"Another screenshot",
             @"And another one",
             @"Last one! ;-)"][index];
}

#pragma mark - KIImagePager Delegate
- (void) imagePager:(HWSImagePager *)imagePager didScrollToIndex:(NSUInteger)index
{}

- (void) imagePager:(HWSImagePager *)imagePager didSelectImageAtIndex:(NSUInteger)index
{}

#pragma mark - Button actions

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark -
# pragma mark  UIAlertViewDelegate

#if !__IPHONE_9_0
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != alertView.cancelButtonIndex) {
        
        [self saveDataWithTitle:[[alertView textFieldAtIndex:0] text]];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#endif // __IPHONE_9_0

# pragma mark -
# pragma mark  Data Store
- (void)saveDataWithTitle:(NSString *)title
{
    NSMutableDictionary * tmpDic = [NSMutableDictionary dictionaryWithDictionary:_dictionaryData];
    
    [self storePoiWithTitle:title];
    
    // update user favorites
    [tmpDic setObject:[NSArray arrayWithArray:_dataArray]  forKey:_currentIdentifier];
    _dictionaryData = [NSDictionary dictionaryWithDictionary:tmpDic];
    [self updateUserPersonalDefaults];
}

- (void)storePoiWithTitle:(NSString *)title
{
    NSMutableArray * tmpArr = [NSMutableArray arrayWithArray:_dataArray];
    
    NSString * poiIdentifier = [NSString stringWithFormat:@"%@.%d.%@", self.currentIdentifier,
                                (int)[self.currentPoi[@"location"][@"floorId"] integerValue],
                                self.currentPoi[@"identifier"]];
    
    // if already stored
    for (NSDictionary * delDic in _dataArray) {
        
        NSString * delId = delDic[@"id"];
        
        if ([delId isEqualToString:poiIdentifier])
            [tmpArr removeObject:delDic];
    }
    
    [tmpArr addObject:@{@"title":title, @"id":poiIdentifier}];
    
    
    _dataArray = tmpArr;
}

#pragma mark -
#pragma mark UserDefaults
- (BOOL)loadUserFavoritesDefaults
{
    if (nil != [[HWSUserDefaults sharedDefaults] userPersonalPois]) {
        
        _dictionaryData = [[HWSUserDefaults sharedDefaults] userPersonalPois];
        
        if (nil != _dictionaryData && 0 < _dictionaryData.count) {
            _dataArray = [_dictionaryData objectForKey:self.currentIdentifier];
            
            return YES;
        }
    }
    
    return NO;
}

- (void)updateUserPersonalDefaults
{
    // called when the user want to edit poi favorite
    [[HWSUserDefaults sharedDefaults] setUserPersonalPoi:_dictionaryData];
    
    //    [self updateDetails];
}

@end
