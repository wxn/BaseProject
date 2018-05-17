//
//  ShopSaleImageViewController.m
//  XTWL_IOS_SHOP
//
//  Created by Zhaoyang on 2017/10/19.
//  Copyright © 2017年 XTWL. All rights reserved.
//

#import "ShopSaleImageViewController.h"
#import "DecideString.h"
#import "ZLPhoto.h"
#import "UIImage+ZLPhotoLib.h"
#import "OpenShopInfo.h"

@interface ShopSaleImageViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UITextFieldDelegate,ZLPhotoPickerBrowserViewControllerDelegate,UIActionSheetDelegate>{
    NSArray *titleArr;
//    NSString *foodSaleNum; //餐饮许可证注册号
//    NSString *foodSaleAddress; //餐饮许可证所在地
//    NSString *SaleNum; //营业执照注册号
//    NSString *SaleAddress; //营业执照所在地
    
}
PropertyStrong UIScrollView *infoScrollView;
PropertyStrong UIView *addImageView;
PropertyStrong NSMutableArray *imageArr;
PropertyStrong NSMutableArray *photos;
@end

@implementation ShopSaleImageViewController
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
    self.navigationItem.title = SaleCard;
    titleArr = @[FoodNum,FoodArea,SaleCardNum,SaleArea];

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
    
    
    self.imageArr = [[NSMutableArray alloc]initWithCapacity:0];
    ZLPhotoAssets *assets;
    for (int i = 0; i<[OpenShopInfo shareInstance].count; i++) {
        if ([CommonUtil LocalHaveImage:[NSString stringWithFormat:@"%d",i]]) {
            UIImage *image = [CommonUtil GetImageFromLocal:[NSString stringWithFormat:@"%d",i]];
            assets = [ZLPhotoAssets assetWithImage:image];
            ZLPhotoPickerBrowserPhoto *photo = [ZLPhotoPickerBrowserPhoto photoAnyImageObjWith:assets];
            photo.asset = assets;
            [self.imageArr addObject:photo];
        }
        
       
    }
    self.infoScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, Start_Height, Screen_Width, Show_Height_Next - 60)];
    self.infoScrollView.delegate = self;
    self.infoScrollView.scrollEnabled = NO;
    self.infoScrollView.showsVerticalScrollIndicator = NO;
    self.infoScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.infoScrollView];
    
    self.addImageView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, Screen_Width, 255)];
    self.addImageView.backgroundColor = WHITE_COLOR;
    [self.infoScrollView addSubview:self.addImageView];
    //代理方法初始化数据
    [self photos];
    [self reloadImageView];
    

    UITableView *infotable = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.addImageView.frame)+10, Screen_Width, 160) style:UITableViewStylePlain];
    infotable.delegate = self;
    infotable.dataSource = self;
    infotable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.infoScrollView addSubview:infotable];
    
    UIButton *sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(SpaceLeftRight, Screen_Height - 50, (Screen_Width-2*SpaceLeftRight), 43)];
    SetViewCorner(sureBtn, 5);
    
    [sureBtn setBackgroundColor:ColorWithHexString(Color_MainFFDA44)];
    sureBtn.titleLabel.font = Font16;
    [sureBtn setTitle:AlertBtn_Save forState:UIControlStateNormal];
    [sureBtn setTitleColor:ColorWithHexString(ColorText_333333) forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];
    
    
    self.infoScrollView.contentSize = CGSizeMake(Screen_Width, CGRectGetMaxY(infotable.frame)+10);
    
}


