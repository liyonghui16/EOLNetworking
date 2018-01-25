//
//  ELInputViewController.m
//  ELNetworking_Example
//
//  Created by Ens Livan on 2018/1/19.
//  Copyright © 2018年 liyonghui16. All rights reserved.
//

#import "ELInputViewController.h"
#import "ELInputAPI.h"

@interface ELInputViewController () <ELBaseAPIDelegate>

@property (nonatomic, strong) ELInputAPI *inputAPI;
@property (weak, nonatomic) IBOutlet UITextField *phoneTf;
@property (weak, nonatomic) IBOutlet UITextField *IDTf;
@property (weak, nonatomic) IBOutlet UITextField *codeTf;


@end

@implementation ELInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (IBAction)commitAction:(id)sender {
    self.inputAPI = [[ELInputAPI alloc] initWithPhone:self.phoneTf.text ID:self.IDTf.text code:self.codeTf.text];
    self.inputAPI.dataReceiver = self;
    [self.inputAPI requestData];
}

- (void)api:(ELBaseAPI *)api finishedWithResponse:(ELResponse *)response {
    if (!response.success) {
        NSLog(@"error_msg: %@", response.message);
    }
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
