//
//  ELViewController.m
//  ELNetworking
//
//  Created by liyonghui16 on 12/21/2017.
//  Copyright (c) 2017 liyonghui16. All rights reserved.
//

#import "ELViewController.h"
#import "ELTestAPI.h"
#import <ELNetworking/ELBatchRequest.h>

@interface ELViewController () <ELBaseAPIDelegate, ELBatchRequestDelegate>

@end

@implementation ELViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)apiRequest:(id)sender {
    ELTestAPI *api = [[ELTestAPI alloc] init];
    api.dataReceiver = self;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [api requestData];
}

- (IBAction)apisRequest:(id)sender {
//    ELTestAPI *api1 = [[ELTestAPI alloc] init];
//    api1.dataReceiver = self;
//    ELTestAPI *api2 = [[ELTestAPI alloc] init];
//    api2.dataReceiver = self;
//    ELTestAPI *api3 = [[ELTestAPI alloc] init];
//    api3.dataReceiver = self;
//    ELBatchRequest *batchReq = [[ELBatchRequest alloc] initWithBatchAPIs:@[api1, api2, api3]];
//    batchReq.delegate = self;
//    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
//    [batchReq requestData];
}

- (void)api:(ELBaseAPI *)api finishedWithResponse:(ELResponse *)response {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    NSLog(@"%@", response.message);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
