//
//  YLActionSheet.h
//  YLActionSheetDemo
//
//  Created by zhang on 2017/7/1.
//  Copyright © 2017年 zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YLActionSheet;

@protocol YLActionSheetDelegate <NSObject>
@optional

/**
 User click action sheet item

 @param actionSheet YLActionSheet object
 @param actionIndex action sheet index
 */
- (void)ylActionSheet:(YLActionSheet *)actionSheet actionAtIndex:(NSInteger)actionIndex;

/**
 User click action sheet cancel

 @param actionSheet YLActionSheet object
 */
- (void)ylActionSheetCanceld:(YLActionSheet *)actionSheet;

@end

@interface YLActionSheet : UIView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id<YLActionSheetDelegate> delegate;
@property (nonatomic, copy) NSString *actionSheetTitle;

/**
 The Action sheet initialization method

 @param title action sheet title
 @param delegate delegate
 @param actionTitles sheets
 @return YLActionSheet
 */
- (instancetype)initWithTitle:(NSString *)title
                 withDelegate:(id)delegate
                 actionTitles:(NSString *)actionTitles, ...NS_REQUIRES_NIL_TERMINATION;

/**
 Add action with title to sheet

 @param title title
 @return the number of title index in sheet
 */
- (NSInteger)addActionWithTitle:(NSString *)title;

/**
 Show action sheet at parent view

 @param parentView the UIViewController's view
 */
- (void)showInView:(UIView *)parentView;

@end
