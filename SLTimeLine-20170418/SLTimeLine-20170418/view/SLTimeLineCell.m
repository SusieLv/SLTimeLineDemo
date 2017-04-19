//
//  SLTimeLineCell.m
//  SLTimeLine-20170418
//
//  Created by 盼 on 2017/4/18.
//  Copyright © 2017年 pan. All rights reserved.
//

#import "SLTimeLineCell.h"

@implementation SLTimeLineCell
{
    UIImageView * _timeIcon;
    UILabel     * _timeLabel;
    UILabel     * _textLabel;
    UIView      * _lineView;
    UIButton    * _openButton;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _timeIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"time_tag"]];
        _timeIcon.frame = CGRectMake(kIPhone6Scale(20), 5, 13, 13);
        [self.contentView addSubview:_timeIcon];
        
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_timeIcon.frame) + 8, CGRectGetMinY(_timeIcon.frame), 0, 13)];
        _timeLabel.font = [UIFont systemFontOfSize:13];
        _timeLabel.textColor = SLSetColor(153, 153, 153);
        [self.contentView addSubview:_timeLabel];
        
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(kIPhone6Scale(40), CGRectGetMaxY(_timeLabel.frame) + 16, Screen_Width - kIPhone6Scale(56), 0)];
        _textLabel.font = [UIFont systemFontOfSize:16];
        _textLabel.textColor = SLSetColor(34, 34, 34);
        [self.contentView addSubview:_textLabel];
        
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(_timeIcon.center.x, CGRectGetMaxY(_timeIcon.frame)+5, 1, 0)];
        _lineView.backgroundColor = SLSetColor(153, 153, 153);
        [self.contentView addSubview:_lineView];
        
        _openButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _openButton.frame = CGRectMake(CGRectGetMinX(_textLabel.frame), 0, 10, 5);
        [_openButton setImage:[UIImage imageNamed:@"展开icon"] forState:UIControlStateNormal];
        [_openButton addTarget:self action:@selector(showAll) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

- (void)showAll
{
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
