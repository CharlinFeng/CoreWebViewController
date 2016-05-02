//
//  CoreWebViewController.m
//  CoreWebViewController
//
//  Created by 冯成林 on 16/1/7.
//  Copyright © 2016年 冯成林. All rights reserved.
//

#import "CoreWebViewController.h"

@interface CoreWebViewController ()

@property (nonatomic,strong) UILabel *providerLabel;

@property (nonatomic,strong) NSArray *types;

@property (nonatomic,copy) NSString *hostName;

@end

@implementation CoreWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.edgesForExtendedLayout = UIRectEdgeAll;
    //背景色
    self.webView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor colorWithRed:46./255. green:49./255. blue:50./255. alpha:1];
    
    //添加ProviderLabel
    [self.view.layer insertSublayer:self.providerLabel.layer atIndex:0];
    
    self.showUrlWhileLoading = NO;
}

-(UILabel *)providerLabel{
    
    if(_providerLabel == nil){
        
        //添加label
        _providerLabel = [[UILabel alloc] init];
        _providerLabel.font = [UIFont systemFontOfSize:12];
        _providerLabel.textColor = [UIColor colorWithRed:103./255. green:107./255. blue:109./255. alpha:1];
        _providerLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _providerLabel;
}


-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    if(CGRectEqualToRect(self.providerLabel.frame, CGRectZero)){
        
        CGFloat wh = self.view.bounds.size.width;
        CGFloat y = self.navigationController == nil ? 10 : 64;
        self.providerLabel.frame = CGRectMake(0, y, wh, 40);
    }
    
}


-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    BOOL res = [super webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
    
    [self cutHost:request.URL.absoluteString];
    
    if (self.hostName != nil) {
        self.providerLabel.text = [NSString stringWithFormat:@"时点软件提示您：网页由 %@ 提供",self.hostName];
    }else {
        self.providerLabel.text = @"";
    }
    
    
    return res;
}


-(NSArray *)types{
    
    if(_types == nil){
        
        _types = @[@"com.cn",@"net.cn",@"org.cn",@"com",@"cn",@"org",@"im",@"wang",@"cc",@"fm",@"net",@"biz",@"info",@"edu",@"edu",@"gov",@"hk",@"jp",@"uk",@"fr",@"au",@"de"];
    }
    
    return _types;
}

-(NSString *)cutHost:(NSString *)urlString{
    
    if ([urlString isEqualToString:@"about:blank"]){return nil;}
    
    __block NSRange range = NSMakeRange(0, 0);
    
    [self.types enumerateObjectsUsingBlock:^(NSString *typeString, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSRange calRange = [urlString rangeOfString:typeString];
        
        if(calRange.length > 0){
            
            range = calRange;
            *stop = YES;
        }
    }];
    
    NSString *msgString = range.length == 0 ? nil : [urlString substringWithRange:NSMakeRange(0, range.location+range.length)];
    
    if ([msgString hasPrefix:@"http://"]) msgString = [msgString substringFromIndex:7];
    if ([msgString hasPrefix:@"https://"]) msgString = [msgString substringFromIndex:8];
    
    self.hostName = msgString;
    
    return msgString;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationButtonsHidden = NO;
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    self.navigationButtonsHidden = YES;
}


-(void)dealloc{self.navigationButtonsHidden = YES;}

@end
