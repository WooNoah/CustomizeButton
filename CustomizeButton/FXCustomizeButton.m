//
//  FXCustomizeButton.m
//
//  Created by Noah on 2018/11/12.
//  Copyright © 2018 Noah. All rights reserved.
//

#import "FXCustomizeButton.h"

@interface FXCustomizeButton()

@property (assign, nonatomic) ImagePosition position;

@property (assign, nonatomic) CGFloat innerPadding;

@end

@implementation FXCustomizeButton


+ (instancetype)buttonWithImagePosition:(ImagePosition)position innerPadding:(CGFloat)padding {
    FXCustomizeButton *instance = [super buttonWithType:UIButtonTypeCustom];
    instance.position = position;
    instance.innerPadding = padding;
    return instance;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    [self reCalculateEdgeInsets];
}

- (void)reCalculateEdgeInsets {
    CGFloat imgViewW = self.imageView.bounds.size.width;
    CGFloat imgViewH = self.imageView.bounds.size.height;
    CGFloat titleLabelW = self.titleLabel.bounds.size.width;
    CGFloat titleLabH = self.titleLabel.bounds.size.height;
    CGSize textSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
    //这里是为了解决文字过长的情况下，图片位置错误的情况
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (frameSize.width > titleLabelW) {  //如果文字长度大于label的宽度
        titleLabelW = frameSize.width;
    }
    CGFloat margin = self.innerPadding;
    CGFloat halfPadding = self.innerPadding/2.0;
    switch (self.position) {
        case ImagePositionLeft:
        {
            [self setImageEdgeInsets:UIEdgeInsetsMake(0, -halfPadding, 0, halfPadding)];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0, halfPadding, 0, -halfPadding)];
        }
            break;
        case ImagePositionTop:
        {
            // button图片的偏移量
            [self setImageEdgeInsets:UIEdgeInsetsMake(0, 0, titleLabH + margin, -titleLabelW)];
            // button标题的偏移量
            [self setTitleEdgeInsets:UIEdgeInsetsMake(imgViewH + margin, -imgViewW, 0, 0)];
        }
            break;
        case ImagePositionRight:
        {
            // button标题的偏移量
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -self.imageView.bounds.size.width - halfPadding, 0, self.imageView.bounds.size.width + halfPadding);
            // button图片的偏移量
            self.imageEdgeInsets = UIEdgeInsetsMake(0, self.titleLabel.bounds.size.width + halfPadding, 0, -self.titleLabel.bounds.size.width - halfPadding);
        }
            break;
        default:
        {
            [self setImageEdgeInsets:UIEdgeInsetsMake(titleLabH + margin,0, 0, -titleLabelW)];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -imgViewW, imgViewH + margin, 0)];
        }
            break;
    }
}



@end
