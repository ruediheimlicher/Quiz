//
//  rSettingsWindowController.h
//  Quiz
//
//  Created by Ruedi Heimlicher on 13.August.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface rSettingsWindowController : NSWindowController < NSTableViewDataSource, NSTableViewDelegate >
{
   IBOutlet id Klassefeld;
   IBOutlet id Nummerfeld;
   IBOutlet NSTableView* IndexTabelle;
   
   NSMutableDictionary* DatenDic;
   NSMutableArray* KlassenArray;
   NSMutableArray* IndexArray;
   
   int stepperWert;
   NSMutableArray *rowData;
   NSPopUpButtonCell*		MusikPop;

  }
@property (nonatomic, readwrite) int nummerWert;
@property (nonatomic, readwrite) int klasseWert;

- (IBAction)reportClose:(id)sender;
- (void)setDaten:(NSDictionary*)datendic;
- (NSDictionary*)datendic;
- (void)updateDaten;


@end
