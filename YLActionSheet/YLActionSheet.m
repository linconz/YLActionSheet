//
//  YLActionSheet.m
//  YLActionSheetDemo
//
//  Created by zhang on 2017/7/1.
//  Copyright © 2017年 zhang. All rights reserved.
//

#import "YLActionSheet.h"

#define YL_ACTIONSHEET_ACTION_HEIGHT            44
#define YL_ACTIONSHEET_SECTION_HEADER_HEIGHT    10
#define YL_LINE_COLOR                           [UIColor colorWithRed:227.0 / 255.0 green:227.0 / 255.0 blue:227.0 / 255.0 alpha:1]
#define YL_ONE_PIXEL_SEPERATOR_HEIGHT           ([[UIScreen mainScreen] scale]>1.0?([[UIScreen mainScreen] scale]>2.0?1.0/3:1.0/2):1.0)

@interface YLActionSheet ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *bodyView;
@property (nonatomic, strong) NSMutableArray *actionSheetTitles;

- (void)clickBodyView:(id)sender;

@end

@implementation YLActionSheet

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.actionSheetTitles = [NSMutableArray array];

        self.bodyView = [[UIButton alloc] initWithFrame:CGRectZero];
        [self.bodyView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.2f]];
        [self.bodyView addTarget:self action:@selector(clickBodyView:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.bodyView];

        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.backgroundColor = [UIColor whiteColor];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.scrollEnabled = NO;
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self.bodyView addSubview:self.tableView];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title
                 withDelegate:(id)delegate
                 actionTitles:(NSString *)actionTitles, ...NS_REQUIRES_NIL_TERMINATION {

    if ([self initWithFrame:CGRectZero]) {
        self.delegate = delegate;

        self.actionSheetTitle = title;
        va_list args;
        va_start(args, actionTitles);
        for (NSString *arg = actionTitles; arg != nil; arg = va_arg(args, NSString*)) {
            [self.actionSheetTitles addObject:arg];
        }
        va_end(args);
        [self.tableView reloadData];
    }
    return self;
}

#pragma mark - table delegate & datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return [self.actionSheetTitles count];
    }
    if (section == 1) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = @"customActionSheetCellIdentifier";
    UITableViewCell * cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor whiteColor];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        UIView *selectedbackgroundView = [[UIView alloc] initWithFrame:cell.contentView.frame];
        [selectedbackgroundView setBackgroundColor:[UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1]];
        [cell setSelectedBackgroundView:selectedbackgroundView];
        [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
        [cell.textLabel setBackgroundColor:[UIColor whiteColor]];
        [cell.textLabel setTextColor:[UIColor colorWithRed:68.0 / 255.0 green:68.0 / 255.0 blue:68.0 / 255.0 alpha:1]];
        [cell.textLabel setHighlightedTextColor:[UIColor colorWithRed:68.0 / 255.0 green:68.0 / 255.0 blue:68.0 / 255.0 alpha:1]];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
        CGFloat lineHeight = YL_ONE_PIXEL_SEPERATOR_HEIGHT;

        if (indexPath.row == 0) {
            UIImageView *imgLineTop = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,
                                                                                    CGRectGetWidth(tableView.frame),
                                                                                    lineHeight)];
            imgLineTop.backgroundColor = YL_LINE_COLOR;
            [cell addSubview:imgLineTop];
        }
        UIImageView *imgLineBottom = [[UIImageView alloc] initWithFrame:CGRectMake(0, YL_ACTIONSHEET_ACTION_HEIGHT - lineHeight,
                                                                                CGRectGetWidth(tableView.frame),
                                                                                lineHeight)];
        imgLineBottom.backgroundColor = YL_LINE_COLOR;
        [cell addSubview:imgLineBottom];
    }

    if (indexPath.section == 0) {
        cell.textLabel.text = self.actionSheetTitles[indexPath.row];
    } else {
        [cell.textLabel setTextColor:[UIColor colorWithRed:239.0 / 255.0 green:68.0 / 255.0 blue:67.0 / 255.0 alpha:1]];
        [cell.textLabel setHighlightedTextColor:[UIColor colorWithRed:239.0 / 255.0 green:68.0 / 255.0 blue:67.0 / 255.0 alpha:1]];
        cell.textLabel.text = NSLocalizedString(@"Cancel", nil);
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return YL_ACTIONSHEET_ACTION_HEIGHT;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return YL_ACTIONSHEET_SECTION_HEADER_HEIGHT;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, YL_ACTIONSHEET_SECTION_HEADER_HEIGHT)];
        [headerView setBackgroundColor:[UIColor colorWithRed:246.0 / 255.0 green:246.0 / 255.0 blue:246.0 / 255.0 alpha:1]];
        return headerView;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    long row = 0;
    if (indexPath.section == 0) {
        row = indexPath.row;
    } else {
        row = [self.actionSheetTitles count] + 1;
    }
    [self clickBodyView:nil];
    if (indexPath.section == 1) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(ylActionSheetCanceld:)]) {
            [self.delegate ylActionSheetCanceld:self];
        }
    } else {
        if (self.delegate
            && [self.delegate respondsToSelector:@selector(ylActionSheet:actionAtIndex:)]) {
            [self.delegate ylActionSheet:self actionAtIndex:row];
        }
    }
}

