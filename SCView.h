//
//  SCView.h
//  SC
//
//  Created by Simon Fransson on 2010-05-03.
//  Copyright (c) 2010, Hobo Code. All rights reserved.
//

#import <ScreenSaver/ScreenSaver.h>


@interface SCView : ScreenSaverView 
{

}

@property (strong)	NSColor					*backgroundColor;
@property (strong)	NSFont					*timeFont;
@property (strong)	NSFont					*colorFont;
@property (strong)	NSDictionary			*timeDrawingAttributes;
@property (strong)	NSDictionary			*colorDrawingAttributes;
@property (copy)	NSString				*timeString;
@property (copy)	NSString				*colorString;
@property (strong)	ScreenSaverDefaults		*defaults;

@property (strong)  NSDateFormatter         *timeFormatter;
@property (strong)  NSDateFormatter         *colorFormatter;

@end
