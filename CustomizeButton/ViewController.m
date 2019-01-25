//
//  ViewController.m
//  CustomizeButton
//
//  Created by Noah on 2019/1/25.
//  Copyright © 2019 fx. All rights reserved.
//

#import "ViewController.h"
#import "FXCustomizeButton.h"
// 颜色
#define RGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define RGBColor(r, g, b)     RGBAColor((r), (g), (b), 1.0)

#define RandomColor           RGBColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    FXCustomizeButton *btn1 = [FXCustomizeButton buttonWithImagePosition:ImagePositionTop innerPadding:10];
    btn1.backgroundColor = RandomColor;
    btn1.frame = CGRectMake(10, 10, 100, 100);
    [btn1 setTitle:@"btn1" forState:UIControlStateNormal];
    [btn1 setImage:[UIImage imageNamed:@"collectionBtn_selected"] forState:UIControlStateNormal];
    [self.view addSubview:btn1];
    
    FXCustomizeButton *btn2 = [FXCustomizeButton buttonWithImagePosition:ImagePositionLeft innerPadding:10];
    btn2.backgroundColor = RandomColor;
    btn2.frame = CGRectMake(150, 10, 100, 100);
    [btn2 setTitle:@"btn2" forState:UIControlStateNormal];
    [btn2 setImage:[UIImage imageNamed:@"collectionBtn_selected"] forState:UIControlStateNormal];
    [self.view addSubview:btn2];
    
    FXCustomizeButton *btn3 = [FXCustomizeButton buttonWithImagePosition:ImagePositionRight innerPadding:10];
    btn3.backgroundColor = RandomColor;
    btn3.frame = CGRectMake(10, 150, 100, 100);
    [btn3 setTitle:@"btn3" forState:UIControlStateNormal];
    [btn3 setImage:[UIImage imageNamed:@"collectionBtn_selected"] forState:UIControlStateNormal];
    [self.view addSubview:btn3];
    
    FXCustomizeButton *btn4 = [FXCustomizeButton buttonWithImagePosition:ImagePositionBottom innerPadding:10];
    btn4.backgroundColor = RandomColor;
    btn4.frame = CGRectMake(150, 150, 100, 100);
    [btn4 setTitle:@"btn4" forState:UIControlStateNormal];
    [btn4 setImage:[UIImage imageNamed:@"collectionBtn_selected"] forState:UIControlStateNormal];
    [self.view addSubview:btn4];
    
}


@end
