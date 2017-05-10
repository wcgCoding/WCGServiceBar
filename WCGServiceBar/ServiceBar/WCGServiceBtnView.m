//
//  WCGServiceBtn.m
//  WCGServiceBar
//
//  Created by Wcg on 2017/5/2.
//  Copyright © 2017年 Wcg. All rights reserved.
//

#import "WCGServiceBtnView.h"
#import "WCGServicePanel.h"
#import "Masonry.h"

@interface WCGServiceBtnView()<WCGServicePanelDelegate>

//**背景图*/
@property(nonatomic,strong) UIView *backGroupImageView;

//**按钮*/
@property(nonatomic,strong) UIButton *btn;

@end

@implementation WCGServiceBtnView
#pragma mark - setter getter
- (WCGServicePanel *)panel{
    if (!_panel) {
        _panel = [[WCGServicePanel alloc] init];
        _panel.delegate = self;
    }
    return _panel;
}

- (UIButton *)btn{
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
        [_btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
        [_btn setContentMode:UIViewContentModeScaleAspectFit];
        _btn.titleLabel.font = WCGFont(15.0f);
        [_btn setTitleColor:WCGColorBlack forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

- (UIView *)backGroupImageView{
    if (!_backGroupImageView) {
        _backGroupImageView = [[UIImageView alloc] init];
        _backGroupImageView.backgroundColor = WCGColorGray;
    }
    return _backGroupImageView;
}

- (void)setSubMenus:(NSArray *)subMenus{
    _subMenus = subMenus;
    self.panel.subMenuArr = subMenus;
    if (subMenus.count > 0) {
        [_btn setImage:[UIImage imageNamed:@"chat_Menu"] forState:UIControlStateNormal];
    }
    [self insertSubview:self.panel atIndex:0];
    
    [self.panel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(WCGServiceBarHeight);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(self.panel.panelWidth, self.panel.panelHeight));
    }];
}

- (void)setTitle:(NSString *)title{
    
    _title = title;
    
    [_btn setTitle:title forState:UIControlStateNormal];
}

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    
    //设置背景图
    [self addSubview:self.backGroupImageView];
    [_backGroupImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(self).insets(UIEdgeInsetsZero);
    }];
    
    //设置按钮
    [self addSubview:self.btn];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.mas_equalTo(self).insets(UIEdgeInsetsZero);
    }];
}

#pragma mark - public
- (void)changeShowStatus:(void (^)(BOOL finished, BOOL isShowed))completion{
    if (_subMenus.count == 0) return;
    
    if (_isShowPanel) {
        [self hiddenPanel:^(BOOL finished) {
            if (completion) {
                completion(finished,NO);
            }
        }];
    }else{
        [self showPanel:^(BOOL finished) {
            if (completion) {
                completion(finished,YES);
            }
        }];
    }
}
- (void)showPanel:(void (^)(BOOL finished))completion{
    if (!_isShowPanel) {
        WCGWeakSelf
        [UIView animateWithDuration:0.15 animations:^{
            
            [weakSelf.panel mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.top.mas_equalTo(-weakSelf.panel.panelHeight - 10);
            }];
            
            [weakSelf layoutIfNeeded];
            
        } completion:^(BOOL finished) {
            
            _isShowPanel = YES;
            if (completion) {
                completion(finished);
            }
        }];
    }
}
- (void)hiddenPanel:(void (^)(BOOL finished))completion{
    if (_isShowPanel) {
        WCGWeakSelf
        [UIView animateWithDuration:0.15 animations:^{
            
            [weakSelf.panel mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.top.mas_equalTo(self).offset(WCGServiceBarHeight);
            }];
            
            [weakSelf layoutIfNeeded];
            
        } completion:^(BOOL finished) {
            
            _isShowPanel = NO;
            
            if (completion) {
                completion(finished);
            }
        }];
    }
}

#pragma mark - action
- (void)btnClick:(UIButton *)btn{
    if(self.delegate && [self.delegate respondsToSelector:@selector(didClickServiceBtnView:)]){
        [self.delegate didClickServiceBtnView:self];
    }
}

#pragma mark - WCGServicePanelDelegate
- (void)didClickPanel:(WCGServicePanel *)panel atRow:(NSInteger)row{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickServiceBtnView:subMenuRow:)]) {
        [self.delegate didClickServiceBtnView:self subMenuRow:row];
    }
    
    [self hiddenPanel:nil];
}

@end
