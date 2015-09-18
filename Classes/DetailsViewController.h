//
//  Created by Hasan Sa on 9/18/15.
//  Copyright © 2015 HWS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDPoi.h"
#import "IDLocation.h"

@interface DetailsViewController : UIViewController 

@property (nonatomic , weak) IDPoi* currentPoi;
@property (assign) BOOL  editIsEnabled;

@end
