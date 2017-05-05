//
//  WCGServiceBar.h
//  WCGServiceBar
//
//  Created by Wcg on 2017/5/2.
//  Copyright © 2017年 Wcg. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WCGServiceBar;

//**暂时未用*/
@protocol WCGServiceBarDataSource <NSObject>

- (NSInteger)serviceBarNumOfSections:(WCGServiceBar *)bar;
- (NSArray *)serviceBarSectionTitlesArr:(WCGServiceBar *)bar;

- (NSInteger)serviceBar:(WCGServiceBar *)bar numOfRowInSection:(NSInteger)section;
- (NSString *)serviceBar:(WCGServiceBar *)bar titleForIndexPath:(NSIndexPath *)indexPath;


@end

@protocol WCGserviceBarDelegate <NSObject>

- (void)didClickKeyBoradBtn:(WCGServiceBar *)bar btn:(UIButton *)btn;

- (void)didSelectedMenuInSection:(NSInteger)section row:(NSInteger)row;

@optional
- (void)didShowKeyBoradBtn:(WCGServiceBar *)bar;

- (void)didHiddenKeyBoradBtn:(WCGServiceBar *)bar;

@end


@interface WCGServiceBar : UIView

//**数据源代理*/
@property (nonatomic, weak) id<WCGServiceBarDataSource> dataSource;
@property (nonatomic, weak) id<WCGserviceBarDelegate> delegate;

//**菜单数据模型*/
@property(nonatomic,strong) NSArray *menuArr;

+ (instancetype)serviceBarWithMenuArr:(NSArray *)menuArr;

- (void)hiddenSubMenu;

- (void)hiddenToolBar;
- (void)showToolBar;


@end
