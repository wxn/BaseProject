//
//Created by ESJsonFormatForMac on 17/11/06.
//

#import <Foundation/Foundation.h>

@class Monitorinfo,Params;
@interface TanceModel : NSObject

@property (nonatomic, strong) Monitorinfo *monitorInfo;

@property (nonatomic, strong) NSArray<Params *> *params;

@end
@interface Monitorinfo : NSObject

@property (nonatomic, copy) NSString *deviceId;

@property (nonatomic, copy) NSString *area;

@property (nonatomic, copy) NSString *location;

@property (nonatomic, copy) NSString *remark;

@property (nonatomic, copy) NSString *monitorId;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *projectName;

@property (nonatomic, copy) NSString *projectId;

@end

@interface Params : NSObject

@property (nonatomic, copy) NSString *paramName;

@property (nonatomic, copy) NSString *value;

@property (nonatomic, copy) NSString *paramCode;

@property (nonatomic, copy) NSString *isImportant;

@end

