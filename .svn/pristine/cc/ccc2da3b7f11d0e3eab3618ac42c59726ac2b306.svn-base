//
//  ShopUserInfoViewController.m
//  XTWL_IOS_SHOP
//
//  Created by Zhaoyang on 2017/10/19.
//  Copyright © 2017年 XTWL. All rights reserved.
//

#import "ShopUserInfoViewController.h"
#import "OpenShopInfo.h"
#import "DecideString.h"
#import "CommonUtil.h"
#import <AFHTTPSessionManager.h>

@interface ShopUserInfoViewController ()<UIActionSheetDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIScrollViewDelegate>{
    NSInteger indextag;
    NSArray *titleArr;
    UIButton *sureBtn;
    

    
}
PropertyStrong UIImageView *sfzImageview;
PropertyStrong UIImageView *sfzBackImageview;
PropertyStrong UIScrollView *infoScrollView;
PropertyStrong UITableView *infotable;

@end

@implementation ShopUserInfoViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    
    // 添加监听,键盘出现或者隐藏
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillChangeFrame:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}


- (void)viewDidDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // 移除监听
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = Farensfz;
    titleArr = @[FarenName,Farensfzz];
    
    MYLog(@"%@",[OpenShopInfo shareInstance].CompanyUser);
    
    //左上角返回
    UIButton *leftBackBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    leftBackBtn.titleLabel.font = Font16;
    [leftBackBtn setImage:ImageNamed(@"navi_back") forState:UIControlStateNormal];
    [leftBackBtn addTarget:self action:@selector(leftback) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBackBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                   target:nil action:nil];
    nagetiveSpacer.width = -30;//这个值可以根据自己需要自己调整
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, leftItem];
    
    
    [self initInfoTable];
}


#pragma UITableViewDelegate&&UITableViewDataSource
- (void)initInfoTable {
    
    self.infoScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, Start_Height, Screen_Width, Show_Height_Next - 60)];
    self.infoScrollView.delegate = self;
    self.infoScrollView.showsVerticalScrollIndicator = NO;
    self.infoScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.infoScrollView];
    
    self.infotable = [[UITableView alloc]initWithFrame:CGRectMake(0, 10, Screen_Width, 471) style:UITableViewStyleGrouped];
    self.infotable.delegate = self;
    self.infotable.dataSource = self;
    self.infotable.scrollEnabled = NO;
    [self.infoScrollView addSubview:self.infotable];
    
    sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(SpaceLeftRight, Screen_Height - 50, (Screen_Width-2*SpaceLeftRight), 43)];
    SetViewCorner(sureBtn, 5);
    
    [sureBtn setBackgroundColor:ColorWithHexString(Color_MainFFDA44)];
    sureBtn.titleLabel.font = Font16;
    [sureBtn setTitle:AlertBtn_Save forState:UIControlStateNormal];
    [sureBtn setTitleColor:ColorWithHexString(ColorText_333333) forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];
    
    self.infoScrollView.contentSize = CGSizeMake(Screen_Width, CGRectGetMaxY(self.infotable.frame)+10);
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 355;
    }else {
        return 10;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}




- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView * backview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 355)];
        backview.backgroundColor = WHITE_COLOR;
        [self.view addSubview:backview];
        
        self.sfzImageview = [[UIImageView alloc]initWithFrame:CGRectMake((Screen_Width/2)-130, 15, 260 , 155)];
        self.sfzImageview.tag = 100;
        self.sfzImageview.userInteractionEnabled = YES;
        self.sfzImageview.contentMode=UIViewContentModeScaleAspectFit;

        

        
        [backview addSubview:self.sfzImageview];
        if ([CommonUtil LocalHaveImage:@"100"]) {
            self.sfzImageview.image = [CommonUtil GetImageFromLocal:@"100"];
        }else {
            self.sfzImageview.image = ImageNamed(@"sfz_zm");
        }
        
        
        UITapGestureRecognizer *sfztapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseImage:)];
        [self.sfzImageview addGestureRecognizer:sfztapGes];
        
        
        self.sfzBackImageview = [[UIImageView alloc]initWithFrame:CGRectMake((Screen_Width/2)-130, CGRectGetMaxY(self.sfzImageview.frame)+15, 260, 155)];
        self.sfzBackImageview.tag = 101;
        self.sfzBackImageview.userInteractionEnabled = YES;
        self.sfzBackImageview.contentMode= UIViewContentModeScaleAspectFit;

        [backview addSubview:self.sfzBackImageview];
        if ([CommonUtil LocalHaveImage:@"101"]) {
            self.sfzBackImageview.image = [CommonUtil GetImageFromLocal:@"101"];
        }else {
            self.sfzBackImageview.image = ImageNamed(@"sfz_fm");
        }
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseImage:)];
        [self.sfzBackImageview addGestureRecognizer:tapGes];
        return backview;
    }else{
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UITextField *infotext = [[UITextField alloc]initWithFrame:CGRectMake(Screen_Width-150, 0, 145, 48)];
            infotext.delegate = self;
            infotext.textAlignment = NSTextAlignmentRight;
            infotext.tag = 100+indexPath.row;
            infotext.borderStyle =   UITextBorderStyleNone;
            [infotext addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
            infotext.textColor = ColorWithHexString(ColorText_333333);
            infotext.font = Font14;
            
            [infotext setValue:Font14 forKeyPath:@"_placeholderLabel.font"];
            [infotext setValue:ColorWithHexString(ColorText_dadada) forKeyPath:@"_placeholderLabel.textColor"];
            [cell.contentView addSubview:infotext];
            
        }
        UITextField *infotext = (UITextField *)[cell.contentView viewWithTag:100+indexPath.row];
        
        cell.textLabel.font = Font14;
        cell.textLabel.textColor = ColorWithHexString(ColorText_333333);
        cell.textLabel.text = titleArr[indexPath.row];
        if (indexPath.row == 0) {
            infotext.placeholder = InpuName;
            infotext.text = AvailableString([OpenShopInfo shareInstance].CompanyUser);
        }else {
            infotext.placeholder = InpuSfz;
            infotext.text = AvailableString([OpenShopInfo shareInstance].CompanyUserNum);
        }
        return cell;
    }
    return nil;
}

