//
//  WCGServiceBtn.h
//  WCGServiceBar
//
//  Created by Wcg on 2017/5/2.
//  Copyright © 2017年 Wcg. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WCGServicePanel;
@class WCGServiceBtnView;

@protocol WCGServiceBtnViewDelegate <NSObject>

//点击了按钮本身
- (void)didClickServiceBtnView:(WCGServiceBtnView *)btnView;

//点击了按钮上子菜单
- (void)didClickServiceBtnView:(WCGServiceBtnView *)btnView subMenuRow:(NSInteger)row;

@end

@interface WCGServiceBtnView : UIView

//**panel*/
@property(nonatomic,strong) WCGServicePanel *panel;

/**是否显示Panel */
@property(nonatomic,assign) BOOL isShowPanel;

//**设置子菜单数据组*/
@property(nonatomic,strong) NSArray *subMenus;

//**标题*/
@property(nonatomic,strong) NSString *title;

//**代理*/
@property (nonatomic, weak) id<WCGServiceBtnViewDelegate> delegate;

//**更改panel的状态*/
- (void)changeShowStatus:(void (^)(BOOL finished,BOOL isShowed))completion;
- (void)hiddenPanel:(void (^)(BOOL finished))completion;
- (void)showPanel:(void (^)(BOOL finished))completion;

@end
