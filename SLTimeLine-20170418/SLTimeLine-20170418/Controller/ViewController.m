//
//  ViewController.m
//  SLTimeLine-20170418
//
//  Created by 盼 on 2017/4/18.
//  Copyright © 2017年 pan. All rights reserved.
//

#import "ViewController.h"
#import "SLTimeLineCell.h"
#import "SLTimeLineModel.h"
#define TimeCell @"TimeCell"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
/** tableView */
@property (nonatomic,strong) UITableView * myTableView;
/** 数据源 */
@property (nonatomic,strong) NSMutableArray * dataList;
@end

@implementation ViewController

- (UITableView *)myTableView
{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height) style:UITableViewStylePlain];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _myTableView;
}

- (NSMutableArray *)dataList
{
    if (!_dataList) {
        _dataList = [NSMutableArray array];
        NSString * filePath = [[NSBundle mainBundle] pathForResource:@"content.json" ofType:nil];
        //转换成NSData类型的数据
        NSData * data = [NSData dataWithContentsOfFile:filePath];
        //序列化
        NSArray * dataArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];;
        for (NSDictionary * dataDict in dataArray) {
            SLTimeLineModel * timeLine = [SLTimeLineModel initModelWithDict:dataDict];
            [_dataList addObject:timeLine];
        }
    }
    return _dataList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setUpUI];
    [self.myTableView registerClass:[SLTimeLineCell class] forCellReuseIdentifier:TimeCell];
}

- (void)setUpUI
{
    [self.view addSubview:self.myTableView];
}

#pragma mark - UITableView Delagate DataSource Method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLTimeLineCell * timeLineCell = [tableView dequeueReusableCellWithIdentifier:TimeCell];
    SLTimeLineModel * timeLine = self.dataList[indexPath.row];
    [timeLineCell fillData:timeLine];
    [timeLineCell setOpenBlock:^(BOOL isOpen){
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    
    return timeLineCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLTimeLineModel * timeLine = self.dataList[indexPath.row];
    return [SLTimeLineCell calculateHeight:timeLine];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
