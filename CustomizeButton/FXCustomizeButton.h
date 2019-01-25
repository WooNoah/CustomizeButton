//
//  FXCustomizeButton.h
//
//  Created by Noah on 2018/11/12.
//  Copyright © 2018 Noah. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ImagePosition) {
    ImagePositionLeft = 0,  //default
    ImagePositionTop,
    ImagePositionRight,
    ImagePositionBottom,
};

@interface FXCustomizeButton : UIButton

+ (FXCustomizeButton *)buttonWithImagePosition:(ImagePosition)position innerPadding:(CGFloat)padding;

@end

NS_ASSUME_NONNULL_END
