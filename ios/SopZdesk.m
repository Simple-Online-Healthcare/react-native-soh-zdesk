#import "SopZdesk.h"
@import SupportSDK;
@import ZendeskCoreSDK;
@import MessagingSDK;
#import <ChatSDK/ChatSDK.h>
#import <ChatProvidersSDK/ChatProvidersSDK.h>

@implementation SopZdesk

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(init:(NSString *)appId clientId:(NSString *)clientId zendeskUrl:(NSString *)zendeskUrl)
{
    [ZDKZendesk initializeWithAppId:appId clientId:clientId zendeskUrl:zendeskUrl];
    [ZDKSupport initializeWithZendesk:[ZDKZendesk instance]];
    [ZDKChat initializeWithAccountKey:clientId appId:appId queue:dispatch_get_main_queue()];



}
RCT_EXPORT_METHOD(initUser:(NSString *)email name:(NSString *)name phone:(NSString *)phone)
{
    id<ZDKObjCIdentity> userIdentity = [[ZDKObjCAnonymous alloc] initWithName:name email:email];
     [[ZDKZendesk instance] setIdentity:userIdentity];

    ZDKChatAPIConfiguration *chatAPIConfiguration = [[ZDKChatAPIConfiguration alloc] init];
    chatAPIConfiguration.department = @"SOP";
    chatAPIConfiguration.visitorInfo = [[ZDKVisitorInfo alloc] initWithName:name email:email phoneNumber:phone];
    ZDKChat.instance.configuration = chatAPIConfiguration;
}


RCT_EXPORT_METHOD(startChat)
{
    dispatch_async(dispatch_get_main_queue(), ^{
        ZDKChatConfiguration *chatConfiguration = [[ZDKChatConfiguration alloc] init];
        chatConfiguration.isAgentAvailabilityEnabled = YES;
       // chatConfiguration.isChatTranscriptPromptEnabled = YES;
        //chatConfiguration.isOfflineFormEnabled = YES;
        chatConfiguration.isPreChatFormEnabled = YES;


        ZDKMessagingConfiguration *messagingConfiguration = [[ZDKMessagingConfiguration alloc] init];
        messagingConfiguration.name = @"Chat Bot";
        NSError *error = nil;
        NSArray *engines = @[(id <ZDKEngine>) [ZDKChatEngine engineAndReturnError:&error]];

        UIViewController *chatViewC = [ZDKMessaging.instance buildUIWithEngines:engines configs:@[messagingConfiguration, chatConfiguration] error:&error];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:chatViewC];
        UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
       // [rootViewController presentViewController:nav animated:YES completion:nil];
    });
}






RCT_EXPORT_METHOD(openHelpCenter)
{
    dispatch_async(dispatch_get_main_queue(), ^{

        UIViewController *helpCenter = [ZDKHelpCenterUi buildHelpCenterOverviewUiWithConfigs:@[]];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:helpCenter];
        UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
        [rootViewController presentViewController:nav animated:YES completion:nil];
    });
}

RCT_EXPORT_METHOD(openContactUs)
{
    dispatch_async(dispatch_get_main_queue(), ^{

   UIViewController *requestScreen = [ZDKRequestUi buildRequestUiWith:@[]];
     UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:requestScreen];

           UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
           [rootViewController presentViewController:nav animated:YES completion:nil];
    });
}
RCT_EXPORT_METHOD(openTickets)
{
    dispatch_async(dispatch_get_main_queue(), ^{

        UIViewController *requestListController = [ZDKRequestUi buildRequestList];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:requestListController];

           UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
           [rootViewController presentViewController:nav animated:YES completion:nil];
    });
}
@end
