//
//  LocationDemoViewController.h
//  BaiduMapSdkSrc
//
//  Created by baidu on 13-4-15.
//  Copyright (c) 2013年 baidu. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "BMapKit.h"
#import "GameObject.h"

@interface LocationDemoViewController :  UIViewController <BMKMapViewDelegate,BMKLocationServiceDelegate>{
    IBOutlet BMKMapView* _mapView;
    IBOutlet UIButton* startBtn;

    BMKLocationService* _locService;
    
    bool _isSetMapSpan;
    bool _IsStartLocation;
    int _locationTimes;
    GameObject* Myself;  
    NSMutableArray* beanUidList;
    NSString* str;
    
}

@property(retain) NSMutableDictionary* playerObjectList;

-(IBAction)startLocation:(id)sender;
-(CLLocationCoordinate2D) centercoordination:(CLLocationCoordinate2D)x yCoordination:(CLLocationCoordinate2D)y;
@end

