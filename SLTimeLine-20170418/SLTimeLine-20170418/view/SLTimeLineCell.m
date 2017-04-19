//
//  SLTimeLineCell.m
//  SLTimeLine-20170418
//
//  Created by 盼 on 2017/4/18.
//  Copyright © 2017年 pan. All rights reserved.
//

#import "SLTimeLineCell.h"
#import "SLTimeLineModel.h"

@implementation SLTimeLineCell
{
    UIImageView * _timeIcon;
    UILabel     * _timeLabel;
    UILabel     * _textLabel;
    UIView      * _lineView;
    UIButton    * _openButton;
    UIImageView * _picImage;
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
        [self.contentView addSubview:_openButton];
        
        _picImage = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_textLabel.frame), 0, kIPhone6Scale(100), kIPhone6Scale(100))];
        [self.contentView addSubview:_picImage];
        
    }
    return self;
}

- (void)showAll
{
    
}

- (void)fillData:(id)data
{
    SLTimeLineModel * timeLine = (SLTimeLineModel *)data;
    
    _timeLabel.text = timeLine.time;
    
    CGFloat timeWidth = [self boundingRectWithWidth:CGFLOAT_MAX withTextFont:[UIFont systemFontOfSize:13] withLineSpacing:5 text:timeLine.time].width;
    _timeLabel.frame = CGRectMake(CGRectGetMaxX(_timeIcon.frame) + 8, CGRectGetMinY(_timeIcon.frame), timeWidth, 13);
    
    UIFont * contentFont = [UIFont systemFontOfSize:16];
    CGFloat contentHeight = [self boundingRectWithWidth:Screen_Width - kIPhone6Scale(56) withTextFont:contentFont withLineSpacing:5 text:timeLine.msg].height;
    
    //最多显示7行
    if (contentHeight > (contentFont.lineHeight*7+6*5))
    {
      contentHeight = contentFont.lineHeight*7+6*5;
    }else
    {
        
    }         
    _textLabel.frame = CGRectMake(kIPhone6Scale(40), CGRectGetMaxY(_timeLabel.frame) + 16, Screen_Width - kIPhone6Scale(56), contentHeight);
    _textLabel.attributedText = [self getAttributedStringFromStingWithFont:contentFont withLineSpacing:5 text:timeLine.msg];
    
    _lineView.frame = CGRectMake(_timeIcon.center.x, CGRectGetMaxY(_timeIcon.frame)+5, 1, 0);
}

/**
 *  根据文字内容动态计算UILabel宽高
 *  @param maxWidth label宽度
 *  @param font  字体
 *  @param lineSpacing  行间距
 *  @param text  内容
 */
-(CGSize)boundingRectWithWidth:(CGFloat)maxWidth
                  withTextFont:(UIFont *)font
               withLineSpacing:(CGFloat)lineSpacing
                          text:(NSString *)text{
    CGSize maxSize = CGSizeMake(maxWidth, CGFLOAT_MAX);
    //段落样式
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //设置行间距
    [paragraphStyle setLineSpacing:lineSpacing];
    //#warning 此处设置NSLineBreakByTruncatingTail会导致计算文字高度方法失效
    //    [paragraphStyle setLineBreakMode:NSLineBreakByTruncatingTail];
    
    //计算文字尺寸
    CGSize size = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle} context:nil].size;
    return size;
}

/**
 *  NSString转换成NSMutableAttributedString
 *  @param font  字体
 *  @param lineSpacing  行间距
 *  @param text  内容
 */
-(NSMutableAttributedString *)getAttributedStringFromStingWithFont:(UIFont *)font
                                                withLineSpacing:(CGFloat)lineSpacing
                                                           text:(NSString *)text{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:font}];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    [paragraphStyle setLineBreakMode:NSLineBreakByTruncatingTail]; //截断方式，"abcd..."
    [attributedStr addAttribute:NSParagraphStyleAttributeName
                          value:paragraphStyle
                          range:NSMakeRange(0, [text length])];
    return attributedStr;
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
