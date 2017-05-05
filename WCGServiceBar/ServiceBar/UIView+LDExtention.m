//
//  UIView+LDExtention.m
//  AMAP3DDemo
//
//  Created by admin on 15/11/10.
//  Copyright © 2015年 zhuang. All rights reserved.
//

#import "UIView+LDExtention.h"

@implementation UIView (LDExtention)


// 获取和设置x坐标
- (CGFloat)viewX
{
    CGRect frame = self.frame;
    return frame.origin.x;
}

- (void)setViewX:(CGFloat)xPoint
{
    CGRect frame = self.frame;
    frame.origin.x = xPoint;
    self.frame = frame;
}

// 获取和设置y坐标
- (CGFloat)viewY
{
    CGRect frame = self.frame;
    return frame.origin.y;
}

- (void)setViewY:(CGFloat)yPoint
{
    CGRect frame = self.frame;
    frame.origin.y = yPoint;
    self.frame = frame;
}

// 获取和设置width
- (CGFloat)viewWidth
{
    CGRect frame = self.frame;
    return frame.size.width;
}

- (void)setViewWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

// 获取和设置height
- (CGFloat)viewHeight
{
    CGRect frame = self.frame;
    return frame.size.height;
}

- (void)setViewHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

// 获取和设置origin
- (CGPoint)viewOrigin
{
    CGRect frame = self.frame;
    return frame.origin;
}

- (void)setViewOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

// 获取和设置size
- (CGSize)viewSize
{
    CGRect frame = self.frame;
    return frame.size;
}

- (void)setViewSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

// 获取view的最右边的x值
-(CGFloat)viewXRight
{
    CGRect frame = self.frame;
    return frame.origin.x + frame.size.width;
}

// 获取view的最下边的y值
-(CGFloat)viewYBelow
{
    CGRect frame = self.frame;
    return frame.origin.y + frame.size.height;
}

//  ---
//  与一个view的y轴对齐
- (void)centerYalignView:(UIView *)view
{
    CGPoint center = self.center;
    center.y = view.center.y;
    self.center = center;
}

- (void)centerXalignView:(UIView *)view
{
    CGPoint center = self.center;
    center.x = view.center.x;
    self.center = center;
}

// 增加y坐标
- (void)addViewY:(CGFloat)yPoint
{
    CGRect frame = self.frame;
    frame.origin.y = yPoint + self.frame.origin.y;
    self.frame = frame;
}


-(void) showBorderWithColor:(UIColor*)color{
#ifdef DEBUG
    self.layer.borderWidth = 1;
    self.layer.borderColor = color.CGColor;
#endif
}


+ (UIView *)extractFromXib
{
    NSString* viewName = NSStringFromClass([self class]);
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:viewName owner:nil options:nil];
    Class   targetClass = NSClassFromString(viewName);
    
    for (UIView *view in views) {
        if ([view isMemberOfClass:targetClass]) {
            return view;
        }
    }
    
    return nil;
}

-(void)removeAllSubView
{
    NSArray *arraySubView = [NSArray arrayWithArray:self.subviews];
    for(UIView *subView in arraySubView)
    {
        if(subView.subviews.count != 0)
        {
            [subView removeAllSubView];
        }
        [subView removeFromSuperview];
    }
}

-(void)moveRightToParentWithPadding:(CGFloat) padding{
    if (self.superview == nil) {
        return;
    }
    
    CGRect myFrame = self.frame;
    myFrame.origin.x = self.superview.frame.size.width - myFrame.size.width - padding;
    
    self.frame = myFrame;
}

-(void)centerVertically{
    if (self.superview == nil) {
        return;
    }
    
    CGRect myFrame = self.frame;
    myFrame.origin.y = (self.superview.frame.size.height - myFrame.size.height)/2;
    self.frame = myFrame;
}

-(void)centerHorizontally{
    if (self.superview == nil) {
        return;
    }
    
    CGRect myFrame = self.frame;
    myFrame.origin.x = (self.superview.frame.size.width - myFrame.size.width)/2;
    self.frame = myFrame;
}

-(void)setupAccessibility:(NSString *)accessibilityLabel{
    self.accessibilityIdentifier = accessibilityLabel;
}

+ (CGFloat)convert320Scale:(CGFloat)width
{
    return width * WCGScreenWidth / 320.0f;
}

@end
