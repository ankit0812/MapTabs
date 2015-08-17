//
//  DetailViewController.m
//  MapTabs
//
//  Created by optimusmac4 on 8/17/15.
//  Copyright (c) 2015 optimusmac4. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    NSString *appender=[[NSString alloc] initWithFormat:@"%@ %@ %@ %@ %@ %@",@"Your Address is :\n",_subLocalitytext,_localitytext,_adminAreatext,_countrytext,_pinCodetext];
    
    _subLocality.text=appender;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
