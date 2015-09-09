//
//  ViewController.m
//  FontList
//
//  Created by Bingjie on 14-7-30.
//  Copyright (c) 2014年 Bingjie. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

//获取Document目录
+ (NSString *)getDocumentPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return ([paths count] > 0 ? [paths objectAtIndex:0] : @"undefined");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"字体库";
    
    NSMutableArray *array = @[].mutableCopy;
    for (NSString *familyName in [UIFont familyNames]) {
        
        NSArray * fonts = [UIFont fontNamesForFamilyName:familyName];
                           
        for (NSString *fontName in fonts) {
            [array addObject:fontName];
        }
    }
	[array writeToFile:[NSString stringWithFormat:@"%@/xxx.plist",[self.class getDocumentPath]] atomically:YES];
    NSLog(@"%@",[self.class getDocumentPath]);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //字体家族总数
    
    return [[UIFont familyNames] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //字体家族包括的字体库总数
    return [[UIFont fontNamesForFamilyName:[[UIFont familyNames] objectAtIndex:section] ] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    //字体家族名称
    return [[UIFont familyNames] objectAtIndex:section];
}


- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    return index;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        CGFloat red     = ( arc4random() % 256);
        CGFloat green   = ( arc4random() % 256);
        CGFloat blue    = ( arc4random() % 256);
        
        cell.textLabel.textColor = [UIColor colorWithRed:red/255 green:green/255 blue:blue/255 alpha:1];
    }
    
    //字体家族名称
    NSString *familyName= [[UIFont familyNames] objectAtIndex:indexPath.section];
    //字体家族中的字体库名称
    NSString *fontName  = [[UIFont fontNamesForFamilyName:[[UIFont familyNames] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    
    cell.textLabel.font = [UIFont fontWithName:fontName size:14.0f];
    
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", familyName, fontName ];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //字体家族名称
    NSString *familyName= [[UIFont familyNames] objectAtIndex:indexPath.section];
    //字体家族中的字体库名称
    NSString *fontName  = [[UIFont fontNamesForFamilyName:[[UIFont familyNames] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    
    UIPasteboard *pPaste = [UIPasteboard generalPasteboard];
    [pPaste setString:[NSString stringWithFormat:@"%@\n%@",familyName,fontName]];
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:familyName
                          message:fontName
                          delegate:nil cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
    [alert show];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
