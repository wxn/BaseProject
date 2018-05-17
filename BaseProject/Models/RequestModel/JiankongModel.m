//
//Created by ESJsonFormatForMac on 17/11/04.
//

#import "JiankongModel.h"
@implementation JiankongModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"paramlist" : [Paramlist class]};
}


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

- (NSString *)do2ValueIn {
    NSString *value = @"";
    for (NSInteger i=0;i<self.paramlist.count;i ++) {
        Paramlist *list = self.paramlist[i];
        if ([list.paramCode isEqualToString:@"DO2"]) {
            value = list.paramValue;
            return value;
        }
    }
    return value;
}

@end

@implementation Paramlist


@end


