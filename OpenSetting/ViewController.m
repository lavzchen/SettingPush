//
//  ViewController.m
//  OpenSetting
//
//  Created by zdc on 2016/11/01.
//  Copyright © 2016年 zdc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray<NSArray<NSString*> *> *dataSourceArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.dataSourceArr = @[
                            @[@"Wi-Fi", @"App-Prefs:root=WIFI"],
                            @[@"Bluetooth",@"App-Prefs:root=Bluetooth"],
                            @[@"mobile network", @"App-Prefs:root=MOBILE_DATA_SETTINGS_ID"],
                            @[@"Internet share", @"App-Prefs:root=INTERNET_TETHERING"],
                            @[@"Carrier", @"App-Prefs:root=Carrier"],
                            @[@"notification", @"App-Prefs:root=NOTIFICATIONS_ID"],
                            @[@"General", @"App-Prefs:root=General"],
                            @[@"About", @"App-Prefs:root=General&path=About"],
                            @[@"Keyboard", @"App-Prefs:root=General&path=Keyboard"],
                            @[@"Wallpaper", @"App-Prefs:root=Wallpaper"],
                            @[@"Profile", @"App-Prefs:root=General&path=ManagedConfigurationList"],
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 100000
                            @[@"Siri", @"App-Prefs:root=SIRI"],
#else
                            @[@"Siri", @"App-Prefs:root=General&path=SIRI"],
#endif
                            @[@"Privacy", @"App-Prefs:root=Privacy"],
                            @[@"location", @"App-Prefs:root=Privacy&path=LOCATION"],
                            @[@"Microphone ", @"App-Prefs:root=Privacy&path=MICROPHONE"],
                            @[@"Contacts ", @"App-Prefs:root=Privacy&path=CONTACTS"],
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 100000
                            @[@"Safari", @"App-Prefs:root=Safari"],
#else
                            @[@"Safari", @"App-Prefs:root=SAFARI"],
#endif
                            @[@"music", @"App-Prefs:root=MUSIC"],
                            @[@"music-EQ", @"App-Prefs:root=MUSIC&path=com.apple.Music:EQ"],
                            @[@"photos & camera", @"App-Prefs:root=Photos"]
                        ];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(indexPath.row%2) {
        cell.backgroundColor = [UIColor grayColor];
    }else{
        cell.backgroundColor = [UIColor whiteColor];
    }
    NSArray<NSString *> *itemArr = [self.dataSourceArr objectAtIndex:indexPath.row];
    if (itemArr) {
        [cell.textLabel setText:[itemArr firstObject]];
        [cell.detailTextLabel setText:[itemArr lastObject]];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *path = [[self.dataSourceArr objectAtIndex:indexPath.row] lastObject];
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 100000
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:path] options:@{} completionHandler:nil];
#else
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:path]];
#endif
}

@end