- (NSInteger)addActionWithTitle:(NSString *)title {
    [self.actionSheetTitles addObject:title];
    return [self.actionSheetTitles count];
}

- (void)clickBodyView:(id)sender {
    float tableViewHeight = (([self.actionSheetTitles count] + 1) * YL_ACTIONSHEET_ACTION_HEIGHT + YL_ACTIONSHEET_SECTION_HEADER_HEIGHT);
    [UIView animateWithDuration:0.2f
                     animations:^{
                         [self setAlpha:0];
                         [self.tableView setFrame:CGRectMake(0,
                                                             self.frame.size.height,
                                                             self.frame.size.width,
                                                             tableViewHeight)];
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}

- (void)showInView:(UIView *)parentView {
    [self setFrame:CGRectMake(0, 0, parentView.frame.size.width, parentView.frame.size.height)];
    [self.bodyView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];

    float actionSheetTitleHeight = self.actionSheetTitle && [self.actionSheetTitle length] > 0 ? YL_ACTIONSHEET_ACTION_HEIGHT : 0;

    if (actionSheetTitleHeight > 0
        && !self.tableView.tableHeaderView) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, YL_ACTIONSHEET_ACTION_HEIGHT)];
        [titleLabel setText:self.actionSheetTitle];
        [titleLabel setTextColor:[UIColor colorWithRed:68.0 / 255.0 green:68.0 / 255.0 blue:68.0 / 255.0 alpha:1]];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
        [self.tableView setTableHeaderView:titleLabel];
    }

    float tableViewHeight = ([self.actionSheetTitles count] + 1) * YL_ACTIONSHEET_ACTION_HEIGHT + YL_ACTIONSHEET_SECTION_HEADER_HEIGHT + actionSheetTitleHeight;
    [self.tableView setFrame:CGRectMake(0,
                                    self.frame.size.height,
                                    self.frame.size.width,
                                    tableViewHeight)];
    [self setAlpha:0];
    [parentView addSubview:self];
    [parentView bringSubviewToFront:self];
    NSInteger tabbarHeight = 0;

    [UIView animateWithDuration:0.3f
                     animations:^{
                         [self setAlpha:1];
                         [self.tableView setFrame:CGRectMake(0,
                                                             self.frame.size.height - tableViewHeight - tabbarHeight,
                                                             self.frame.size.width,
                                                             tableViewHeight)];
                     }
                     completion:^(BOOL finished) {}];
}

- (void)dealloc {
    self.delegate = nil;
}

@end