//添加图片
- (void)chooseImage:(UITapGestureRecognizer *)tapGes {
    indextag = tapGes.view.tag;
    UIActionSheet *sheet;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        sheet  = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:AlertBtn_Cancle destructiveButtonTitle:nil otherButtonTitles:TakePhoto, ChooseFromLocal, nil];
    else
        sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:AlertBtn_Cancle destructiveButtonTitle:nil otherButtonTitles:ChooseFromLocal, nil];
    [sheet showInView:self.view];
}
#pragma UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    // 判断是否支持相机
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        switch (buttonIndex) {
            case 0://相机
                sourceType = UIImagePickerControllerSourceTypeCamera;
                break;
            case 1: //相册
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                break;
            default:
                return;
        }
    }else {
        if (buttonIndex == 0) {
            sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        }else {
            return;
        }
    }
    // 跳转到相机或相册页面
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = (id)self;
//    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = sourceType;
    
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

#pragma mark - UIImagePickerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];  //
    


    //选取图片 上传
    if (indextag == 100) {
        
        
       
        
        self.sfzImageview.image = originalImage;
        
        
        
        [CommonUtil SaveImageToLocal:originalImage Keys:@"100"];
    }else{

        self.sfzBackImageview.image = originalImage;
        [CommonUtil SaveImageToLocal:originalImage Keys:@"101"];
    }
    
}




#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    switch (textField.tag) {
        case 100:
            
        [OpenShopInfo shareInstance].CompanyUser = textField.text;
            break;
        case 101:
            [OpenShopInfo shareInstance].CompanyUserNum = textField.text;
            break;
        
            
        default:
            break;
    }
}





//检测联系人和店铺地址，店铺名称的输入情况
- (void)textFieldChanged:(UITextField *)textField
{
    
    NSString *toBeString = textField.text;
    
    //获取高亮部分
    UITextRange *selectedRange = [textField markedTextRange];
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    if (textField.tag == 100) {
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position)
        {
            if (toBeString.length > MAX_ShopUser_LENGTH)
            {
                NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:MAX_ShopUser_LENGTH];
                if (rangeIndex.length == 1)
                {
                    textField.text = [toBeString substringToIndex:MAX_ShopUser_LENGTH];
                }
                else
                {
                    NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, MAX_ShopUser_LENGTH)];
                    textField.text = [toBeString substringWithRange:rangeRange];
                }
            }
        }
    }else if (textField.tag == 101) {
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position)
        {
            if (toBeString.length > MAX_Shenfenzheng_LENGTH)
            {
                NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:MAX_Shenfenzheng_LENGTH];
                if (rangeIndex.length == 1)
                {
                    textField.text = [toBeString substringToIndex:MAX_Shenfenzheng_LENGTH];
                }
                else
                {
                    NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, MAX_Shenfenzheng_LENGTH)];
                    textField.text = [toBeString substringWithRange:rangeRange];
                }
            }
        }
    }
}



- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}

#pragma mark - 键盘变化通知
- (void)keyboardWillChangeFrame:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    
    CGFloat keyboardHeight = keyboardRect.size.height;
    self.infoScrollView.frame = CGRectMake(0, Start_Height - keyboardHeight, Screen_Width, Show_Height_Next - 60  );
    self.infoScrollView.contentSize = CGSizeMake(Screen_Width, CGRectGetMaxY(self.infotable.frame)+10);
    
    
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    self.infoScrollView.frame = CGRectMake(0, Start_Height, Screen_Width, Show_Height_Next - 60 );
    self.infoScrollView.contentSize = CGSizeMake(Screen_Width, CGRectGetMaxY(self.infotable.frame)+10);
}


- (BOOL)checkInfo {
    
    if ([CommonUtil LocalHaveImage:@"100"]) {
        return YES;
    }
    if ([CommonUtil LocalHaveImage:@"101"]) {
        return YES;
    }
    
    if (![AvailableString([OpenShopInfo shareInstance].CompanyUser) isEqualToString:@""]) {
        return YES;
    }
    if (![AvailableString([OpenShopInfo shareInstance].CompanyUserNum) isEqualToString:@""]) {
        return YES;
    }
    
    return NO;
}


- (void)save{
    HideKeyBoard;
    
    
    [[OpenShopInfo shareInstance] writeToDefaults];
    [self showToast:SaveSuccess];
    [self performSelector:@selector(returnback) withObject:nil afterDelay:1.5];

}

- (void)leftback {
    HideKeyBoard;
    //有信息填写了弹窗提示保存
    if ([self checkInfo]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:AlertMsg_IsSaveInfo preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *saveaction = [UIAlertAction actionWithTitle:AlertBtn_Save style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self save];
        }];
        
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:AlertBtn_NoSave style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self returnback];
        }];
        [alert addAction:action];
        [alert addAction:saveaction];
        [self presentViewController:alert animated:YES completion:nil];
    }else {
        [self returnback];
    }
    
}

- (void)returnback {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
