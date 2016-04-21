//
//  ViewController.m
//  AddMethodDemo
//
//  Created by 孙云 on 16/4/21.
//  Copyright © 2016年 haidai. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <objc/runtime.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加方法
    Person *p = [[Person alloc]init];
    class_addMethod([Person class], @selector(findInSelf), class_getMethodImplementation([ViewController class], @selector(addFind)), "v@:");
    [p performSelector:@selector(findInSelf)];
    
    [self exchangeMethod];
    [self printPerson];
}
- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear: animated];
    NSLog(@"viewWillAppear");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  方法交换
 */
- (void)exchangeMethod{

    Method old = class_getInstanceMethod([ViewController class], @selector(viewWillAppear:));
    Method new = class_getInstanceMethod([ViewController class], @selector(addFind));
    method_exchangeImplementations(old, new);
    //运行程序查看
}
/**
 *  输出一些person的属性
 */
- (void)printPerson{

    NSLog(@"\n\n\n---------------ivar list-----------------");
    unsigned int count;
    //ivar
    Ivar *ivars = class_copyIvarList([Person class], &count);
    for (int i = 0; i < count; i ++) {
        Ivar ivar = ivars[i];
        NSLog(@"ivar === %s",ivar_getName(ivar));
    }
    NSLog(@"\n\n\n--------------method list------------------");
    Method *methods = class_copyMethodList([Person class], &count);
    for (int i = 0; i < count; i ++) {
        Method method  = methods[i];
        NSLog(@"method == %s",method_getName(method));
    }
    NSLog(@"\n\n\n--------------property list------------------");
    objc_property_t *propertys = class_copyPropertyList([Person class], &count);
    for (int i = 0; i < count; i ++) {
        objc_property_t property = propertys[i];
        NSLog(@"property === %s",property_getName(property));
    }
}
- (void)addFind{

    NSLog(@"Wow,find sun yun fei");
}
@end
