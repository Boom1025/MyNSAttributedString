//
//  ViewController.m
//  MyNSAttributedString
//
//  Created by 姚云丽 on 17/3/28.
//  Copyright © 2017年 姚云丽. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *menues;

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) NSMutableAttributedString *attributedText;
@property (nonatomic, strong) NSMutableDictionary *attributes;
@end

@implementation ViewController

- (NSMutableArray *)menues {
    if(!_menues) {
        _menues = [[NSMutableArray alloc] init];
        
        [_menues addObject:@{@"attribute":@"字体变大变小", @"key":NSFontAttributeName, @"value":[UIFont systemFontOfSize:20.f]}];
        [_menues addObject:@{@"attribute":@"字体变色", @"key":NSForegroundColorAttributeName, @"value":[UIColor blueColor]}];
        [_menues addObject:@{@"attribute":@"字间间距变大变小", @"key":NSKernAttributeName, @"value":[NSNumber numberWithFloat:10.f]}];
        [_menues addObject:@{@"attribute":@"删除线", @"key":NSStrikethroughStyleAttributeName, @"value":[NSNumber numberWithInteger:1]}];
        [_menues addObject:@{@"attribute":@"下划线", @"key":NSUnderlineStyleAttributeName, @"value":[NSNumber numberWithInteger:10]}];
        [_menues addObject:@{@"attribute":@"文字空心", @"key":NSStrokeWidthAttributeName, @"value":[NSNumber numberWithFloat:4.f]}];
        
        NSShadow *shadow = [[NSShadow alloc] init];
        shadow.shadowOffset = CGSizeMake(3, 3);
        shadow.shadowColor = [UIColor redColor];
        [_menues addObject:@{@"attribute":@"阴影", @"key":NSShadowAttributeName,@"value":shadow}];
                             
        [_menues addObject:@{@"attribute":@"字体变胖", @"key":NSExpansionAttributeName,@"value":@"1.1"}];
        [_menues addObject:@{@"attribute":@"字体变歪", @"key":NSObliquenessAttributeName,@"value":@"1.1"}];
        }
    return _menues;
}

- (NSMutableAttributedString *)attributedText {
    if(!_attributedText) {
        NSString *text = @"第二次实验，B4041408。\n多姿多彩的文本。\nIOS老师是个很好的老师。";
        _attributedText = [[NSMutableAttributedString alloc] initWithString:text];
    }
    return _attributedText;
}

- (NSMutableDictionary *)attributes {
    if(!_attributes) {
        _attributes = [[NSMutableDictionary alloc] init];
    }
    return _attributes;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectZero];
    self.label.translatesAutoresizingMaskIntoConstraints = NO;
    self.label.numberOfLines = 0;
    self.label.userInteractionEnabled = YES;
    self.label.attributedText = self.attributedText;
    [self.view addSubview:self.label];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view attribute:NSLayoutAttributeLeft
                                                         multiplier:1.f constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view attribute:NSLayoutAttributeRight
                                                         multiplier:1.f constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view attribute:NSLayoutAttributeTop
                                                         multiplier:1.f constant:20.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.f constant:200.f]];
    
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view attribute:NSLayoutAttributeLeft
                                                         multiplier:1.f constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view attribute:NSLayoutAttributeRight
                                                         multiplier:1.f constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.label attribute:NSLayoutAttributeBottom
                                                         multiplier:1.f constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view attribute:NSLayoutAttributeBottom
                                                         multiplier:1.f constant:0.f]];
}



#pragma mark Delegates
#pragma mark UITableView delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.menues count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    NSDictionary *menu = [self.menues objectAtIndex:indexPath.row];
    cell.textLabel.text = [menu objectForKey:@"attribute"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *attribute = [self.menues objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if(cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        [self.attributes removeObjectForKey:[attribute objectForKey:@"key"]];
        
    } else {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [self.attributes setObject:[attribute objectForKey:@"value"] forKey:[attribute objectForKey:@"key"]];
    }
    [self.attributedText setAttributes:self.attributes range:[self.attributedText.string rangeOfString:self.attributedText.string]];
    self.label.attributedText = self.attributedText;
}

@end