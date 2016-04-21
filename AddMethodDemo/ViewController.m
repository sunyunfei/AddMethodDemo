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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)addFind{

    NSLog(@"Wow,find sun yun fei");
}
@end
