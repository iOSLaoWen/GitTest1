//
//  ViewController.m
//  WKWebView
//
//  Created by 张诚 on 15/3/19.
//  Copyright (c) 2015年 zhangcheng. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import "JGProgressHUD.h"
#import "JGProgressHUDPieIndicatorView.h"
@interface ViewController ()<WKNavigationDelegate>
{
    NSTimer*timer;
    WKWebView*_webView;
    JGProgressHUD *HUD;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"hehe1");
    NSLog(@"hehe2");
    NSLog(@"hehe3");
    _webView=[[WKWebView alloc]initWithFrame:self.view.frame];
    _webView.navigationDelegate=self;
    
    _webView.allowsBackForwardNavigationGestures=YES;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
    [self.view addSubview:_webView];
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog(@"开始请求%f",webView.estimatedProgress);
     HUD = [[JGProgressHUD alloc] initWithStyle:0];
    HUD.progressIndicatorView = [[JGProgressHUDPieIndicatorView alloc] initWithHUDStyle:HUD.style];
    HUD.userInteractionEnabled = NO;
    HUD.textLabel.text = @"Uploading...";
    [HUD showInView:self.view];

    
    
    
    //添加一个计时器
    if (timer) {
        [timer invalidate];
    }
    timer=[NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(timerClick) userInfo:nil repeats:YES];
    
    
    
}
-(void)timerClick{

    NSLog(@"%f",_webView.estimatedProgress);
    
    [HUD setProgress:_webView.estimatedProgress animated:YES];

}
-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    NSLog(@"提交数据");
}
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    NSLog(@"请求完成");
    
    [HUD dismiss];
    [timer invalidate];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
