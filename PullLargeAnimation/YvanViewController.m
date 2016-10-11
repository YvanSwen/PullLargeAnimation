//
//  YvanViewController.m
//  PullLargeAnimation
//
//  Created by Yvan on 2016/10/11.
//  Copyright © 2016年 Yvan. All rights reserved.
//

#import "YvanViewController.h"
#import "NavView.h"

#define kCellIdentifier @"cell"
@interface YvanViewController ()
<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NavView *navView;/**< <#annotation#> */
@property (nonatomic, strong) UITableView *tableView;/**<  */
@property (nonatomic, strong) NSMutableArray *dataArray;/**< <#annotation#> */
@property (nonatomic, strong) UIView *tableHeader;/**< <#annotation#> */
@property (nonatomic, strong) UIImageView *headerImg;
;/**< <#annotation#> */
@property (nonatomic, strong) UILabel *nameLabel;
;/**< <#annotation#> */
@property (nonatomic, assign) int contentOffsety;/**< <#annotation#> */


@property(nonatomic,strong)UIImageView *backgroundImgV;
@property(nonatomic,assign)float backImgHeight;
@property(nonatomic,assign)float backImgWidth;


@end

@implementation YvanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadContent];
}
- (void)loadContent {
    [self setupBackImage];
    [self setupNavView];
    [self setupTableView];
}
- (void)setupBackImage {
    UIImage *image=[UIImage imageNamed:@"back"];
    
    _backgroundImgV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, image.size.height *0.8)];
    _backgroundImgV.image=image;
    _backgroundImgV.userInteractionEnabled=YES;
    [self.view addSubview:_backgroundImgV];
    _backImgHeight=_backgroundImgV.frame.size.height;
    _backImgWidth=_backgroundImgV.frame.size.width;
}
- (void)setupNavView {
    self.navView = [[NavView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, NavViewHeight)];
    self.navView.title = @"我的";
    self.navView.color = [UIColor whiteColor];
    self.navView.leftBtnImage = @"left_";
    self.navView.rightBtnImage = @"Setting";
    [self.view addSubview:self.navView];}

- (void)setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavViewHeight, SCREENWIDTH, SCREENHEIGHT -NavViewHeight) style:UITableViewStyleGrouped];
    _tableView.backgroundColor=[UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];
    [self.view addSubview:self.tableView];
}
#pragma -- 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return HeadImageHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    self.tableHeader=[[UIView alloc]init];
    self.tableHeader.frame=CGRectMake(0, NavViewHeight, SCREENWIDTH, HeadImageHeight);
    self.tableHeader.backgroundColor=[UIColor clearColor];
    self.tableHeader.userInteractionEnabled = YES;
    
    self.headerImg=[[UIImageView alloc]initWithFrame:CGRectMake(SCREENWIDTH/2-35, 50, 70, 70)];
    _headerImg.center=CGPointMake(SCREENWIDTH/2, 70);
    [_headerImg setImage:[UIImage imageNamed:@"header"]];
    [_headerImg.layer setMasksToBounds:YES];
    [_headerImg.layer setCornerRadius:35];
    _headerImg.backgroundColor=[UIColor whiteColor];
    _headerImg.userInteractionEnabled=YES;
    UITapGestureRecognizer *header_tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(header_tap_Click:)];
    [_headerImg addGestureRecognizer:header_tap];
    [self.tableHeader addSubview:_headerImg];
    
    
    _nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(147, 130, 105, 20)];
    _nameLabel.center = CGPointMake(SCREENWIDTH/2, 125);
    _nameLabel.text = @"Yvan";
    _nameLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *nick_tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nick_tap_Click:)];
    [_nameLabel addGestureRecognizer:nick_tap];
    _nameLabel.textColor=[UIColor whiteColor];
    _nameLabel.textAlignment=NSTextAlignmentCenter;
    [self.tableHeader addSubview:_nameLabel];
    
    return self.tableHeader;
}
-(void)header_tap_Click:(UITapGestureRecognizer *)tap
{
    NSLog(@"头像");
}
//昵称
-(void)nick_tap_Click:(UIButton *)item
{
    NSLog(@"昵称");
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    int contentOffsety = scrollView.contentOffset.y;
    _contentOffsety = contentOffsety;
    
    if (scrollView.contentOffset.y <= HeadImageHeight) {
        self.navView.headBackView.alpha = scrollView.contentOffset.y / HeadImageHeight;
        self.navView.leftBtnImage = @"left_";
        self.navView.rightBtnImage = @"Setting";
        self.navView.color = [UIColor whiteColor];
        [self preferredStatusBarStyle];
    }else{
        self.navView.headBackView.alpha = 1;
        
        self.navView.leftBtnImage = @"left@3x.png";
        self.navView.rightBtnImage = @"Setting_";
        self.navView.color = kColor(87, 173, 104, 1);
        [self preferredStatusBarStyle];
        
    }
    if (contentOffsety<0) {// 向下拉
        CGRect rect = _backgroundImgV.frame;
        rect.size.height = _backImgHeight-contentOffsety;
        rect.size.width = _backImgWidth* (_backImgHeight-contentOffsety)/_backImgHeight;
        rect.origin.x =  -(rect.size.width-_backImgWidth)/2;
        rect.origin.y = 0;
        _backgroundImgV.frame = rect;
    }else{ // 向上拉
        CGRect rect = _backgroundImgV.frame;
        rect.size.height = _backImgHeight;
        rect.size.width = _backImgWidth;
        rect.origin.x = 0;
        rect.origin.y = -contentOffsety;
        _backgroundImgV.frame = rect;
    }
    // View controller-based status bar appearance 为YES时,必须调用下面的方法
    [self setNeedsStatusBarAppearanceUpdate];
}
// iOS 10 原先的方法
// [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
// 已经过期
- (UIStatusBarStyle)preferredStatusBarStyle {
    if (_contentOffsety <= HeadImageHeight) {
        return UIStatusBarStyleLightContent;
    } else {
        return UIStatusBarStyleDefault;
    }
    return UIStatusBarStyleDefault;
}
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        for (int i = 0; i < 20; i++) {
            
            NSString * string=[NSString stringWithFormat:@"第%d行",i];
            
            [_dataArray addObject:string];
            
        }
    }
    return _dataArray;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
