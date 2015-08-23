//
//  ViewController.h
//  RunningMan_0.2
//
//  Created by Sirius on 15/6/15.
//  Copyright (c) 2015年 Sirius. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
#import "AnimatedAnnotation.h"
#import "AnimatedAnnotationView.h"
#import "IObserver.h"

@interface PacManMainGameViewController:UIViewController<MAMapViewDelegate>
{
    MAMapView *_mapView;
}
@property (nonatomic, strong) AnimatedAnnotation *animatedCarAnnotation;
@property (nonatomic, strong) AnimatedAnnotation *animatedTrainAnnotation;

@end

