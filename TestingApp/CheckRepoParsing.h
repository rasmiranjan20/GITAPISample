//
//  CheckRepoParsing.h
//  TestingApp
//
//  Created by Rasmiranjan Sahu on 10/26/22.
//

#import <Foundation/Foundation.h>

@class Repository;
NS_ASSUME_NONNULL_BEGIN

@interface CheckRepoParsing : NSObject

+(void)gitRepoParsing:(NSString *)platform companyName:(NSString *)companyName complition:(void (^) (NSArray<Repository *> *  _Nullable repos, NSError  * _Nullable error))complition;

@end

NS_ASSUME_NONNULL_END
