//
//Created by ESJsonFormatForMac on 17/11/06.
//

#import "ProjectDetailModel.h"
@implementation ProjectDetailModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"devices" : [Devices class]};
}


@end

@implementation Projectinfo


@end


@implementation Devices

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"children" : [Children class]};
}


@end


@implementation Children


@end


