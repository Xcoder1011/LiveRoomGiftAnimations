//
//  MainListViewController.m
//  LiveRoomGiftAnimations
//
//  Created by KUN on 17/3/9.
//  Copyright © 2017年 animation. All rights reserved.
//

#import "MainListViewController.h"
#import "Item.h"
#import "MainListCell.h"
#import "FireworksAnimationController.h"
#import "ThumbsUpViewController.h"
#import "ParticleSprayController.h"



@interface MainListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic , strong) UITableView *tableview;

@property (nonatomic , strong) NSMutableArray *adapterArray;

@property (nonatomic , assign) BOOL tableViewShouldLoad;

@end

@implementation MainListViewController

- (void)setup {
    
    self.title = @"Live Animation";
    
    [super setup];
    
    [self loadDataSource];
    
    [self.tableview registerClass:[MainListCell class] forCellReuseIdentifier:NSStringFromClass([MainListCell class])];

    [self.contentView addSubview:self.tableview];

    [self insertDataToTableview];

    [self setNavRightItemWith:SKLocalizedString(@"change", @"切换语言")andImage:nil];
    
}

- (void)loadDataSource {
    
    NSArray * items = @[
                        [Item itemWithName:SKLocalizedString(@"fireworks Animation", nil) object:[[FireworksAnimationController alloc] init]],
                        [Item itemWithName:SKLocalizedString(@"thumb Animation", nil) object:[[ThumbsUpViewController alloc] init]],
                        [Item itemWithName:SKLocalizedString(@"car Animation", nil) object:[[FireworksAnimationController alloc] init]],
                        [Item itemWithName:SKLocalizedString(@"combo effect Animation", nil) object:[[FireworksAnimationController alloc] init]],
                        [Item itemWithName:SKLocalizedString(@"tableview scroll up Animation", nil) object:[[FireworksAnimationController alloc] init]],
                        [Item itemWithName:SKLocalizedString(@"barrage effect Animation", nil) object:[[FireworksAnimationController alloc] init]],
                        [Item itemWithName:SKLocalizedString(@"particle injection graphics Animation", nil) object:[[ParticleSprayController alloc] init]]
                        ];
    
    for (int i = 0; i < items.count; i ++) {
        [self.adapterArray addObject:[MainListCell cellAdapterWithData:items[i] cellHeight:0]];
    }
}

-(void)insertDataToTableview {
    
    NSMutableArray<NSIndexPath *> *indexPaths = [NSMutableArray array];
    for (int i = 0; i < self.adapterArray.count; i ++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        [indexPaths addObject:indexPath];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.tableViewShouldLoad = YES;
        [self.tableview insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    });
}

- (void)rightItemClick:(id)sender {
    
    static NSInteger idex = 0;
    idex ++;
    if (idex == 3) {
        idex = 0;
    }
    
    kWeakObj(self)
    
    [kLanguageManager setLanguage:LanguageCodes[idex] completion:^(NSString *currentLanguage) {
        
        kStrongObj(self);
        
        [self.adapterArray removeAllObjects];
        
        [self loadDataSource];

        [self.tableview reloadData];
        
        [self setNavRightItemWith:SKLocalizedString(@"change", @"切换语言")andImage:nil];
    }];
}


#pragma mark - Lazy loading

- (NSMutableArray *)adapterArray {

    if (!_adapterArray) {
        _adapterArray = @[].mutableCopy;
    }
    return _adapterArray;
}

- (UITableView *)tableview {

    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:self.contentView.bounds style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.rowHeight = 65.f;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableview;
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    return (UITableViewCell *)[tableView dequeueReusableCustomTableViewCellWithCellAdapter:self.adapterArray[indexPath.row] indexPath:indexPath controller:self];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.tableViewShouldLoad ? self.adapterArray.count : 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [(CustomTableViewCell *)[tableView cellForRowAtIndexPath:indexPath] clickEvent];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

@end
