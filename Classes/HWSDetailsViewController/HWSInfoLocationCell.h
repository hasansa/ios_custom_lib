//
//  Created by Hasan Sa on 9/18/15.
//  Copyright © 2015 HWS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@protocol HWSInfoLocationCellDelegate <NSObject>

- (void)call;
- (void)email;
- (void)visitWeb;

@end

@interface HWSInfoLocationCell : UITableViewCell

@property (nonatomic, assign) id <HWSInfoLocationCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *hours;
@property (weak, nonatomic) IBOutlet UIButton *phone;
@property (weak, nonatomic) IBOutlet UIButton *web;
@property (weak, nonatomic) IBOutlet UIButton *email;

+ (HWSInfoLocationCell*) addressLocationDetailCell;

- (void)displayDataForPoiInfo:(NSDictionary*)info;

@end
