# CustomizeButton
Customizable Button which you can specify the location of images and titles
自定义按钮图片和标题的位置

> 项目中肯定会遇到需要自定义view的时候,这里不再赘述如何自定义view，今天来描述一下有些时候，我们需要微调的按钮的title以及图片的位置

#### 这里先来一张效果图：
![](https://upload-images.jianshu.io/upload_images/1241385-c5ad2224e0f65f5d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
可以看到，我们项目中这种基于系统的UI控件微调的还是比较多的，今天就来总结一下**按钮的这种定制**

首先，按钮是继承于`UIControl`的，`UIControl`有两个属性：
1. UIControlContentHorizontalAlignment
2. UIControlContentVerticalAlignment
从名字上就能很清楚的看出来属性的意思，**即contrl内容水平轴和竖直轴上内容的排列方式**
然后这两个属性有以下几种枚举类型：
[UIControlContentVerticalAlignmentCenter](dash-apple-api://load?request_key=hck3I76TGf)
[UIControlContentVerticalAlignmentTop](dash-apple-api://load?request_key=hccF_jDDu2)
[UIControlContentVerticalAlignmentBottom](dash-apple-api://load?request_key=hcIdraI-cl)
[UIControlContentVerticalAlignmentFill](dash-apple-api://load?request_key=hcCHWLRd8J)
**Horizontal轴类似**

UIButton默认展示的效果如下：
![](https://upload-images.jianshu.io/upload_images/1241385-891c2a75e7b3fb92.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

然后当我们修改了上述两个属性为：
```
button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
button.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
```
此时，就变为如下展示：
![](https://upload-images.jianshu.io/upload_images/1241385-2d0f1c39460127ff.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
因此可以看到，**UIControl的子类，都是可以通过`UIControlContentHorizontalAlignment`,`UIControlContentVerticalAlignment`两个属性微调控件位置的**。

#### 然后还有第二种：UIButton的属性(titleEdgeInsets, imageEdgeInsets)
我们都知道css的盒模型中，有一个外边距margin，内边距padding，
![css盒模型](https://upload-images.jianshu.io/upload_images/1241385-8dadc1f7030c9c6a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

同样的，iOS的view中也有类似的属性`layoutMargins `，因为参照系不同，所以可以理解为**iOS中margin类似于css中的padding**
同时苹果为了开发者更加方便的自定义button，又提供了几个属性，那就是UIButton的`contentEdgeInsets`, `titleEdgeInsets`和`imageEdgeInsets`。
contentEdgeInsets： 可以调整整个按钮内部内容的边距
titleEdgeInsets：只调整按钮上文字Label的位置
imageEdgeInsets：只调整按钮上图片ImageView的位置
所以，我们通过修改`titleEdgeInsets`和`imageEdgeInsets`也能达到调整位置的效果。

##### 原理很简单，以下就是代码实现：
```
//FXCustomizeButton.h
typedef NS_ENUM(NSUInteger, ImagePosition) {
ImagePositionLeft = 0,  //default
ImagePositionTop,
ImagePositionRight,
ImagePositionBottom,
};

@interface FXCustomizeButton : UIButton

+ (FXCustomizeButton *)buttonWithImagePosition:(ImagePosition)position innerPadding:(CGFloat)padding;

@end

```
只暴露了一个方法出来，第一个参数是枚举类型，用来设置图片的位置。第二个参数是图片和文字之间的间距，float类型。
```
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

```

还是给个[demo](https://github.com/WooNoah/CustomizeButton)吧，感觉有帮助了请给个star，靴靴您~
