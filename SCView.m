//
//  SCView.m
//  SC
//
//  Created by Simon Fransson on 2010-05-03.
//  Copyright (c) 2010, Hobo Code. All rights reserved.
//

#import "SCView.h"

#define NSColorFromRGB(rgbValue) \
[NSColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]

@implementation SCView


- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
		self.backgroundColor = [NSColor clearColor];
		
		NSString *bundleIdentifier = [[NSBundle bundleForClass:[self class]] infoDictionary][@"CFBundleIdentifier"];
		self.defaults = [ScreenSaverDefaults defaultsForModuleWithName:bundleIdentifier];
		
        self.timeFont = [NSFont fontWithName:@"HelveticaNeue-Light" size:172.0];
        self.colorFont = [NSFont fontWithName:@"HelveticaNeue-UltraLight" size:48.0];
		
		self.timeDrawingAttributes = @{NSFontAttributeName: self.timeFont,
								   NSForegroundColorAttributeName: [NSColor whiteColor]};
		
		self.colorDrawingAttributes = @{NSFontAttributeName: self.colorFont,
										 NSForegroundColorAttributeName: [NSColor lightGrayColor]};
        
        
        self.timeFormatter = [[NSDateFormatter alloc] init];
        self.colorFormatter = [[NSDateFormatter alloc] init];
        
        [self.timeFormatter setDateFormat:@"HH : mm : ss"];
        [self.colorFormatter setDateFormat:@"#HHmmss"];
    
        [self setAnimationTimeInterval:0.5];
    }
	
    return self;
}

- (void)startAnimation
{
    [super startAnimation];
}

- (void)stopAnimation
{
    [super stopAnimation];
}

- (void)animateOneFrame
{
    NSDate *date = [NSDate date];
    
	self.timeString = [self.timeFormatter stringFromDate:date];
    self.colorString = [self.colorFormatter stringFromDate:date];
	
    unsigned hex_color = 0;
    NSScanner *scanner = [NSScanner scannerWithString:self.colorString];
    
    [scanner setScanLocation:1];
    [scanner scanHexInt:&hex_color];
    
    self.backgroundColor = NSColorFromRGB(hex_color);
    
	[self setNeedsDisplay:YES];
}

- (void)drawRect:(NSRect)rect
{
	[self.backgroundColor set];
	[self.timeFont set];
	
	NSRectFill(rect);
	
	NSSize timeSize = [self.timeString sizeWithAttributes:self.timeDrawingAttributes];
	NSSize colorSize = [self.colorString sizeWithAttributes:self.colorDrawingAttributes];
    
	NSRect timeRect = NSMakeRect((rect.size.width - timeSize.width) / 2.0,
									rect.size.height * 0.5,
									timeSize.width,
									timeSize.height);

	NSRect colorRect = NSMakeRect((rect.size.width - colorSize.width) / 2.0,
									rect.size.height * 0.3,
									colorSize.width,
									colorSize.height);
	
    
	[self.timeString drawInRect:timeRect withAttributes:self.timeDrawingAttributes];
    [self.colorString drawInRect:colorRect withAttributes:self.colorDrawingAttributes];
}

- (BOOL)hasConfigureSheet
{
    return NO;
}

- (NSWindow *)configureSheet
{
    return nil;
}


@end