- (void)reloadImageView {
    // 先移除，后添加
    [[self.addImageView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    

    // 加一是为了有个添加button
    NSUInteger assetCount = self.imageArr.count + 1;
    
    
    CGFloat cellW = 65;
    CGFloat cellH = 65;
    
    for (NSInteger i = 0; i < assetCount; i++) {

        NSInteger index =  (Screen_Width-2*SpaceLeftRight)/(cellW + 15);
        CGFloat cellX = i%index * (cellW + 15);
        CGFloat cellY = 15+i/index *(cellW + 15);
        
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.imageView.contentMode = UIViewContentModeScaleAspectFill;
        btn.frame =CGRectMake(SpaceLeftRight+cellX, cellY, cellW, cellH);
        
        // UIButton
        if (i == self.imageArr.count){
            // 最后一个Button
            [btn setBackgroundImage:ImageNamed(@"tj_pic") forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(photoSelecte) forControlEvents:UIControlEventTouchUpInside];
            if (i==9)
            {
                btn.hidden =YES;
            }else
            {
                btn.hidden =NO;
            }
            
        }else{
            
            // 如果是本地ZLPhotoAssets就从本地取，否则从网络取
            ZLPhotoPickerBrowserPhoto *photo = [self.imageArr objectAtIndex:i];

            if (photo != nil && [photo.asset isKindOfClass:[ZLPhotoAssets class]]) {

                [btn setImage:[photo.asset thumbImage] forState:UIControlStateNormal];
            }else {
               

//        [btn sd_setImageWithURL:photo.photoURL forState:UIControlStateNormal];
    }
            photo.toView = btn.imageView;
            btn.tag = i;
            [btn addTarget:self action:@selector(tapBrowser:) forControlEvents:UIControlEventTouchUpInside];
        }
        [self.addImageView addSubview:btn];
    }

    

}
#pragma mark - 选择图片
- (void)photoSelecte{
    
    
    UIActionSheet *sheet;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        sheet  = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:AlertBtn_Cancle destructiveButtonTitle:nil otherButtonTitles:TakePhoto, ChooseFromLocal, nil];
    else
        sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:AlertBtn_Cancle destructiveButtonTitle:nil otherButtonTitles:ChooseFromLocal, nil];
    [sheet showInView:self.view];
    
}

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
    if (sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
        ZLPhotoPickerViewController *pickerVc = [[ZLPhotoPickerViewController alloc] init];
        pickerVc.maxCount = 9-self.photos.count;
        // Jump AssetsVc
        pickerVc.status = PickerViewShowStatusCameraRoll;
        // Recoder Select Assets
        pickerVc.selectPickers = self.imageArr;
        // Filter: PickerPhotoStatusAllVideoAndPhotos, PickerPhotoStatusVideos, PickerPhotoStatusPhotos.
        pickerVc.photoStatus = PickerPhotoStatusPhotos;
        // Desc Show Photos, And Suppor Camera
        pickerVc.topShowPhotoPicker = YES;
    
        // CallBack
        __weak typeof(self)weakSelf = self;
        pickerVc.callBack = ^(NSArray<ZLPhotoAssets *> *status){
    
            NSMutableArray *photos = [NSMutableArray arrayWithCapacity:status.count];
            for (ZLPhotoAssets *assets in status) {
                ZLPhotoPickerBrowserPhoto *photo = [ZLPhotoPickerBrowserPhoto photoAnyImageObjWith:assets];
                photo.asset = assets;
                [photos addObject:photo];
            }
    
            weakSelf.imageArr = [NSMutableArray arrayWithArray:weakSelf.photos];
            [weakSelf.imageArr addObjectsFromArray:photos];
            //       [self.arr addObjectsFromArray:(nonnull NSArray *)]
            [weakSelf reloadImageView];
        };
        [pickerVc showPickerVc:self];
    }else {
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = (id)self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
    
}

#pragma mark - UIImagePickerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *originalImage = [info objectForKey:UIImagePickerControllerEditedImage];  //
    ZLPhotoAssets *assets = [ZLPhotoAssets assetWithImage:originalImage];
    ZLPhotoPickerBrowserPhoto *photo = [ZLPhotoPickerBrowserPhoto photoAnyImageObjWith:assets];
    photo.asset = assets;
    [self.imageArr addObject:photo];
    [self reloadImageView];
}





- (void)tapBrowser:(UIButton *)btn{

    // 图片游览器
    ZLPhotoPickerBrowserViewController *pickerBrowser = [[ZLPhotoPickerBrowserViewController alloc] init];
    // 淡入淡出效果
    // pickerBrowser.status = UIViewAnimationAnimationStatusFade;
    // 数据源/delegate
    pickerBrowser.editing = YES;
    pickerBrowser.photos = self.imageArr;
    // 能够删除
    pickerBrowser.delegate = self;
    // 当前选中的值
    pickerBrowser.currentIndex = btn.tag;
    // 展示控制器
    [pickerBrowser showPickerVc:self];
}

- (void)photoBrowser:(ZLPhotoPickerBrowserViewController *)photoBrowser removePhotoAtIndex:(NSInteger)index{
    if (self.imageArr.count > index) {
        [self.imageArr removeObjectAtIndex:index];
        [self reloadImageView];
    }
}

