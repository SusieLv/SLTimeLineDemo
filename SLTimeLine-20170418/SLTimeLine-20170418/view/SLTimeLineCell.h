//
//  SLTimeLineCell.h
//  SLTimeLine-20170418
//
//  Created by 盼 on 2017/4/18.
//  Copyright © 2017年 pan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLDataProvider.h"

typedef void(^SLOpenBlock)(BOOL isOpen);
@interface SLTimeLineCell : UITableViewCell<SLDataProvider>
/** 展开／收起全文 */
@property (nonatomic,copy) SLOpenBlock openBlock;

+(CGFloat)calculateHeight:(id)data;
@end
