//
//  SLTimeLineCell.m
//  SLTimeLine-20170418
//
//  Created by 盼 on 2017/4/18.
//  Copyright © 2017年 pan. All rights reserved.
//

#import "SLTimeLineCell.h"
#import "SLTimeLineModel.h"

@interface SLTimeLineCell ()
/** timeLine */
@property (nonatomic,strong) SLTimeLineModel * timeLine;
@end

@implementation SLTimeLineCell
{
    UIImageView * _timeIcon;
    UILabel     * _timeLabel;
    UILabel     * _textLabel;
    UIView      * _lineView;
    UIButton    * _openButton;
    UIImageView * _picImage;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
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
//        _textLabel.backgroundColor = [UIColor greenColor];
        _textLabel.numberOfLines = 0;
        [self.contentView addSubview:_textLabel];
        
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(kIPhone6Scale(20)+6.5, CGRectGetMaxY(_timeIcon.frame)+5, 0.5, 0)];
        _lineView.backgroundColor = SLSetColor(230, 230, 230);
        [self.contentView addSubview:_lineView];
        
        _openButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _openButton.frame = CGRectMake(CGRectGetMinX(_textLabel.frame), 0, 50, 14);
        [_openButton setTitle:@"展开" forState:UIControlStateNormal];
        [_openButton setImage:[UIImage imageNamed:@"open_icon"] forState:UIControlStateNormal];
        [_openButton setTitleColor:SLSetColor(80, 140, 238) forState:UIControlStateNormal];
        _openButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_openButton addTarget:self action:@selector(showAll) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_openButton];
        
        _picImage = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_textLabel.frame), 0, kIPhone6Scale(100), kIPhone6Scale(100))];
        [self.contentView addSubview:_picImage];
        
    }
    return self;
}

- (void)fillData:(id)data
{
    SLTimeLineModel * timeLine = (SLTimeLineModel *)data;
    self.timeLine = timeLine;
    
    _timeLabel.text = timeLine.time;
    
    CGFloat timeWidth = [self boundingRectWithWidth:CGFLOAT_MAX withTextFont:[UIFont systemFontOfSize:13] withLineSpacing:5 text:timeLine.time].width;
    _timeLabel.frame = CGRectMake(CGRectGetMaxX(_timeIcon.frame) + 8, CGRectGetMinY(_timeIcon.frame), timeWidth, 13);
    
    UIFont * contentFont = [UIFont systemFontOfSize:16];
    CGFloat contentHeight = [self boundingRectWithWidth:Screen_Width - kIPhone6Scale(56) withTextFont:contentFont withLineSpacing:5 text:timeLine.msg].height;
    
    //最多显示7行
    if (contentHeight > (contentFont.lineHeight*7+6*5))
    {
        //超过七行有展开/收起
        _openButton.hidden = NO;
        if (timeLine.isOpen)
        {
            contentHeight = [self boundingRectWithWidth:Screen_Width - kIPhone6Scale(56) withTextFont:contentFont withLineSpacing:5 text:timeLine.msg].height;
            _lineView.frame = CGRectMake(kIPhone6Scale(20)+6.5, CGRectGetMaxY(_timeIcon.frame)+5, 0.5, contentHeight + 22 + 10+14+14);
            [_openButton setTitle:@"收起" forState:UIControlStateNormal];
            [_openButton setImage:[UIImage imageNamed:@"close_icon"] forState:UIControlStateNormal];
            
        }else
        {
            contentHeight = contentFont.lineHeight*7+6*5;
            _lineView.frame = CGRectMake(kIPhone6Scale(20)+6.5, CGRectGetMaxY(_timeIcon.frame)+5, 0.5, contentHeight + 22 + 10 + 14+14);
            [_openButton setTitle:@"展开" forState:UIControlStateNormal];
            [_openButton setImage:[UIImage imageNamed:@"open_icon"] forState:UIControlStateNormal];
        }
        _textLabel.frame = CGRectMake(kIPhone6Scale(40), CGRectGetMaxY(_timeLabel.frame) + 16, Screen_Width - kIPhone6Scale(56), contentHeight);
        _openButton.frame = CGRectMake(CGRectGetMinX(_textLabel.frame), CGRectGetMaxY(_textLabel.frame)+14, 50, 14);
        
    }else
    {
        //不足七行
        _openButton.hidden = YES;
        contentHeight = [self boundingRectWithWidth:Screen_Width - kIPhone6Scale(56) withTextFont:contentFont withLineSpacing:5 text:timeLine.msg].height;
        _textLabel.frame = CGRectMake(kIPhone6Scale(40), CGRectGetMaxY(_timeLabel.frame) + 16, Screen_Width - kIPhone6Scale(56), contentHeight);
        
        //只有一行的时候底部有白色空白
        NSInteger rowNum = contentHeight/contentFont.lineHeight;
        NSLog(@"%ld",(long)rowNum);
        if (rowNum == 1) {
            _lineView.frame = CGRectMake(kIPhone6Scale(20)+6.5, CGRectGetMaxY(_timeIcon.frame)+5, 0.5, contentHeight + 22 + 5);
        }else
        {
            _lineView.frame = CGRectMake(kIPhone6Scale(20)+6.5, CGRectGetMaxY(_timeIcon.frame)+5, 0.5, contentHeight + 22 + 10);
        }
    }

    _textLabel.attributedText = [self getAttributedStringFromStingWithFont:contentFont withLineSpacing:5 text:timeLine.msg];
    
    if ([timeLine.img isEqualToString:@""] || timeLine.img==nil) {
        _picImage.hidden = YES;
    }else
    {
        _picImage.hidden = NO;
    }
}

- (void)showAll
{
    self.timeLine.isOpen = !self.timeLine.isOpen;
    
    if (self.openBlock) {
        self.openBlock(self.timeLine.isOpen);
    }
}

+ (CGFloat)calculateHeight:(id)data
{
    SLTimeLineModel * timeLine = (SLTimeLineModel *)data;
    CGFloat height = 0;
    height += 23;
    
    UIFont * contentFont = [UIFont systemFontOfSize:16];
    CGFloat contentHeight = [self boundingRectWithWidth:Screen_Width - kIPhone6Scale(56) withTextFont:contentFont withLineSpacing:5 text:timeLine.msg].height;
    
    if (contentHeight > (contentFont.lineHeight*7+6*5))
    {
        //超过七行有展开/收起
        if (timeLine.isOpen)
        {
            contentHeight = [self boundingRectWithWidth:Screen_Width - kIPhone6Scale(56) withTextFont:contentFont withLineSpacing:5 text:timeLine.msg].height;
            height += contentHeight + 22 + 10 + 14 + 14;
            
        }else
        {
            contentHeight = contentFont.lineHeight*7+6*5;
            height += contentHeight + 22 + 10 + 14+14;
        }
        
    }else
    {
        //不足七行
        contentHeight = [self boundingRectWithWidth:Screen_Width - kIPhone6Scale(56) withTextFont:contentFont withLineSpacing:5 text:timeLine.msg].height;
        
        //只有一行的时候底部有白色空白
        NSInteger rowNum = contentHeight/contentFont.lineHeight;
        if (rowNum == 1) {
            height += contentHeight + 22 + 5;
        }else
        {
            height += contentHeight + 22 + 10;
        }
    }

    return height;
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
 *  根据文字内容动态计算UILabel宽高
 *  @param maxWidth label宽度
 *  @param font  字体
 *  @param lineSpacing  行间距
 *  @param text  内容
 */
+(CGSize)boundingRectWithWidth:(CGFloat)maxWidth
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
