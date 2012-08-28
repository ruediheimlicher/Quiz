//
//  rRadioMatrix.m
//  Quiz
//
//  Created by Ruedi Heimlicher on 12.August.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "rRadioMatrix.h"

@implementation rRadioMatrix

- (id)initWithFrame:(NSRect)frame// mitKolonnen:(int)kolonnen mitZeilen:(int)zeilen
{
    self = [super initWithFrame:frame];
   //NSLog(@"init RadioMatrix");
    if (self) 
    {
       //NSLog(@"init RadioMatrix self ok");
       // Create a prototype cell
       NSButtonCell*   prototypeButtonCell = [[NSButtonCell alloc] init];
       
       
       // configure the button cell the way we want
       [prototypeButtonCell setButtonType:NSRadioButton];
       NSImage* bild = [NSImage imageNamed:@"knopficon.png"];
       NSImage* altbild = [NSImage imageNamed:@"okicon.png"];
       [prototypeButtonCell setImage:bild];
       [prototypeButtonCell setAlternateImage:altbild];
       [prototypeButtonCell setImageScaling:NSImageScaleProportionallyDown];
       //[prototypeButtonCell setAction:@selector(reportRadiotaste:)];
       [prototypeButtonCell setImagePosition:NSImageBelow];
       // Tell matrix what kind of cell to use
       [self setPrototype:prototypeButtonCell];
       
       // Set other attributes of matrix
       [self setAllowsEmptySelection:NO];
       [self setIntercellSpacing:NSMakeSize(10.0f, 2.0f)];
       float cellbreite = ([self frame].size.width );
       [self setCellSize:NSMakeSize(cellbreite, 36.0f)];
       [self setMode:NSRadioModeMatrix];
       [self setAction:@selector(reportRadiotaste:)];
       // Tell the matrix how many rows and columns it has
       [self renewRows:1 columns:1];
       [self sizeToCells];
       
       [[self superview] setNeedsDisplay:YES];
       
       // Set cell titles
       [[self cellAtRow:0 column:0] setTitle:@"x"];
       //[[self cellAtRow:0 column:1] setTitle:@""];
       //[[self cellAtRow:0 column:2] setTitle:@""];
       //[[self cellAtRow:0 column:3] setTitle:@"weiss nicht"];
       
       //[[self cellAtRow:4 column:4] setTitle:@"Five"];
       
       [[self cellAtRow:0 column:3] setIdentifier:@"-1"];
       
       [self setTag:8000];
       
       float schriftrot = 0.0/255;
       float schriftgruen = 59.0/255;
       float schriftblau = 248.0/255;
       
       Schriftfarbe = [NSColor colorWithCalibratedRed:schriftrot green:schriftgruen blue:schriftblau alpha:1.0];
       Schriftfarbe = [NSColor whiteColor];
       
      	
    }
    
    return self;
}

- (void)setZeilen:(int)zeilen
{
   int kolonnen = [self numberOfColumns];
   [self renewRows:zeilen columns:kolonnen];
   [self sizeToCells];
   [[self superview] setNeedsDisplay:YES];
   
   [self setCellSize:NSMakeSize([self frame].size.width, [self frame].size.height/zeilen)];
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
      [[self cellAtRow:0 column:i]setTag:8000+i];
   }
   [[self superview] setNeedsDisplay:YES];
}

- (void)setTitel:(NSString*)titel inZeile:(int)zeile  inKolonne:(int)kolonne 
{

   NSAttributedString *attributedString = [[NSAttributedString alloc]
                                           initWithString: titel attributes: [NSDictionary
                                                                                       dictionaryWithObjectsAndKeys: Schriftfarbe, NSForegroundColorAttributeName,
                                                                              [NSFont fontWithName:@"Lucida Grande Bold" size:radioschriftgroesse],NSFontAttributeName,
                                                                                                                                                                     nil]];

    [[self cellAtRow:zeile column:kolonne] setAttributedTitle:attributedString];
    [[self superview] setNeedsDisplay:YES];
   
}

- (void)setStatus:(int)status inZeile:(int)zeile inKolonne:(int)kolonne
{
   [self setState:status atRow:zeile column:kolonne];
     [[self superview] setNeedsDisplay:YES];

}

- (void)setErgebniscode:(int)code  inZeile:(int)zeile inKolonne:(int)kolonne
{
   //NSLog(@"+++  Radiomatrix setErgebniscode: %d kolonne: %d",code,kolonne);
   
   [[self cellAtRow:zeile column:kolonne]setTag: code];
   
}

- (void)setKlickInZeile:(int)zeile inKolonne:(int)kolonne
{
   //[[self cellAtRow:kolonne column:zeile]performKlick:NULL];
}

- (int)ergebniscodeInZeile:(int)zeile inKolonne:(int)kolonne
{
   return [[self cellAtRow:zeile column:kolonne]tag];
}

- (IBAction)reportRadiotaste:(id)sender
{
   NSLog(@"reportRadiotaste selectedColumn: %ld",[sender selectedColumn]);
}

- (void)drawRect:(NSRect)dirtyRect
{
   [super drawRect:dirtyRect];
}

@end
