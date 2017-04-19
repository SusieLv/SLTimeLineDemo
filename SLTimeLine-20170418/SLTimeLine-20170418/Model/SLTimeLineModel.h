//
//  SLTimeLineModel.h
//  SLTimeLine-20170418
//
//  Created by 盼 on 2017/4/19.
//  Copyright © 2017年 pan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLTimeLineModel : NSObject
/**时间*/
@property (nonatomic,copy) NSString * time;
/**消息内容 */
@property (nonatomic,copy) NSString * msg;
/**图片地址没有的话为空 */
@property (nonatomic,copy) NSString * img;
/** 是否展开 */
@property (nonatomic,assign) BOOL isOpen;
@end
