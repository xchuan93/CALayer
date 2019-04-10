//
//  ViewController.m
//  XCCAShaperLayer
//
//  Created by xchuan on 2019/4/8.
//  Copyright © 2019年 xchuan. All rights reserved.
//

#import "ViewController.h"
#import "RoundProgressController.h"
#import "RectController.h"
#import "BrokenLineController.h"
#import "DottedLineViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *itemArr;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (NSMutableArray *)itemArr {
    if (!_itemArr) {
        _itemArr = @[@"圆形进度条",@"矩形",@"折线",@"虚线"].mutableCopy;
    }
    return _itemArr;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}

#pragma mark UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.itemArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellInder = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellInder];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellInder];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = self.itemArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.itemArr[indexPath.row] isEqualToString:@"圆形进度条"]) {
        RoundProgressController *vc = [[RoundProgressController alloc] init];
        vc.view.frame = self.view.bounds;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([self.itemArr[indexPath.row] isEqualToString:@"矩形"]){
        RectController *vc = [RectController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([self.itemArr[indexPath.row] isEqualToString:@"折线"]){
        BrokenLineController *vc = [BrokenLineController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([self.itemArr[indexPath.row] isEqualToString:@"虚线"]){
        DottedLineViewController *vc = [DottedLineViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


@end
