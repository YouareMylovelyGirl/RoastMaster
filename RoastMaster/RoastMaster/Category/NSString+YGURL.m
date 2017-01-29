//
//  NSString+YGURL.m
//  RoastMaster
//
//  Created by 阳光 on 2017/1/25.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "NSString+YGURL.h"

@implementation NSString (YGURL)
- (NSURL *)yg_url
{
    return [NSURL URLWithString:self];
}
@end
