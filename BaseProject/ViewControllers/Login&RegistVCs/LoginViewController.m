//
//  LoginViewController.m
//  BaseProject
//
//  Created by Cinna on 2017/10/18.
//  Copyright © 2017年 XTWL. All rights reserved.
//

#import "LoginViewController.h"
#import "DecideString.h"
#import "AppDelegate.h"
#import "TabBarController.h"
#import "AFNetworking.h"
#import "SDWebImageManager.h"
#import "JPUSHService.h"
#import "AppInfo.h"

@interface LoginViewController ()<UITextFieldDelegate>
@end

@implementation LoginViewController {
    UIImageView *logoImageView;
    
    UITextField *ipTextField;
    UITextField *accountTextField;
    UITextField *pswTextField;
    UIButton *loginBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initLoginView];
    
    UserInfo *info = [UserInfo shareInstance];
    ipTextField.text = info.ipPort;
    accountTextField.text = info.userAccount;
    pswTextField.text = info.userPsw.length > 0?info.userPsw:@"";
    UIImage *image = [[SDImageCache sharedImageCache] imageFromCacheForKey:info.ipPort];
    [self setLogoImage:image];
    if (info.isAutoLogin && info.ipPort.length > 0 && info.userAccount.length > 0) {
        [self sendRequestToLogin:info.ipPort];
    }
    [self sendRequestToGetImage:info.ipPort];
}

- (void)initLoginView {
    
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, Start_Height, Screen_Width, Screen_Height)];
    bgImageView.image = ImageNamed(@"login_background2");
    [self.view addSubview:bgImageView];
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(SpaceLeftRight, (Show_Height_Next - 280)/2.0 - 30, Screen_Width - SpaceLeftRight * 2, 280)];
    backView.backgroundColor = WHITE_COLOR;
    SetViewCorner(backView, CornerRadius_3);
    [self.view addSubview:backView];
    
    logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake((Screen_Width - 110)/2.0, backView.frame.origin.y - 32, 110, 22)];
    [self.view addSubview:logoImageView];
    
    [CreateView createLabelWithFrame:CGRectMake(SpaceLeftRight, SpaceLeftRight, 200, 20) text:@"欢迎来到用电监控平台" fontSize:FontSize_14 textColorStr:ColorText_333333 superView:backView];
    
    ipTextField = [[UITextField alloc] initWithFrame:CGRectMake(SpaceLeftRight, 40, backView.frame.size.width - SpaceLeftRight * 2, 40)];
    ipTextField.font = Font14;
    ipTextField.delegate = self;
    ipTextField.placeholder = @"IP端口";
    [backView addSubview:ipTextField];
    UIView *lineoneview = [[UIView alloc]initWithFrame:CGRectMake(ipTextField.frame.origin.x, ipTextField.frame.origin.y + 40, ipTextField.frame.size.width, 0.5)];
    lineoneview.backgroundColor = ColorWithHexString(ColorLine_e0e0e0);
    [backView addSubview:lineoneview];

    accountTextField = [[UITextField alloc] initWithFrame:CGRectMake(SpaceLeftRight, ipTextField.frame.origin.y + ipTextField.frame.size.height + 10, backView.frame.size.width - SpaceLeftRight * 2, 40)];
    accountTextField.font = Font14;
    accountTextField.placeholder = @"用户名";
    [backView addSubview:accountTextField];
    UIView *lineoneview1 = [[UIView alloc]initWithFrame:CGRectMake(accountTextField.frame.origin.x, accountTextField.frame.origin.y + 40, accountTextField.frame.size.width, 0.5)];
    lineoneview1.backgroundColor = ColorWithHexString(ColorLine_e0e0e0);
    [backView addSubview:lineoneview1];
    
    pswTextField = [[UITextField alloc] initWithFrame:CGRectMake(SpaceLeftRight, accountTextField.frame.origin.y + accountTextField.frame.size.height + 10, backView.frame.size.width - SpaceLeftRight * 2, 40)];
    pswTextField.font = Font14;
    pswTextField.secureTextEntry = YES;
    pswTextField.placeholder = @"密码";
    [backView addSubview:pswTextField];
    
    UIView *lineoneview2 = [[UIView alloc]initWithFrame:CGRectMake(pswTextField.frame.origin.x, pswTextField.frame.origin.y + 40, pswTextField.frame.size.width, 0.5)];
    lineoneview2.backgroundColor = ColorWithHexString(ColorLine_e0e0e0);
    [backView addSubview:lineoneview2];
    
    loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(pswTextField.frame.origin.x, pswTextField.frame.origin.y + pswTextField.frame.size.height + 25, pswTextField.frame.size.width, 40)];
    SetViewCorner(loginBtn, 5);
//    loginBtn.userInteractionEnabled = NO;
    [loginBtn setBackgroundColor:ColorWithHexString(ColorText_Blue34aeff)];
    loginBtn.titleLabel.font = Font16;
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:loginBtn];
    
}