#pragma UITableViewDelegate&&UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return titleArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
        if (!cell) {
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UITextField *infotext = [[UITextField alloc]initWithFrame:CGRectMake(130, 0, Screen_Width-135, 39)];
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
            
            UIView *linewview = [[UIView alloc]initWithFrame:CGRectMake(SpaceLeftRight, 39.5, Screen_Width-SpaceLeftRight, 0.5)];
            linewview.tag = 200;
            linewview.backgroundColor = ColorWithHexString(ColorLine_ededed);
            [cell.contentView addSubview:linewview];
            
//
        }
        UITextField *infotext = (UITextField *)[cell.contentView viewWithTag:100+indexPath.row];
        UIView *linewview = (UIView *)[cell.contentView viewWithTag:200];
    
        cell.textLabel.font = Font14;
        cell.textLabel.textColor = ColorWithHexString(ColorText_333333);
        cell.textLabel.text = titleArr[indexPath.row];
    

    
    if (indexPath.row == 0) {
        infotext.placeholder = InputSaleNum;
        infotext.text = [OpenShopInfo shareInstance].FoodNum;
    }else if (indexPath.row == 1) {
        infotext.placeholder = InputArea;
        infotext.text = [OpenShopInfo shareInstance].FoodAddress;
    }else if (indexPath.row == 2) {
        infotext.placeholder = InputSaleNum;
        infotext.text = [OpenShopInfo shareInstance].SaleNum;
    }else {

        linewview.hidden = YES;
        infotext.placeholder = InputArea;
        infotext.text = [OpenShopInfo shareInstance].SaleAddress;
    }
        
    return cell;
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    switch (textField.tag) {
        case 100:
            
            [OpenShopInfo shareInstance].FoodNum = textField.text;
            break;
        case 101:
            [OpenShopInfo shareInstance].FoodAddress = textField.text;
            break;
        case 102:
            [OpenShopInfo shareInstance].SaleNum = textField.text;
            break;
        case 103:
            [OpenShopInfo shareInstance].SaleAddress = textField.text;
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
            if (toBeString.length > MAX_FoodNum_LENGTH)
            {
                NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:MAX_FoodNum_LENGTH];
                if (rangeIndex.length == 1)
                {
                    textField.text = [toBeString substringToIndex:MAX_FoodNum_LENGTH];
                }
                else
                {
                    NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, MAX_FoodNum_LENGTH)];
                    textField.text = [toBeString substringWithRange:rangeRange];
                }
            }
        }
    }else if (textField.tag == 101) {
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position)
        {
            if (toBeString.length > MAX_ShopAddress_LENGTH)
            {
                NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:MAX_ShopAddress_LENGTH];
                if (rangeIndex.length == 1)
                {
                    textField.text = [toBeString substringToIndex:MAX_ShopAddress_LENGTH];
                }
                else
                {
                    NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, MAX_ShopAddress_LENGTH)];
                    textField.text = [toBeString substringWithRange:rangeRange];
                }
            }
        }
    }else if (textField.tag == 102) {
        if (!position)
        {
            if (toBeString.length > MAX_FoodNum_LENGTH)
            {
                NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:MAX_FoodNum_LENGTH];
                if (rangeIndex.length == 1)
                {
                    textField.text = [toBeString substringToIndex:MAX_FoodNum_LENGTH];
                }
                else
                {
                    NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, MAX_FoodNum_LENGTH)];
                    textField.text = [toBeString substringWithRange:rangeRange];
                }
            }
        }
    }else {
        if (!position)
        {
            if (toBeString.length > MAX_ShopAddress_LENGTH)
            {
                NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:MAX_ShopAddress_LENGTH];
                if (rangeIndex.length == 1)
                {
                    textField.text = [toBeString substringToIndex:MAX_ShopAddress_LENGTH];
                }
                else
                {
                    NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, MAX_ShopAddress_LENGTH)];
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
    self.infoScrollView.frame = CGRectMake(0, Start_Height - keyboardHeight, Screen_Width, ScreenHeight_WithoutBottomBar  );
    
    
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    self.infoScrollView.frame = CGRectMake(0, Start_Height, Screen_Width, ScreenHeight_WithoutBottomBar );
}

- (void)save{
    HideKeyBoard;
    //保存  以上信息为非必填项
    for (int i =0; i<self.imageArr.count ; i++) {
        ZLPhotoPickerBrowserPhoto *photo = [self.imageArr objectAtIndex:i];
        [CommonUtil SaveImageToLocal:[photo.asset thumbImage] Keys:[NSString stringWithFormat:@"%d",i]];

    }
    [OpenShopInfo shareInstance].count = self.imageArr.count;
    [[OpenShopInfo shareInstance] writeToDefaults];
    [self showToast:SaveSuccess];
    [self performSelector:@selector(returnback) withObject:nil afterDelay:1.5];
    
}


- (BOOL)checkinfo {
    if (self.imageArr.count >0) {
        return YES;
    }
    
    
    if (![AvailableString([OpenShopInfo shareInstance].FoodNum) isEqualToString:@""]) {
        return YES;
    }
    if (![AvailableString([OpenShopInfo shareInstance].FoodAddress) isEqualToString:@""]) {
        return YES;
    }
    if (![AvailableString([OpenShopInfo shareInstance].SaleNum) isEqualToString:@""]) {
        return YES;
    }
    if (![AvailableString([OpenShopInfo shareInstance].SaleAddress) isEqualToString:@""]) {
        return YES;
    }
    
    
    return NO;
}

- (void)leftback {
    HideKeyBoard;
    if ([self checkinfo]) {

        //有信息填写了弹窗提示保存
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:AlertMsg_IsSaveInfo preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *saveaction = [UIAlertAction actionWithTitle:AlertBtn_Save style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[OpenShopInfo shareInstance] writeToDefaults];
            [self showToast:SaveSuccess];
             
            [self performSelector:@selector(returnback) withObject:nil afterDelay:1.5];
        }];
        
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:AlertBtn_NoSave style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self returnback];
        }];
        [alert addAction:action];
        [alert addAction:saveaction];
        [self presentViewController:alert animated:YES completion:nil];
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)returnback {
    [self.navigationController popViewControllerAnimated:YES];
}



@end
