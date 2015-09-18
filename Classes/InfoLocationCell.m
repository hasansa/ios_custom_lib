//
//  Created by Hasan Sa on 9/18/15.
//  Copyright © 2015 HWS. All rights reserved.
//

#import "InfoLocationCell.h"
#import "Global.h"

@implementation InfoLocationCell

+ (InfoLocationCell*) addressLocationDetailCell
{
    InfoLocationCell * cell = [[[NSBundle mainBundle] loadNibNamed:@"InfoLocationCell" owner:self options:nil] objectAtIndex:0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    _phone.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _phone.layer.borderWidth = 1.0f;
    _phone.layer.cornerRadius = 18.0f;
    
    _email.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _email.layer.borderWidth = 1.0f;
    _email.layer.cornerRadius = 18.0f;
    
    _web.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _web.layer.borderWidth = 1.0f;
    _web.layer.cornerRadius = 18.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)displayDataForPoiInfo:(NSDictionary*)info
{
    _hours.text = info[kVisit];
    
    _email.enabled = (info[kEmail] != nil);
    
    _phone.enabled = (info[kStation] != nil) || (info[kNurse] != nil);
    
    _web.enabled = (info[kUrl] != nil);
}

#pragma mark - IBAction
- (IBAction)call:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(call)]) {
        [self.delegate call];
    }
}
- (IBAction)gotoWeb:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(visitWeb)]) {
        [self.delegate visitWeb];
    }
}
- (IBAction)sendEmail:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(email)]) {
        [self.delegate email];
    }
}

@end
