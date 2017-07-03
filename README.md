# About YLActionSheet
An action menu from the bottom of the screen
# Screenshoot
![screenshoot](/images/test.gif)
# Useage
Import `YLActionSheet.h` and `YLActionSheet.m` into your project.
In the ViewController implementation `YLActionSheetDelegate` delegate(optional)
![delegate](/images/delegate)
Initialize action sheet:
```
self.actionSheet = [[YLActionSheet alloc] initWithTitle:@"Action sheet title" withDelegate:self actionTitles:@"sheet 1", @"sheet 2", nil];
```

and delegate callback:
```
- (void)ylActionSheet:(YLActionSheet *)actionSheet actionAtIndex:(NSInteger)actionIndex
{
    NSLog(@"action sheet call back, actionIndex:%ld", actionIndex);
}

- (void)ylActionSheetCanceld:(YLActionSheet *)actionSheet
{
    NSLog(@"action sheet call back, click cancel");
}
```

