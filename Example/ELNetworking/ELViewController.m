//
//  ELViewController.m
//  ELNetworking
//
//  Created by liyonghui16 on 12/21/2017.
//  Copyright (c) 2017 liyonghui16. All rights reserved.
//

#import "ELViewController.h"
#import "ELTestAPI.h"

@interface ELViewController () <ELBaseAPIDelegate>

@end

@implementation ELViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    ELTestAPI *api = [[ELTestAPI alloc] init];
    api.dataReceiver = self;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [api requestData];
}

- (void)api:(ELBaseAPI *)api finishedWithResponse:(ELResponse *)response {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    NSLog(@"%@", response.data);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
