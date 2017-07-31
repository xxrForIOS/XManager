//
//  ViewController.m
//  Dataaaaaa
//
//  Created by X.Melo on 2017/7/31.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "ViewController.h"
#import <CoreData/CoreData.h>
#import "NotiModel.h"
@interface ViewController ()


@property (nonatomic, strong) UIButton              *leftButton;
@property (nonatomic, strong) UIButton              *rightButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    
    self.leftButton = ({
        
        UIButton *theButton = [UIButton buttonWithType:UIButtonTypeCustom];
        theButton.frame = CGRectMake(30, 200, 100, 40);
        theButton.backgroundColor = [UIColor redColor];
        [theButton setTitle:@"插入" forState:0];
        theButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.view addSubview:theButton];
        [theButton addTarget:self action:@selector(doSomething:) forControlEvents:UIControlEventTouchUpInside];
        theButton;
    });
    
    self.rightButton = ({
        
        UIButton *theButton = [UIButton buttonWithType:UIButtonTypeCustom];
        theButton.frame = CGRectMake(self.view.frame.size.width - 130, 200, 100, 40);
        theButton.backgroundColor = [UIColor redColor];
        [theButton setTitle:@"获取" forState:0];
        theButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.view addSubview:theButton];
        [theButton addTarget:self action:@selector(doSomething:) forControlEvents:UIControlEventTouchUpInside];
        theButton;
    });
}

- (void)doSomething:(UIButton *)sender {
    
    
    // 从应用程序包中加载模型文件
    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
    // 传入模型对象，初始化NSPersistentStoreCoordinator
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    // 构建SQLite数据库文件的路径
    NSString *docs = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSURL *url = [NSURL fileURLWithPath:[docs stringByAppendingPathComponent:@"NotiModel.data"]];
    // 添加持久化存储库，这里使用SQLite作为存储库
    NSError *error = nil;
    NSPersistentStore *store = [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error];
    if (store == nil) { // 直接抛异常
        [NSException raise:@"添加数据库错误" format:@"%@", [error localizedDescription]];
    }
    // 初始化上下文，设置persistentStoreCoordinator属性
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    context.persistentStoreCoordinator = psc;
    
    if ([sender.currentTitle isEqualToString:@"插入"]) {
        
        NSManagedObject *person = [NSEntityDescription insertNewObjectForEntityForName:@"NotiModel" inManagedObjectContext:context];
        // 设置Person的简单属性
        [person setValue:@"MJ" forKey:@"name"];
        [person setValue:[NSNumber numberWithInt:27] forKey:@"age"];
        
//        // 传入上下文，创建一个Card实体对象
//        NSManagedObject *card = [NSEntityDescription insertNewObjectForEntityForName:@"Card" inManagedObjectContext:context];
//        [card setValue:@"4414241933432" forKey:@"no"];
//        // 设置Person和Card之间的关联关系
//        [person setValue:card forKey:@"card"];
        // 利用上下文对象，将数据同步到持久化存储库
        NSError *error = nil;
        BOOL success = [context save:&error];
        if (!success) {
            [NSException raise:@"访问数据库错误" format:@"%@", [error localizedDescription]];  
        }
    }
    
    if ([sender.currentTitle isEqualToString:@"获取"]) {
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
