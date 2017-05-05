//
//  NSString+LDExtention.m
//  AMAP3DDemo
//
//  Created by Lidear on 15/11/12.
//  Copyright © 2015年 zhuang. All rights reserved.
//

#define operation_abc_str @"A B C D E F G H I J K L N M O P Q R S T U V W X Y Z"

#import "NSString+LDExtention.h"
#import <AdSupport/AdSupport.h>

@implementation NSString (LDExtention)

- (BOOL)isPhone {
    NSString *mobile = @"^(1[358]\\d{9})$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobile];
    
    if ([pred evaluateWithObject:self]) {
        return YES;
    } else {
        return NO;
    }
}


- (CGSize)boundingSizeForNormalStringWithSize:(CGSize)size withFont:(UIFont *)font
{
    CGSize textSize = CGSizeZero;
    if (font && self.length > 0) {
        textSize = [self boundingRectWithSize:size
                                      options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                   attributes:@{NSFontAttributeName : font}
                                      context:nil].size;
    }
    return textSize;
}


- (BOOL)validatePhoneNumber
{
    if ([self length] != 11) {
        return NO;
    }
    NSString *regEx = @"\\d{11}";
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF matches %@", regEx];
    return [regExPredicate evaluateWithObject:self];
}

- (BOOL)validateEmail
{
    BOOL email = NO;
    if (self.length > 0) {
        NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
        email = [emailTest evaluateWithObject:self];
    }
    return email;
}

- (BOOL)validatePassword
{
    BOOL password = NO;
    if (self.length > 0) {
        NSString *passWordRegex = @"^[a-zA-Z0-9]{6,15}+$";
        NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
        password = [passWordPredicate evaluateWithObject:self];
    }
    return password;
}


- (NSURL *)ldUrl
{
    NSURL *url = nil;
    if (self.length > 0) {
        url = [NSURL URLWithString:self];
    }
    return url;
}


- (NSString *)URLEncodedStringWithCFStringEncoding:(CFStringEncoding)encoding
{
    NSString *encodingStrign = nil;
    if (self.length > 0) {
        encodingStrign = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)[self mutableCopy], NULL, CFSTR("￼=,!$&'()*+;@?\n\"<>#\t :/"), encoding);
    }
    return encodingStrign;
}

- (NSString *)URLEncodedString
{
    return [self URLEncodedStringWithCFStringEncoding:kCFStringEncodingUTF8];
}



+ (NSString *)getABCbyIndex:(NSInteger)index
{
    NSString *abc;
    NSArray *abcArr = [operation_abc_str componentsSeparatedByString:@" "];
    if (index < abcArr.count && index >= 0) {
        abc = abcArr[index];
    }
    return abc;
}

- (NSMutableAttributedString *)attributedStringFromStingWithFont:(UIFont *)font withLineSpacing:(CGFloat)lineSpacing
{
    
    return [self attributedStringFromStingWithFont:font withLineSpacing:lineSpacing headIndent:0];
}

- (NSMutableAttributedString *)attributedStringFromStingWithFont:(UIFont *)font withLineSpacing:(CGFloat)lineSpacing headIndent:(CGFloat)indent
{
    NSMutableAttributedString *attributedStr = nil;
    if (font && self.length > 0) {
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0) {
            
            attributedStr = [[NSMutableAttributedString alloc] initWithString:self attributes:@{NSFontAttributeName : font}];
            
            NSMutableParagraphStyle *paragraphStyle = [self paragraphWithLineSpacing:lineSpacing headIndent:indent];
            
            [attributedStr addAttribute:NSParagraphStyleAttributeName
                                  value:paragraphStyle
                                  range:NSMakeRange(0, [self length])];
        }
    }
    return attributedStr;
}

- (NSMutableParagraphStyle *)paragraphWithLineSpacing:(CGFloat)lineSpacing headIndent:(CGFloat)indent
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    [paragraphStyle setFirstLineHeadIndent:indent];
    
    return paragraphStyle;
}


- (CGSize)boundingRectWithSize:(CGSize)size withTextFont:(UIFont *)font withLineSpacing:(CGFloat)lineSpacing headIndent:(CGFloat)indent
{
    CGSize textSize = CGSizeZero;
    if (font && self.length > 0) {
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0) {
            NSMutableAttributedString *attributedText = [self attributedStringFromStingWithFont:font withLineSpacing:lineSpacing headIndent:indent];
            textSize = [attributedText boundingRectWithSize:size
                                                    options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                    context:nil].size;
        } else {
            textSize = [self boundingSizeForNormalStringWithSize:size withFont:font];
        }
    }
    return textSize;
}

- (CGSize)boundingRectWithSize:(CGSize)size withTextFont:(UIFont *)font withLineSpacing:(CGFloat)lineSpacing
{
    return [self boundingRectWithSize:size withTextFont:font withLineSpacing:lineSpacing headIndent:0];
}

- (NSMutableDictionary *)getURLParameters {
    
    // 查找参数
    NSRange range = [self rangeOfString:@"?"];
    if (range.location == NSNotFound) {
        return nil;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    // 截取参数
    NSString *parametersString = [self substringFromIndex:range.location + 1];
    
    // 判断参数是单个参数还是多个参数
    if ([parametersString containsString:@"&"]) {
        
        // 多个参数，分割参数
        NSArray *urlComponents = [parametersString componentsSeparatedByString:@"&"];
        
        for (NSString *keyValuePair in urlComponents) {
            // 生成Key/Value
            NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
            NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
            NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
            
            // Key不能为nil
            if (key == nil || value == nil) {
                continue;
            }
            
            id existValue = [params valueForKey:key];
            
            if (existValue != nil) {
                
                // 已存在的值，生成数组
                if ([existValue isKindOfClass:[NSArray class]]) {
                    // 已存在的值生成数组
                    NSMutableArray *items = [NSMutableArray arrayWithArray:existValue];
                    [items addObject:value];
                    
                    [params setValue:items forKey:key];
                } else {
                    
                    // 非数组
                    [params setValue:@[existValue, value] forKey:key];
                }
                
            } else {
                
                // 设置值
                [params setValue:value forKey:key];
            }
        }
    } else {
        // 单个参数
        
        // 生成Key/Value
        NSArray *pairComponents = [parametersString componentsSeparatedByString:@"="];
        
        // 只有一个参数，没有值
        if (pairComponents.count == 1) {
            return nil;
        }
        
        // 分隔值
        NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
        NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
        
        // Key不能为nil
        if (key == nil || value == nil) {
            return nil;
        }
        
        // 设置值
        [params setValue:value forKey:key];
    }
    
    return params;
}

- (BOOL)isBlankString{
    if (self == nil || self == NULL) {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

@end
