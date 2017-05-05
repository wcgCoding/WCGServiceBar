//
//  ViewController.m
//  WCGServiceBar
//
//  Created by Wcg on 2017/5/5.
//  Copyright © 2017年 吴朝刚. All rights reserved.
//

#import "ViewController.h"
#import "WCGServiceBar.h"
#import <Masonry.h>

@interface ViewController ()<WCGserviceBarDelegate>

@property (weak, nonatomic) IBOutlet UIView *chatToolBar;

//**服务号菜单栏*/
@property(nonatomic,strong) WCGServiceBar *serviceBar;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.serviceBar = [WCGServiceBar serviceBarWithMenuArr:@[@"主菜单0",@"主菜单1",@"主菜单2"]];
    self.serviceBar.delegate = self;
    [self.view addSubview:self.serviceBar];
    [self.serviceBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(WCGServiceBarHeight);
        make.left.right.bottom.mas_equalTo(self.view);
    }];
}

- (IBAction)btnClickAction:(id)sender {
    
    //隐藏自己的chatToolBar
    [UIView animateWithDuration:0.15 animations:^{
       
        self.chatToolBar.viewY = WCGScreenHeight;
    } completion:^(BOOL finished) {
        
    }];
    
    [self.serviceBar showToolBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - WCGserviceBarDelegate
- (void)didClickKeyBoradBtn:(WCGServiceBar *)bar btn:(UIButton *)btn{
    
    [self.serviceBar hiddenToolBar];
    
    [UIView animateWithDuration:0.15 animations:^{
        
        self.chatToolBar.viewY = WCGScreenHeight - WCGServiceBarHeight;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)didSelectedMenuInSection:(NSInteger)section row:(NSInteger)row{
    NSLog(@"didSelected---> section%ld, row%ld",section,row);
}


@end
