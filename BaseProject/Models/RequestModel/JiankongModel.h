//
//Created by ESJsonFormatForMac on 17/11/04.
//

#import <Foundation/Foundation.h>

@class JiankongItemsView;
@class Paramlist;
@interface JiankongModel : NSObject

@property (nonatomic,strong) JiankongItemsView *itemsView;

@property (nonatomic, copy) NSString *do2Value;//用于判断分闸操作

@property (nonatomic, copy) NSString *operationStr;//操作文案

@property (nonatomic, copy) NSString *rownum;

@property (nonatomic, copy) NSString *billSN;

@property (nonatomic, copy) NSString *area;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *location;

@property (nonatomic, copy) NSString *monitorid;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, strong) NSArray<Paramlist *> *paramlist;

@property (nonatomic, copy) NSString *state;

- (NSString *)do2ValueIn;

@end
@interface Paramlist : NSObject

@property (nonatomic, copy) NSString *paramName;

@property (nonatomic, copy) NSString *paramValue;

@property (nonatomic, copy) NSString *paramCode;

@end

