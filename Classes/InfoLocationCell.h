//
//  Created by Hasan Sa on 9/18/15.
//  Copyright © 2015 HWS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@protocol InfoLocationCellDelegate <NSObject>

- (void)call;
- (void)email;
- (void)visitWeb;

@end

@interface InfoLocationCell : UITableViewCell

@property (nonatomic, assign) id <InfoLocationCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *hours;
@property (weak, nonatomic) IBOutlet UIButton *phone;
@property (weak, nonatomic) IBOutlet UIButton *web;
@property (weak, nonatomic) IBOutlet UIButton *email;

+ (InfoLocationCell*) addressLocationDetailCell;

- (void)displayDataForPoiInfo:(NSDictionary*)info;

@end
