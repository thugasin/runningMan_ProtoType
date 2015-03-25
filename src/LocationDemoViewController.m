//
//  LocationDemoViewController.m
//  BaiduMapSdkSrc
//
//  Created by baidu on 13-4-15.
//  Copyright (c) 2013年 baidu. All rights reserved.
//
#import "LocationDemoViewController.h"
#define MYBUNDLE_NAME @ "mapapi.bundle"
#define MYBUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: MYBUNDLE_NAME]
#define MYBUNDLE [NSBundle bundleWithPath: MYBUNDLE_PATH]

#import "BMKGroundOverlayView.h"
#import "JSONKit.h"

@implementation LocationDemoViewController

@synthesize playerObjectList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _isSetMapSpan = false;
        _IsStartLocation = false;
        _locationTimes = 0;
            }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.navigationController.navigationBar.translucent = NO;
    }
    _locService = [[BMKLocationService alloc]init];

    
    Myself = [GameObject GameObject:@"" mapView:_mapView];
    playerObjectList = [NSMutableDictionary new];
    
    [playerObjectList setObject:Myself forKey:Myself.uID];
    
    [playerObjectList retain];

}

-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
}
//普通态
-(IBAction)startLocation:(id)sender
{
    NSLog(@"进入普通定位态");
    
    [_locService startUserLocationService];
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
    
    [startBtn setEnabled:NO];
    [startBtn setAlpha:0.6];
    
    BMKCoordinateRegion region;
    
    if (!_isSetMapSpan) {
        region = BMKCoordinateRegionMake(_locService.userLocation.location.coordinate,
                                         BMKCoordinateSpanMake(0.001, 0.001));
        _isSetMapSpan = true;
        [_mapView setRegion:region animated:YES];
        
    }
    
    


    BMKLocationViewDisplayParam *displayParam = [[BMKLocationViewDisplayParam alloc]init];
    displayParam.isRotateAngleValid = true;// 跟随态旋转角度是否生效
    displayParam.isAccuracyCircleShow = false;// 精度圈是否显示
    displayParam.locationViewImgName = @"icon_center_point";// 定位图标名称
    displayParam.locationViewOffsetX = 0;//定位图标偏移量(经度)
    displayParam.locationViewOffsetY = 0;// 定位图标偏移量（纬度）
    [_mapView updateLocationViewWithParam:displayParam]; //调用此方法后自定义定位图层生效
    
    
    [displayParam release];

    
}


/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)willStartLocatingUser
{
	NSLog(@"start locate");
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    NSLog(@"heading is %@",userLocation.heading);
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
//    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [_mapView updateLocationData:userLocation];
    int a =playerObjectList.count;
        [_mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
    
        
        CLLocationCoordinate2D coors;
//        coors.latitude = userLocation.location.coordinate.latitude;
//        coors.longitude = userLocation.location.coordinate.longitude;
        
        Myself.Coordinate = userLocation.location.coordinate;
    
    if (_locationTimes < 2) {
        _locationTimes++;
    }
    
     if(!_IsStartLocation && _locationTimes == 2){
        
        BMKGroundOverlay* ground = [BMKGroundOverlay groundOverlayWithPosition:coors zoomLevel:_mapView.zoomLevel anchor:CGPointMake(0.0f, 0.0f) icon:[UIImage imageWithContentsOfFile:[self getMyBundlePath:@"images/pac.png"]]];
        [_mapView addOverlay:ground];
    
         _IsStartLocation = true;
    }

    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterNoStyle;
    
    NSNumber * latitudeNumber = [NSNumber numberWithLongLong:Myself.Coordinate.latitude*pow(10, 14)];
    NSString *stringLatitude = [formatter stringFromNumber:latitudeNumber];
    
    NSNumber * longitudeNumber = [NSNumber numberWithLongLong:Myself.Coordinate.longitude*pow(10, 14)];
    NSString *stringLongitude = [formatter stringFromNumber:longitudeNumber];
    
    [formatter release];
    
    NSString *urlString =@"http://192.168.1.105:10000/player/report?id=";
    NSString *lonString = @"&longitude=";
    NSString *laString =@"&latitude=";
    NSString *postString = [[NSString alloc]initWithFormat:@"%@%@%@%@%@%@", urlString ,Myself.uID,lonString, stringLongitude,laString,stringLatitude];
    
    NSURL *url = [NSURL URLWithString:postString];
    
    [postString release];
    
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    
    NSHTTPURLResponse *response;
    NSError * errorMsg;
    NSData *returnData = [NSURLConnection sendSynchronousRequest:req returningResponse:&response error:&errorMsg];
    
    NSString *strReturn = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    
    NSDictionary *retData = [strReturn objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
    NSDictionary *playerData = [retData objectForKey:@"players"];
    
    for (unsigned int i=0; i<playerData.count; i++)
    {
        NSString *id = [[[retData objectForKey:@"players"] objectAtIndex:i] objectForKey:@"id"];
        if (id == Myself.uID) {
            continue;
        }
        
        if (playerObjectList.count ==0 || [playerObjectList objectForKey:id] == nil)
        {
            GameObject *newPlayer = [GameObject GameObject:@"images/icon_center_point.png" mapView:_mapView];
            [playerObjectList setObject:newPlayer forKey:newPlayer.uID];
            CLLocationCoordinate2D coor;
            
            NSString *strLatitude = [[[retData objectForKey:@"players"] objectAtIndex:i] objectForKey:@"latitude"];
            NSString *strLongitude = [[[retData objectForKey:@"players"] objectAtIndex:i] objectForKey:@"longitude"];
            
            
            coor.latitude = [strLatitude longLongValue]*pow(10, -14);
            coor.longitude = [strLongitude longLongValue]*pow(10, -14);
            newPlayer.Coordinate = coor;
            [newPlayer OnPain];
        }

    }
}

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
}

- (NSString*)getMyBundlePath:(NSString *)filename
{
	
	NSBundle * libBundle = MYBUNDLE ;
	if ( libBundle && filename ){
		NSString * s=[[libBundle resourcePath ] stringByAppendingPathComponent : filename];
		return s;
	}
	return nil ;
}

- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay
{
    if ([overlay isKindOfClass:[BMKGroundOverlay class]])
    {
        BMKGroundOverlayView* groundView = [[[BMKGroundOverlayView alloc] initWithOverlay:overlay] autorelease];
		return groundView;
    }
	return nil;
}


- (void)dealloc
{
    if (_mapView)
    {
        _mapView = nil;
    }
    [playerObjectList release];
}

@end
