//
//  rTastenMatrix.m
//  Quiz
//
//  Created by Ruedi Heimlicher on 12.August.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "rTastenMatrix.h"

@implementation rTastenMatrix

- (id)initWithFrame:(NSRect)frame// mitKolonnen:(int)kolonnen mitZeilen:(int)zeilen
{
   self = [super initWithFrame:frame];
   //NSLog(@"init TastenMatrix");
    if (self) 
    {
       //NSLog(@"init TastenMatrix self ok titelschriftgroesse: %d",titelschriftgroesse);
       //NSLog(@"size.height: %2.2f",[self frame].size.height);
       // Create a prototype cell
       NSButtonCell*   prototypeButtonCell = [[NSButtonCell alloc] init];
       
       
       // configure the button cell the way we want
       //[prototypeButtonCell setButtonType:NSRadioButton];
      [prototypeButtonCell setButtonType:NSToggleButton];
       NSImage* bild = [NSImage imageNamed:@"knopficon.png"];
       NSImage* altbild = [NSImage imageNamed:@"okicon.png"];
       
   //    [prototypeButtonCell setImage:bild];
   //    [prototypeButtonCell setAlternateImage:altbild];
       [prototypeButtonCell setImageScaling:NSImageScaleProportionallyDown];
       //[prototypeButtonCell setImagePosition:NSImageBelow];
       // Tell matrix what kind of cell to use
       
       //[prototypeButtonCell setFont:bild];
       [prototypeButtonCell setBackgroundColor:[NSColor blueColor]];
 //      [mutParaStyle setAlignment:NSCenterTextAlignment];
  //     [attrStr addAttributes:[NSDictionary dictionaryWithObject:mutParaStyle forKey:NSParagraphStyleAttributeName] range:NSMakeRange(0,[attrStr length])];

   //    [prototypeButtonCell setAlignment:NSCenterTextAlignment];
       
       [self setPrototype:prototypeButtonCell];

       
       // Set other attributes of matrix
       [self setDrawsBackground:NO];
       [self setAllowsEmptySelection:YES];
       [self setIntercellSpacing:NSMakeSize(10.0f, 4.0f)];
       float cellbreite = ([self frame].size.width );
       [self setCellSize:NSMakeSize(cellbreite, 40.0f)];
       [self setMode:NSRadioModeMatrix];
       
       // Tell the matrix how many rows and columns it has
       [self renewRows:1 columns:1];
       //[self sizeToCells];
       [self  setAutosizesCells:YES];
       [[self superview] setNeedsDisplay:YES];
       //nach readPList
       // Set cell titles
       [[self cellAtRow:0 column:0] setTitle:@"+"];
       //[[self cellAtRow:0 column:1] setTitle:@""];
       //[[self cellAtRow:0 column:2] setTitle:@""];
       //[[self cellAtRow:0 column:3] setTitle:@"weiss nicht"];
       //[[self cellAtRow:4 column:4] setTitle:@"Five"];
       [self setTag:8100];
    }
    
    return self;
}

- (void)setZeilen:(int)zeilen
{
   int kolonnen = [self numberOfColumns];
   //[self setCellSize:NSMakeSize([self frame].size.width, 50)];
   //NSLog(@"setZeilen size.height: %2.2f",[self frame].size.height);
   [self setCellSize:NSMakeSize([self frame].size.width, ([self frame].size.height-6)/zeilen)];
   [self renewRows:zeilen columns:kolonnen];
   [self sizeToCells];
 //  [self setCellSize:NSMakeSize([self frame].size.width, ([self frame].size.height-6)/zeilen)];
//   [self setCellSize:NSMakeSize([self frame].size.width, 40)];

   
   [[self superview] setNeedsDisplay:YES];
   
}

- (void)setKolonnen:(int)kolonnen
{
   int zeilen = [self numberOfRows];
   float cellbreite = ([self frame].size.width )/kolonnen;
   
   [self setCellSize:NSMakeSize(cellbreite, 36.0f)];
   [self renewRows:zeilen columns:kolonnen];

   [self sizeToCells];
   
   int i=0;
   for (i=0;i<[self numberOfColumns];i++)
   {
      
      [self setTitel:@"dieses?" inZeile:0 inKolonne:i];
      [[self cellAtRow:0 column:i]setImagePosition:NSImageLeft];
      [[self cellAtRow:0 column:i]setTag:8100+i];
   }
   [[self superview] setNeedsDisplay:YES];
}

- (void)setTitel:(NSString*)titel inZeile:(int)zeile  inKolonne:(int)kolonne 
{
   NSMutableParagraphStyle *TastenStyle = [NSMutableParagraphStyle new];
   [TastenStyle setAlignment:NSCenterTextAlignment];

   NSAttributedString *attributedString = [[NSAttributedString alloc]
                                           initWithString: titel attributes: [NSDictionary
                                                                              dictionaryWithObjectsAndKeys: [NSColor whiteColor], NSForegroundColorAttributeName,
                                                                              [NSFont fontWithName:@"Lucida Grande" size:24],NSFontAttributeName,
                                                                              
                                                                              TastenStyle,
                                                                              NSParagraphStyleAttributeName,nil]];
   //[style setAlignment:NSCenterTextAlignment];
   //NSDictionary *attr = [NSDictionary dictionaryWithObject:style andKey:@"NSParagraphStyleAttributeName"];
   
   
   [[self cellAtRow:zeile column:kolonne] setAttributedTitle:attributedString];
   [[self superview] setNeedsDisplay:YES];
}

- (void)setStatus:(int)status inZeile:(int)zeile inKolonne:(int)kolonne
{
   [self setState:status atRow:zeile column:kolonne];
     [[self superview] setNeedsDisplay:YES];

}
- (void)drawRect:(NSRect)dirtyRect
{
   [super drawRect:dirtyRect];
}

@end
