//
//Created by ESJsonFormatForMac on 17/11/06.
//

#import <Foundation/Foundation.h>

@class Projectinfo,Devices,Children;
@interface ProjectDetailModel : NSObject

@property (nonatomic, strong) NSArray<Devices *> *devices;

@property (nonatomic, strong) Projectinfo *projectInfo;

@end
@interface Projectinfo : NSObject

@property (nonatomic, copy) NSString *projectName;

@property (nonatomic, assign) NSInteger equipmentQty;

@property (nonatomic, copy) NSString *customerName;

@property (nonatomic, copy) NSString *space;

@property (nonatomic, assign) NSInteger detectorQty;

@property (nonatomic, assign) NSInteger alarmQty;

@property (nonatomic, copy) NSString *picture;

@property (nonatomic, copy) NSString *equipment;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, assign) NSInteger troubleQty;

@property (nonatomic, assign) BOOL flag;

@property (nonatomic, copy) NSString *telPhone;

@property (nonatomic, copy) NSString *projectID;

@property (nonatomic, copy) NSString *dutyPerson;

@end

@interface Devices : NSObject

@property (nonatomic, copy) NSString *deviceId;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *country;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *deviceType;

@property (nonatomic, strong) NSArray<Children *> *children;

@property (nonatomic, copy) NSString *picture;

@property (nonatomic, copy) NSString *province;

@end

@interface Children : NSObject

@property (nonatomic, assign) NSInteger BillSN;

@property (nonatomic, copy) NSString *Area;

@property (nonatomic, copy) NSString *Remark;

@property (nonatomic, copy) NSString *CreateTime;

@property (nonatomic, copy) NSString *ProjectID;

@property (nonatomic, copy) NSString *Location;

@property (nonatomic, copy) NSString *Type;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *DeviceID;

@end

