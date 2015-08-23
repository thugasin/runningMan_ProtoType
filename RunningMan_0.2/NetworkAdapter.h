//
//  NetworkAdapter.h
//  RunningMan_0.2
//
//  Created by Sirius on 15/8/5.
//  Copyright (c) 2015年 Sirius. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsyncSocket.h"
#import "NetworkProtocal.h"
#import "IObserver.h"


@interface SrvMsgSubscriber:NSObject

@property(readwrite)   MessageType MsgType;
@property(readwrite)   Observer* SubscriberInstance;

+(id)InitObject:(MessageType)MT Instance:(Observer*)Ins;
-(id)InternalInit:(MessageType)MT Instance:(Observer*)Ins;

@end


@interface NetworkAdapter : NSObject
{
    AsyncSocket *m_socket;
    NSMutableArray *m_MsgSubscriber;
}


+(id) InitNetwork;
-(id) InitSocket;
-(BOOL) Connect:(NSString*)ipAddress Port:(UInt16)port;
- (void) sendData:(NSString*)Msg;
-(void) SubscribeMessage:(MessageType)MsgType Instance:(Observer*)Ins;
-(void) PublishMessage:(MessageType)MsgType MsgBody:(NSString*)MsgBody;


@end
