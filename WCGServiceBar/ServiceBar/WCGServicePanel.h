//
//  WCGServicePanel.h
//  WCGServiceBar
//
//  Created by Wcg on 2017/5/3.
//  Copyright © 2017年 Wcg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+LDExtention.h"
@class WCGServicePanel;

@protocol WCGServicePanelDelegate <NSObject>

- (void)didClickPanel:(WCGServicePanel *)panel atRow:(NSInteger)row;

@end

@interface WCGServicePanel : UIView

//**代理*/
@property (nonatomic, weak) id<WCGServicePanelDelegate> delegate;
//**数据源*/
@property(nonatomic,strong) NSArray *subMenuArr;

/**panelWidth */
@property(nonatomic,assign) CGFloat panelWidth;
@property(nonatomic,assign) CGFloat panelHeight;

@end
