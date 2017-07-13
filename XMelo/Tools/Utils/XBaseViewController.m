//
//  XBaseViewController.m
//  XMelo
//
//  Created by X.Melo on 2017/7/13.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "XBaseViewController.h"

@interface XBaseViewController ()

@end

@implementation XBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.navigationItem.title = @"这里是标题";
    
    self.tableStyle = UITableViewStyleGrouped;
    self.cellStyle = UITableViewCellStyleDefault;
    
    self.tableView = ({
        UITableView *theTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:self.tableStyle];
        theTable.delegate = self;
        theTable.dataSource = self;
        [self.view addSubview:theTable];
        theTable;
    });
    
    //隐藏多余的cell
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.numberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.numberOfRowsInSection) {
        return self.numberOfRowsInSection(section);
    }else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat rowHeight = 0;
    
    if (self.heightForRowAtIndexPath) {
        rowHeight = self.heightForRowAtIndexPath(indexPath);
    } else {
        rowHeight = self.tableView.rowHeight;
    }
    return rowHeight;
}

- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (self.heightForHeadrAtIndexPath) {
        return self.heightForHeadrAtIndexPath(section);
    } else {
        return 10.f;
    }
}

- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section {
    
    if (self.heightForFooterAtIndexPath) {
        return self.heightForFooterAtIndexPath(section);
    } else {
        return CGFLOAT_MIN;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.didSelectRowAtIndexPath) {
        self.didSelectRowAtIndexPath(indexPath);
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.cellForRowAtIndexPath) {
        return self.cellForRowAtIndexPath(tableView,indexPath);
    }else {
        NSString *identi = @"baseCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identi];
        if (!cell) {
            
            cell = [[UITableViewCell alloc]initWithStyle:self.cellStyle reuseIdentifier:identi];
            
        }

        return cell;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
