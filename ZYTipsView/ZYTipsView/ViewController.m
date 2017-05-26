//
//  ViewController.m
//  ZYTipsView
//
//  Created by admin on 17/5/26.
//  Copyright © 2017年 zhuoyu. All rights reserved.
//

#import "ViewController.h"
#import "ZYTipsView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)onClickLeft:(id)sender {
    [self showTips:ZYTipsArrowTypeLeft];
}

- (void)onClickRight:(id)sender {
    [self showTips:ZYTipsArrowTypeRight];
}

- (void)onClickTop:(id)sender {
    [self showTips:ZYTipsArrowTypeUp];
}

- (void)onClickBottom:(id)sender {
    [self showTips:ZYTipsArrowTypeDown];
}

- (void)showTips:(ZYTipsArrowType)arrowType {
    //  自定义view
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 170, 25)];
    customView.backgroundColor = [UIColor redColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 3, 170, 19)];
    label.font = [UIFont systemFontOfSize:14];
    label.text = @"点击上传第一个作品";
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.numberOfLines = 1;
    label.backgroundColor = [UIColor clearColor];
    [customView addSubview:label];
    
    
    ZYTipsView *tipsView = [[ZYTipsView alloc] initWithContentView:customView arrowType:arrowType offset:40];
    [tipsView show];
}

@end
