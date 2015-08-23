//
//  IObserver.h
//  RunningMan_0.2
//
//  Created by Sirius on 15/8/20.
//  Copyright (c) 2015年 Sirius. All rights reserved.
//

#ifndef RunningMan_0_2_IObserver_h
#define RunningMan_0_2_IObserver_h


#endif

@protocol IObserver

-(void) ONMessageCome:(NSString*) MsgBody;

@end

@interface Observer : NSObject<IObserver>

+(id) initObject;

@end

