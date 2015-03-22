//
//  GameObject.h
//  IphoneMapSdkDemo
//
//  Created by Sirius on 15-3-20.
//  Copyright (c) 2015年 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMapKit.h"

@interface GameObject : NSObject
{
    //CLLocationCoordinate2D objLocation;
    //NSString *uID;
    BMKMapView* mapView;
}

@property (readwrite) CLLocationCoordinate2D Coordinate;
@property (readonly) NSString *uID;
@property (retain) NSString* ImageFileName;
@property  int State;

+(id) GameObject:(NSString*) bundle mapView:(BMKMapView*) _mapView;

-(id) initObject:(NSString *)bundle mapView:(BMKMapView*) _mapView;
-(void) OnPain;
- (NSString*)getMyBundlePath:(NSString *)filename;
- (NSString *)createUUID;

@end
