//
//  ViewController.m
//  WZZDrawToZoomOut
//
//  Created by 王召洲 on 16/9/14.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#define KHEIGHT 200
#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak,nonatomic) UITableView  * mytable;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UITableView *table = [[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    [table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CC"];
        [self.view addSubview:table];
    
   UIImage *img = [UIImage imageNamed:@"mm.jpg"];

    
    CGFloat aspect =img.size.width/img.size.height;
    
    CGFloat height = self.view.bounds.size.width/aspect;
    
    table.contentInset = UIEdgeInsetsMake(height, 0, 0, 0);
    
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0,-height, self.view.bounds.size.width,height)];
    imgV.contentMode = UIViewContentModeScaleAspectFill;
    imgV.image = [UIImage imageNamed:@"mm.jpg"];
    imgV.tag = 2;
    [table addSubview:imgV];
    
    table.delegate = self;
    table.dataSource = self;
    self.mytable = table;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CC" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"----------->%ld",indexPath.row];
    cell.backgroundColor = [UIColor colorWithRed: arc4random_uniform(256)/255.0  green:arc4random_uniform(256)/255.0 blue: arc4random_uniform(256)/255.0 alpha:1 ];
    return cell;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint point = scrollView.contentOffset;
    
    NSLog(@"%@",NSStringFromCGPoint(point));
    
    CGRect rect = [self.mytable viewWithTag:2].frame;
    rect.origin.y = point.y;
    
    rect.size.height = -point.y;
    
    [self.mytable viewWithTag:2].frame = rect;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
