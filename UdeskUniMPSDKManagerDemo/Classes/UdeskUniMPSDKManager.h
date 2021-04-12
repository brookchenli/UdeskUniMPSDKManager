//
//  Udesk-UniMPSDK-Manager.h
//  Udesk-UniMPSDK-Manager
//
//  Created by 陈历 on 2021/4/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UdeskUniMPSDKManager : NSObject

/**
 打开Udesk
 */

- (void)openUdeskWithParams:(NSDictionary *)paras error:(NSError **)error;

+ (void)initSDKEnvironmentWithLaunchOptions:(NSDictionary *)options;

@end

NS_ASSUME_NONNULL_END
