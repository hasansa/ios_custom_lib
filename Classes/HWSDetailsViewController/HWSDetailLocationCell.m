//
//  Created by Hasan Sa on 9/18/15.
//  Copyright © 2015 HWS. All rights reserved.
//

#import "HWSDetailLocationCell.h"
#import "HWSAppearanceTheme.h"
#import "HWSLocalization.h"
#import "Global.h"

@implementation HWSDetailLocationCell

+ (HWSDetailLocationCell*) detailLocationCell
{
    HWSDetailLocationCell * cell = [[[NSBundle mainBundle] loadNibNamed:@"HWSDetailLocationCell" owner:self options:nil] objectAtIndex:0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //Rating
        _viewRate.layer.cornerRadius = 20.0f;
        
        //Btn save
        _btnSave.layer.cornerRadius = 5.0f;

        //Btn show on Map
        _btnShowOnMap.layer.cornerRadius = 5.0f;
        
        //Btn checkin
        _btnNavigate.layer.cornerRadius = 5.0f;
    }
    return self;
}

- (void)awakeFromNib
{
    //Rating
    _viewRate.layer.borderColor = [[HWSAppearanceTheme sharedTheme] secondColor].CGColor;
    _viewRate.layer.borderWidth = 1.0f;
    _viewRate.layer.cornerRadius = 24.5f;
    
    //Btn save
    _btnSave.layer.cornerRadius = 18.0f;
    
    //Btn show on Map
    _btnShowOnMap.layer.cornerRadius = 18.0f;
    
    //Btn checkin
    _btnNavigate.layer.cornerRadius = 18.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)displayDataForPoiTitle:(NSString*)title categories:(NSArray*)categories editMode:(BOOL)_editIsEnabled
{
//    self.imgView.image =[UIImage imageNamed:@"info"];
    self.lblTitle.text = title;
    
    NSString * allCatsStr;
    for (NSString * cat in categories) {
        if (nil == allCatsStr) {
            allCatsStr = cat;
        } else {
            allCatsStr = [NSString stringWithFormat:@"%@, %@", allCatsStr, cat];
        }
    }
    
    self.lblCategories.text = allCatsStr;
    
    [self.btnSave setTitle:(!_editIsEnabled) ? LOCALIZATION(@"alert_save") : LOCALIZATION(@"alert_edit")
                  forState:UIControlStateNormal];
    
    [self.btnNavigate setTitle:LOCALIZATION(@"take_me")
                      forState:UIControlStateNormal];
    
    [self.btnShowOnMap setTitle:LOCALIZATION(@"show_on_map")
                       forState:UIControlStateNormal];
}


#pragma mark IBAction
- (IBAction)showOnMap:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(show)]) {
        [self.delegate show];
    }
}
- (IBAction)navigateTo:(id)sender {
    if ([self.delegate respondsToSelector:@selector(navigate)]) {
        [self.delegate navigate];
    }
}
- (IBAction)saveTo:(id)sender {
    if ([self.delegate respondsToSelector:@selector(save)]) {
        [self.delegate save];
    }
}

@end
