//
//  XCoreDataViewController.m
//  XMelo
//
//  Created by X.Melo on 2017/8/1.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "XCoreDataViewController.h"
#import "XSonModel+CoreDataClass.h"
#import "XSonModel+CoreDataProperties.h"


@interface XCoreDataViewController ()

@property (nonatomic, strong) NSMutableArray    *datas;
@property (nonatomic, strong) UITextField       *nameTF;
@property (nonatomic, strong) UITextField       *ageTF;
@property (nonatomic, strong) UITextField       *heightTF;

@end

@implementation XCoreDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"coreData";
    self.datas = [NSMutableArray arrayWithCapacity:0];
    self.tableView.rowHeight = 50;
    @kWeakSelf;
    
    
    [XManager addRightBarItemInViewController:self itemTitle:@"添加" andItemBlock:^(UIButton *aButton) {
        
        if ([selfWeak.nameTF.text isEqualToString:@""] ||
            [selfWeak.ageTF.text isEqualToString:@""] ||
            [selfWeak.heightTF.text isEqualToString:@""]) {
            
            [XManager showAlertWith:@"空值啊,魂淡"];
            return;
        }
        
        XSonModel *theModel = [NSEntityDescription insertNewObjectForEntityForName:@"XSonModel" inManagedObjectContext:kContext];
        theModel.name = selfWeak.nameTF.text;
        theModel.age = selfWeak.ageTF.text.integerValue;
        theModel.height = selfWeak.heightTF.text.floatValue;
        [kDelegate saveContext];
        
        selfWeak.nameTF.text = @"";
        selfWeak.ageTF.text = @"";
        selfWeak.heightTF.text = @"";
    }];
    
    
    self.numberOfRowsInSection = ^NSInteger(NSInteger section) {
       
        return selfWeak.datas.count;
    };
    
    
    selfWeak.tableView.tableHeaderView = ({

        UIView *theView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
        theView.backgroundColor = [UIColor whiteColor];
        
        selfWeak.nameTF = [selfWeak customTextfield:CGRectMake(20, 10, kScreenWidth, 30) placeholderSting:@"name"];
        selfWeak.ageTF = [selfWeak customTextfield:CGRectMake(20, 50, kScreenWidth, 30) placeholderSting:@"age"];
        selfWeak.heightTF = [selfWeak customTextfield:CGRectMake(20, 90, kScreenWidth, 30) placeholderSting:@"height"];

        [theView addSubview:selfWeak.nameTF];
        [theView addSubview:selfWeak.ageTF];
        [theView addSubview:selfWeak.heightTF];
        
        theView;
    });
    
    self.creatCellView = ^(UITableViewCell *cell, NSIndexPath *indexPath) {
      
        XSonModel *theModel = selfWeak.datas[indexPath.row];
        cell.textLabel.text = kStringFormat(@"name: %@ age: %d height: %f",theModel.name, theModel.age, theModel.height);
    };
    
    
    
    [self updateDataFromHeadWith:^{
        
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"XSonModel"];
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:NO];
        request.sortDescriptors = [NSArray arrayWithObject:sort];
        
        NSError *error = nil;
        NSArray *objs = [app.persistentContainer.viewContext executeFetchRequest:request error:&error];
        if (error)  [NSException raise:@"查询错误" format:@"%@", [error localizedDescription]];
        
        selfWeak.datas = [NSMutableArray arrayWithArray:objs];
        [selfWeak.tableView reloadData];
        [selfWeak.tableView.mj_header endRefreshing];
    }];
    
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XSonModel *theModel = self.datas[indexPath.row];
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        
        [XManager alertControllerWithTitle:@"提示" message:@"确定删除此服务" confirmButton:@"确定" cancelButton:@"取消" showIn:self confirmBlock:^{
            
            NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"XSonModel"];
//            request.predicate = [NSPredicate predicateWithFormat:@"orderId = %@",theModel.orderId];
            NSArray *result = [kContext executeFetchRequest:request error:nil];
            
            for (XSonModel *modelll in result) {
                
                if ([modelll isEqual:theModel]) {
                    [kContext deleteObject:theModel];
                }
            }
            
            if ([kContext save:nil]) {
                NSLog(@"删除成功");
            } else {
                NSLog(@"删除失败");
            }
            
            [self.tableView.mj_header beginRefreshing];
        } cancelBlock:nil];
    }];
    
    UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"编辑" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        
        [XManager showAlertWith:@"假装编辑下"];
//        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"XSonModel"];
//        
//        //设置过滤条件
//        NSPredicate *pre = [NSPredicate predicateWithFormat:@"createTime = %@",theModel.createTime];
//        request.predicate = pre;
//        
//        NSError *errorrr = nil;
//        NSArray *objs = [kContext executeFetchRequest:request error:&errorrr];
//        if (errorrr)    [NSException raise:@"查询错误" format:@"%@", [errorrr localizedDescription]];
//        
//        for (GrabModel *modelll in objs) {
//            
//            if ([modelll.orderId isEqualToString:notiModel.orderId]) {
//                
//                modelll.totalAmount = orderModel.totalAmount;
//                modelll.makeUp = orderModel.makeupCount;
//                [kContext updatedObjects];
//                NSLog(@"修改完成");
//            }
//        }
//        
//        //保存,用 save 方法
//        BOOL success = [kContext save:&errorrr];
//        if (!success) {
//            
//            [NSException raise:@"访问数据库错误" format:@"%@",[errorrr localizedDescription]];
//        }
//        
//        [XManager alertControllerWithTitle:@"提示" message:@"确定删除此服务" confirmButton:@"确定" cancelButton:@"取消" showIn:self confirmBlock:^{
//            
//            NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"XSonModel"];
//            //            request.predicate = [NSPredicate predicateWithFormat:@"orderId = %@",theModel.orderId];
//            NSArray *result = [kContext executeFetchRequest:request error:nil];
//            
//            for (XSonModel *modelll in result) {
//                
//                if ([modelll isEqual:theModel]) {
//                    [kContext deleteObject:theModel];
//                }
//            }
//            
//            if ([kContext save:nil]) {
//                NSLog(@"删除成功");
//            } else {
//                NSLog(@"删除失败");
//            }
//            
//            [self.tableView.mj_header beginRefreshing];
//        } cancelBlock:nil];
    }];
    
    
    
    return @[deleteAction,editAction];
}

- (UITextField *)customTextfield:(CGRect)frame placeholderSting:(NSString *)pString{
    
    UITextField *theTF = [[UITextField alloc]initWithFrame:frame];
    theTF.font = kFontTheme(15);
    theTF.borderStyle = UITextBorderStyleNone;
    theTF.textColor = [UIColor redColor];
    theTF.placeholder = pString;
    return theTF;
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
