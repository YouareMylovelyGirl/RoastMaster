//
//  NSObject+Parse.h
//  RoastMaster
//
//  Created by 阳光 on 2017/1/25.
//  Copyright © 2017年 YG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Parse)<YYModel>
+ (id)Parse:(id)JSON;
@end
