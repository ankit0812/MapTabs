//
//  DetailViewController.h
//  MapTabs
//
//  Created by optimusmac4 on 8/17/15.
//  Copyright (c) 2015 optimusmac4. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *subLocality;

@property (weak, nonatomic)NSString *subLocalitytext;
@property (weak, nonatomic)NSString *localitytext;
@property (weak, nonatomic)NSString *adminAreatext;
@property (weak, nonatomic)NSString *countrytext;
@property (weak, nonatomic)NSString *pinCodetext;

@end
