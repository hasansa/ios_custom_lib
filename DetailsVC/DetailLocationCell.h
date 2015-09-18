//
//  Created by Hasan Sa on 9/18/15.
//  Copyright © 2015 HWS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DetailLocationCellDelegate <NSObject>

- (void)save;
- (void)navigate;
- (void)show;

@end

@interface DetailLocationCell : UITableViewCell

+ (DetailLocationCell*) detailLocationCell;
- (void)displayDataForPoiTitle:(NSString*)title categories:(NSArray*)categories editMode:(BOOL)_editIsEnabled;

@property (nonatomic, assign) id <DetailLocationCellDelegate>delegate;

@property (weak, nonatomic) IBOutlet UIView *viewRate;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblCategories;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;
@property (weak, nonatomic) IBOutlet UIButton *btnNavigate;
@property (weak, nonatomic) IBOutlet UIButton *btnShowOnMap;
@end
