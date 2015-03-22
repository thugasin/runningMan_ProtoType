//
//  GameObject.m
//  IphoneMapSdkDemo
//
//  Created by Sirius on 15-3-20.
//  Copyright (c) 2015年 Baidu. All rights reserved.
//

#import "GameObject.h"

#define MYBUNDLE_NAME @ "mapapi.bundle"
#define MYBUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: MYBUNDLE_NAME]
#define MYBUNDLE [NSBundle bundleWithPath: MYBUNDLE_PATH]

#import "BMKGroundOverlayView.h"

@implementation GameObject

@synthesize Coordinate;
@synthesize uID;
@synthesize ImageFileName;
@synthesize State;

+(id) GameObject:(NSString *)bundle mapView:(BMKMapView*) _mapView
{
    return [[self alloc] initObject:bundle mapView:_mapView];
}

- (NSString *)createUUID
{
    // Create universally unique identifier (object)
    CFUUIDRef uuidObject = CFUUIDCreate(kCFAllocatorDefault);
    
    // Get the string representation of CFUUID object.
    NSString *uuidStr = (NSString *)CFUUIDCreateString(kCFAllocatorDefault, uuidObject);
    
    // If needed, here is how to get a representation in bytes, returned as a structure
    // typedef struct {
    //   UInt8 byte0;
    //   UInt8 byte1;
    //   …
    //   UInt8 byte15;
    // } CFUUIDBytes;
    //CFUUIDBytes bytes = CFUUIDGetUUIDBytes(uuidObject);
    
    CFRelease(uuidObject);
    
    return uuidStr;
}

-(id) initObject:(NSString *)bundle mapView:(BMKMapView*) _mapView
{
    if (self == [super init]) {
        uID = [self createUUID];
        ImageFileName = bundle;
        mapView = _mapView;
        State = 1;
    }
    return self;
}

-(void) OnPain
{
    if (State == 1) {
    BMKGroundOverlay* ground = [BMKGroundOverlay groundOverlayWithPosition:Coordinate zoomLevel:mapView.zoomLevel anchor:CGPointMake(0.0f, 0.0f) icon:[UIImage imageWithContentsOfFile:[self getMyBundlePath:ImageFileName ]]];
    [mapView addOverlay:ground];
    }
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

@end
