//
//  rRadioMatrix.h
//  Quiz
//
//  Created by Ruedi Heimlicher on 12.August.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface rRadioMatrix : NSMatrix
{
   NSColor* Schriftfarbe;

}

- (id)initWithFrame:(NSRect)frame mitKolonnen:(int)kolonnen mitZeilen:(int)zeilen;
- (void)setZeilen:(int)zeilen;
- (void)setKolonnen:(int)kolonnen;
- (void)setTitel:(NSString*)titel inZeile:(int)zeile  inKolonne:(int)kolonne;
- (void)setStatus:(int)status inZeile:(int)zeile inKolonne:(int)kolonne;
- (void)setErgebniscode:(int)code  inZeile:(int)zeile inKolonne:(int)kolonne;
- (void)setKlickInZeile:(int)zeile inKolonne:(int)kolonne;
- (int)ergebniscodeInZeile:(int)zeile inKolonne:(int)kolonne;
- (IBAction)reportRadiotaste:(id)sender;
@end
