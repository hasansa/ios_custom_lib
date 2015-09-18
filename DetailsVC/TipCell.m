//
//  Created by Hasan Sa on 9/18/15.
//  Copyright © 2015 HWS. All rights reserved.
//

#import "TipCell.h"

@implementation TipCell

+ (TipCell*) tipCell
{
    TipCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"TipCell" owner:self options:nil] objectAtIndex:0];
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)displayDataForPoiDescriptionText:(NSString*)text
{
    self.contentLbl.text = text;
    [self.contentLbl sizeThatFits:CGSizeMake(self.contentLbl.frame.size.width, self.frame.size.height - 10)];
    
    CGSize maximumLabelSize = CGSizeMake(self.contentLbl.frame.size.width, FLT_MAX);
    
    CGSize expectedLabelSize = [text boundingRectWithSize:maximumLabelSize
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{NSFontAttributeName:self.contentLbl.font}
                                                  context:nil].size;
    
    //adjust the label the the new height.
    CGRect newFrame = self.contentLbl.frame;
    newFrame.size.height = expectedLabelSize.height + 5;
    self.contentLbl.frame = newFrame;
}

@end
