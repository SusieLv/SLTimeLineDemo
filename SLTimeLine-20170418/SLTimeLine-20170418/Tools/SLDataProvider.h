//
//  SLDataProvider.h
//  SLTimeLine-20170418
//
//  Created by 盼 on 2017/4/19.
//  Copyright © 2017年 pan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SLDataProvider <NSObject>

@optional
- (void)fillData:(id)data;

@end
