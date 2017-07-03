//
//  ViewController.m
//  YLActionSheetDemo
//
//  Created by zhang on 2017/7/1.
//  Copyright © 2017年 zhang. All rights reserved.
//

#import "ViewController.h"
#import "YLActionSheet.h"

@interface ViewController ()<YLActionSheetDelegate>

@property (nonatomic, strong) YLActionSheet *actionSheet;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.actionSheet = [[YLActionSheet alloc] initWithTitle:@"Action sheet title"
                                               withDelegate:self
                                               actionTitles:@"sheet 1", @"sheet 2", nil];
}

- (IBAction)clickTapMenu:(id)sender {
    [self.actionSheet showInView:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)ylActionSheet:(YLActionSheet *)actionSheet actionAtIndex:(NSInteger)actionIndex
{
    NSLog(@"action sheet call back, actionIndex:%ld", actionIndex);
}

- (void)ylActionSheetCanceld:(YLActionSheet *)actionSheet
{
    NSLog(@"action sheet call back, click cancel");
}

@end
