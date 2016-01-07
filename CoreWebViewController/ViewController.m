//
//  ViewController.m
//  CoreWebViewController
//
//  Created by 冯成林 on 16/1/7.
//  Copyright © 2016年 冯成林. All rights reserved.
//

#import "ViewController.h"
#import "CoreWebViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)btnClick:(id)sender {
    
    CoreWebViewController *vc = [[CoreWebViewController alloc] initWithURLString:@"http://ios-android.cn/"];
    vc.buttonTintColor = [UIColor darkGrayColor];
    [self.navigationController pushViewController:vc animated:YES];
//    [self presentViewController:vc animated:YES completion:nil];
}


@end
