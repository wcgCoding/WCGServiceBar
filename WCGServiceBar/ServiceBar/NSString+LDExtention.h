//
//  NSString+LDExtention.h
//  AMAP3DDemo
//
//  Created by Lidear on 15/11/12.
//  Copyright © 2015年 zhuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LDExtention)

//  是否是电话判断
- (BOOL)isPhone;

/**
 *  计算文本宽度和高度
 *  @params
 *      size    指定大小
 *  @params
 *      font    font
 */
- (CGSize)boundingSizeForNormalStringWithSize:(CGSize)size withFont:(UIFont *)font;

/**
 *  计算文本宽度和高度
 *  @params
 *      size    指定大小
 *  @params
 *      font    font
 *  @params
 *      lineSpacing 行间距
 */
- (CGSize)boundingRectWithSize:(CGSize)size withTextFont:(UIFont *)font withLineSpacing:(CGFloat)lineSpacing;


/**
 *  11位，数字，（电话号码，021-12345678, 02112345678, 0550-1234567, 05501234567, 18621957390）
 */
- (BOOL)validatePhoneNumber;

/**
 *  邮箱检测
 */
- (BOOL)validateEmail;

/**
 *  密码
 */
- (BOOL)validatePassword;

/**
 *  转换 URL
 */
- (NSURL *)ldUrl;

/**
 *  url encode
 */
- (NSString *)URLEncodedString;


/**
 *  传入下标,获取26个字母之一
 */
+ (NSString *)getABCbyIndex:(NSInteger)index;


/**
 *  sting转AttributedString
 *  @params
 *      font    font
 *  @params
 *      lineSpacing 行间距
 */
- (NSMutableAttributedString *)attributedStringFromStingWithFont:(UIFont *)font withLineSpacing:(CGFloat)lineSpacing;

/**
 *
 */
- (NSMutableParagraphStyle *)paragraphWithLineSpacing:(CGFloat)lineSpacing headIndent:(CGFloat)indent;

/**
 *  获取url中的相关参数
 */
- (NSMutableDictionary *)getURLParameters;

/**
 *  是否空字符串
 */
- (BOOL)isBlankString;
@end
