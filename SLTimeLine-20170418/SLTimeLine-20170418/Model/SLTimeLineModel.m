//
//  SLTimeLineModel.m
//  SLTimeLine-20170418
//
//  Created by 盼 on 2017/4/19.
//  Copyright © 2017年 pan. All rights reserved.
//

#import "SLTimeLineModel.h"

@implementation SLTimeLineModel
+ (instancetype)initModelWithDict:(NSDictionary *)dict
{
    SLTimeLineModel * timeLine = [[SLTimeLineModel alloc] init];
    [timeLine setValuesForKeysWithDictionary:dict];
    
    return timeLine;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