- (void)setLogoImage:(UIImage *)image {
    
    CGFloat height = (Show_Height_Next - 280)/2.0 - 30;
    CGFloat imageWidth = 110;
    CGFloat imageHeight = image.size.height/image.size.width * 110;
    if (image) {
        logoImageView.frame = CGRectMake((Screen_Width - imageWidth)/2.0, height - 10 - imageHeight, imageWidth, imageHeight);
        logoImageView.image = image;
    }else {
        logoImageView.image = nil;
    }
}

//当满足条件时 按钮可以点击
- (void)changeBtnImage {
    if (![AvailableString(accountTextField.text) isEqualToString:@""]&&pswTextField.text.length>0) {
        loginBtn.userInteractionEnabled = YES;
        [loginBtn setBackgroundColor:ColorWithHexString(Color_MainFFDA44)];
        [loginBtn setTitleColor:ColorWithHexString(ColorText_333333) forState:UIControlStateNormal];
    }else {
        loginBtn.userInteractionEnabled = NO;
        [loginBtn setBackgroundColor:ColorWithHexString(Color_LoginF9E69B)];
        [loginBtn setTitleColor:ColorWithHexString(ColorText_999999) forState:UIControlStateNormal];
    }
    
}
#pragma UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == ipTextField) {
        [self sendRequestToGetImage:ipTextField.text];
    }
}

- (void)login {
    HideKeyBoard;
    if (![CommonUtil checkIpPort:ipTextField.text]) {
        [self showToast:@"请输入正确的IP端口！"];
        return;
    }else if (accountTextField.text.length <= 0) {
        [self showToast:@"请输入用户名！"];
        return;
    }
    [self sendRequestToLogin:ipTextField.text];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)showTabbar {
    //跳转到下一页
    TabBarController *vc = [[TabBarController alloc] init];
    AppDelegate *delegate = App_Delegate;
    delegate.window.rootViewController = vc;
    if ([AppInfo shareInstance].isShowBaojingView) {
        [AppInfo shareInstance].isShowBaojingView = NO;
        [vc setSelectedIndex:1];
    }
}

#pragma mark - 登录
- (void)sendRequestToLogin:(NSString *)ipPort {
    ShowProcessHud;
    WeakSelf;
    NSString *str = [NSString stringWithFormat:@"username=%@&password=%@",accountTextField.text,pswTextField.text];
    if (pswTextField.text.length <= 0) {
        str = [NSString stringWithFormat:@"username=%@&password=%@",accountTextField.text,@""];
    }
    [RequestManager sendGetRequestWithRequestName:[NSString stringWithFormat:@"http://%@/api/main/checklogin?%@",ipPort,str] parameters:nil completeBlock:^(BOOL result, NSString *resultDesc, NSDictionary *dataDic) {
         HideProcessHud;
         if (result) {
             [weakSelf showToast:@"登录成功！"];
             UserInfo *info = [UserInfo shareInstance];
             info.userAccount = accountTextField.text;
             info.userPsw = pswTextField.text;
             info.userID = dataDic[@"userid"];
             info.userRealName = dataDic[@"realname"];
             info.userRole = dataDic[@"role"];
             info.ipPort = ipPort;
             info.isAutoLogin = YES;
             [info writeToDefaults];
             [weakSelf performSelector:@selector(showTabbar) withObject:nil afterDelay:0.5];
             NSString *subStr = [[ipPort componentsSeparatedByString:@":"] objectAtIndex:0];
             NSString *bieming = [NSString stringWithFormat:@"%@_%@",subStr,info.userAccount];
             [JPUSHService setAlias:bieming completion:nil seq:0];
         }else {
             [weakSelf showToast:@"登录失败"];
         }
     } failedBlock:^(NSError *error) {
         HideProcessHud
         [weakSelf showToast:ToastMsg_NetworkFailed];
     }];
}

//获取图片
- (void)sendRequestToGetImage:(NSString *)ipPort {
    WeakSelf;
    //api/mobile/getHoldURL
    NSArray *arr = [ipPort componentsSeparatedByString:@":"];
    if (arr.count != 2) {
        return;
    }
    NSString *completeUrlStr = [NSString stringWithFormat:@"http://%@/api/mobile/getHoldURLByPort?port=%@",arr[0],arr[1]];
    completeUrlStr = [completeUrlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer.timeoutInterval = 5.0f;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
    
    [manager GET:completeUrlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\\\\\\\\" withString:@"\\"];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\\\"" withString:@"\""];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\\" withString:@"/"];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\"[" withString:@"["];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"]\"" withString:@"]"];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\"{" withString:@"{"];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"}\"" withString:@"}"];
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
        NSString *urlStr = dataDic[@"holdURL"];
        if (urlStr.length > 0) {
            NSString *imageUrlStr = [NSString stringWithFormat:@"http://%@/webinfo/admin/%@",ipPort,urlStr];
            [[[SDWebImageManager sharedManager] imageDownloader] downloadImageWithURL:[NSURL URLWithString:imageUrlStr] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
                
            } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
                if (image) {
                    [[SDImageCache sharedImageCache] storeImage:image forKey:ipPort completion:nil];
                    [weakSelf setLogoImage:image];
                }
            }];
        }else {
            [weakSelf setLogoImage:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf setLogoImage:nil];
    }];
}

@end
