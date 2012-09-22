//
//  rErgebnisWindowController.h
//  Quiz
//
//  Created by Ruedi Heimlicher on 13.August.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface rErgebnisWindowController : NSWindowController < NSTableViewDataSource, NSTableViewDelegate >
{
   IBOutlet id Klassefeld;
   IBOutlet id Nummerfeld;
   IBOutlet id Leveltextfeld;
   //IBOutlet NSTableView* IndexTabelle;
   
   NSMutableDictionary* DatenDic;
   NSMutableArray* KlassenArray;
   //NSMutableArray* ErgebnisArray;
   
   int stepperWert;
   NSMutableArray *rowData;
   NSPopUpButtonCell*		MusikPop;
   
   IBOutlet NSTableView*  MasterErgebnistabelle;
   IBOutlet NSTableView*  StandardErgebnistabelle;
   IBOutlet NSTableView*  ExpertErgebnistabelle;
   
   NSMutableArray* StandardErgebnisArray;
   NSMutableArray* MasterErgebnisArray;
   NSMutableArray* ExpertErgebnisArray;

   IBOutlet id Gesamtergebnisfeld;

  }
@property (nonatomic, readwrite) int nummerWert;
@property (nonatomic, readwrite) int klasseWert;

- (IBAction)reportClose:(id)sender;
- (void)setDaten:(NSDictionary*)datendic;
- (NSDictionary*)datendic;
- (void)updateDaten;
- (IBAction)reportKlassestepper:(id)sender;
- (void)clear;

@end
