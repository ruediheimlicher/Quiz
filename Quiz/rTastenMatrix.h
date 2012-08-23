//
//  rTastenMatrix.h
//  Quiz
//
//  Created by Ruedi Heimlicher on 12.August.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface rTastenMatrix : NSMatrix
- (id)initWithFrame:(NSRect)frame;// mitKolonnen:(int)kolonnen mitZeilen:(int)zeilen;
- (void)setZeilen:(int)zeilen;
- (void)setKolonnen:(int)kolonnen;
- (void)setTitel:(NSString*)titel inZeile:(int)zeile  inKolonne:(int)kolonne;
- (void)setStatus:(int)status inZeile:(int)zeile inKolonne:(int)kolonne;
@end
