//
//  CheckRepoParsing.m
//  TestingApp
//
//  Created by Rasmiranjan Sahu on 10/26/22.
//

#import "CheckRepoParsing.h"
#import <GITAPISample/GITAPISample.h>

@implementation CheckRepoParsing

+(void)gitRepoParsing:(NSString *)platform companyName:(NSString *)companyName complition:(void (^) (NSArray<Repository *> *  _Nullable repos, NSError  * _Nullable error))complition {
    [GitHubService getRepoListWithPlatform:platform companyName:companyName completionHandler:^(NSArray<Repository *> *repos, NSError *error) {
            complition(repos, error);
    }];
}
@end
