#import "SopZdesk.h"
@ import SupportSDK
@ import ZendeskCoreSDK

@implementation SopZdesk

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(init:(NSString *)appId clientId:( NSString *)clientId zendeskUrl:(NSString *)zendeskUrl)
{

   [ZDKZendesk initializeWithAppId:appId clientId:clientId zendeskUrl:zendeskUrl];
    [ZDKSupport initializeWithZendesk:[ZDKZendesk instance]];
}

@end
