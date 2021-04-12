//
//  Udesk-UniMPSDK-Manager.m
//  Udesk-UniMPSDK-Manager
//
//  Created by 陈历 on 2021/4/12.
//

#import "UdeskUniMPSDKManager.h"
#import 

#define k_AppId @"__UNI__11E9B73"

@interface UdeskUniMPSDKManager () <DCUniMPSDKEngineDelegate>

@property (nonatomic, weak) DCUniMPInstance *uniMPInstance;

@end

@implementation UdeskUniMPSDKManager

+ (void)initSDKEnvironmentWithLaunchOptions:(NSDictionary *)options{
    [DCUniMPSDKEngine initSDKEnvironmentWithLaunchOptions:options];
}


- (instancetype)init{
    if (self = [super init]) {
        [self initSetting];
    }
    return self;
}

- (void)initSetting{
    [self checkUniMPResource];
}

- (void)checkUniMPResource {
    // 注意：isExistsApp: 方法仅是判断运行目录中是否存在应用资源，正式环境应该添加版本控制，内置新的wgt资源后需要判断版本，决定是否需要释放应用资源
    if (![DCUniMPSDKEngine isExistsApp:k_AppId]) {
        // 读取导入到工程中的wgt应用资源
        NSString *appResourcePath = [[NSBundle mainBundle] pathForResource:k_AppId ofType:@"wgt"];
        // 将应用资源部署到运行路径中
        if ([DCUniMPSDKEngine releaseAppResourceToRunPathWithAppid:k_AppId resourceFilePath:appResourcePath]) {
            NSLog(@"应用资源文件部署成功");
        }
    }
}

- (DCUniMPConfiguration *)getUniMPConfiguration {
    /// 初始化小程序的配置信息
    DCUniMPConfiguration *configuration = [[DCUniMPConfiguration alloc] init];
    
    // 配置启动小程序时传递的参数（参数可以在小程序中通过 plus.runtime.arguments 获取此参数）
    configuration.arguments = @{ @"arguments":@"Hello uni microprogram" };
    // 配置小程序启动后直接打开的页面路径 例：@"pages/component/view/view?action=redirect&password=123456"
//    configuration.redirectPath = @"pages/component/view/view?action=redirect&password=123456";
    // 开启后台运行
    configuration.enableBackground = NO;
    // 设置 push 打开方式
    configuration.openMode = DCUniMPOpenModePush;
    // 启用侧滑手势关闭小程序
    configuration.enableGestureClose = NO;
    
    
    return configuration;
}

- (IBAction)openMiniSDK:(id)sender {
    
    // 获取配置信息
    DCUniMPConfiguration *configuration = [self getUniMPConfiguration];
    __weak __typeof(self)weakSelf = self;
    // 打开小程序
    [DCUniMPSDKEngine openUniMP:k_AppId configuration:configuration completed:^(DCUniMPInstance * _Nullable uniMPInstance, NSError * _Nullable error) {
        if (uniMPInstance) {
            weakSelf.uniMPInstance = uniMPInstance;
        } else {
            NSLog(@"打开小程序出错：%@",error);
        }
    }];
}

- (void)openUdeskWithParams:(NSDictionary *)paras error:(NSError **)error{
    [self openMiniSDK:nil];
}



@end
