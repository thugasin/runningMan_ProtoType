//
//  NetworkAdapter.m
//  RunningMan_0.2
//
//  Created by Sirius on 15/8/5.
//  Copyright (c) 2015年 Sirius. All rights reserved.
//

#import "NetworkAdapter.h"

@implementation SrvMsgSubscriber

@synthesize MsgType;
@synthesize SubscriberInstance;

+(id)InitObject:(MessageType)MT Instance:(Observer*)Ins
{
    return [[self alloc] InternalInit:MT Instance:Ins];
}

-(id)InternalInit:(MessageType)MT Instance:(Observer*)Ins
{
    if (self == [super init]) {
        MsgType = MT;
        SubscriberInstance = Ins;
    }
    
    return self;
}

@end

static NetworkAdapter *sharedObj= nil;
@implementation NetworkAdapter

+(NetworkAdapter*) InitNetwork
{
    @synchronized(self)
    {
        if(sharedObj == nil)
        {
            sharedObj = [[self alloc] InitSocket];
        }
        
    }
    return sharedObj;
}


-(id) InitSocket
{
    if (self == [super init]) {
        m_socket = [[AsyncSocket alloc] initWithDelegate:self];
    }
    return self;
}

-(BOOL) Connect:(NSString *)ipAddress Port:(UInt16)port
{
    NSError *err = nil;
    if (![m_socket connectToHost:ipAddress onPort:port withTimeout:10 error:&err]) {
        NSLog(@"connect failed: %@", err);
        return false;
    }
    
    return true;
}

- (void) sendData:(NSString*)Msg
{
    NSData* aData= [Msg dataUsingEncoding: NSUTF8StringEncoding];
    
    [m_socket writeData:aData withTimeout:-1 tag:1];
}
//
//-(void)ontime{
//    
//    [m_socket readDataWithTimeout:-1 tag:0];
//    
//}
//
//
- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"onSocket:%p didConnectToHost:%@ port:%hu", sock, host, port);
    
    [m_socket readDataWithTimeout:-1 tag:0];
}

-(void) onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSString* aStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [self PublishMessage:LOGIN_RESULT MsgBody:aStr];
    
}


-(void) SubscribeMessage:(MessageType)MsgType Instance:(Observer*)Ins
{
    SrvMsgSubscriber *sub = [SrvMsgSubscriber InitObject:MsgType Instance:Ins];
    
    if(m_MsgSubscriber == nil)
    {
        m_MsgSubscriber = [NSMutableArray arrayWithObject:sub];
    }
    else
        [m_MsgSubscriber addObject:sub];
}
-(void) PublishMessage:(MessageType)MsgType MsgBody:(NSString*)MsgBody
{
    for (SrvMsgSubscriber* sub in m_MsgSubscriber)
    {
        if (sub.MsgType != MsgType) {
            continue;
        }
        
        [sub.SubscriberInstance ONMessageCome:MsgBody];
    }
}

//
//- (void)onSocket:(AsyncSocket *)sock didSecure:(BOOL)flag
//{
//    NSLog(@"onSocket:%p didSecure:YES", sock);
//}
//
//- (void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err
//{
//    NSLog(@"onSocket:%p willDisconnectWithError:%@", sock, err);
//    
//    [timer invalidate];
//    timer = nil;
//    
//}
//
//- (void)onSocketDidDisconnect:(AsyncSocket *)sock
//{
//    //?????
//    NSLog(@"onSocketDidDisconnect:%p", sock);
//}
//
//-(void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag
//
//{
//    NSLog(@"thread(%@),onSocket:%p didWriteDataWithTag:%ld",[[NSThread currentThread] name],sock, tag);
//    
//}

@end
