//
//  AppDelegate.h
//  Quiz
//
//  Created by Ruedi Heimlicher on 05.August.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "rRadioMatrix.h"
#import "rTastenMatrix.h"
#import "rSettingsWindowController.h"
#import "rErgebnisWindowController.h"

#define BACH 1
#define MOZART 2
#define PAGANINI 3
#define SCHUBERT 4
#define PURCELL 5
#define SCHUETZ 6
#define BRITTEN 7

#define MUSIK 1
#define FOTO 2
#define NOTEN 3
#define EPOCHEN 4

inline extern int max(a, b) { return a > b ? a : b; }
inline extern int min(a, b) { return a < b ? a : b; }

@interface rTabView: NSTabView
{
   int tagnummer;
   
}
- (void)setTag:(NSInteger)tag;
- (NSInteger)tag;
- (void)commonInit;
@end


@interface AppDelegate : NSObject <NSApplicationDelegate, NSTableViewDataSource, NSTableViewDelegate, NSTabViewDelegate>
{
   IBOutlet id player;
   IBOutlet rRadioMatrix* Klassewahl;
   IBOutlet rTastenMatrix* KlasseTastenwahl;
   IBOutlet rTabView * KlasseTab;
   IBOutlet rTabView *  NummerTab;
   IBOutlet id Playtaste0;
   IBOutlet id Playtaste1;
   IBOutlet id Playtaste2;
   IBOutlet id Prevtaste;
   IBOutlet id Nexttaste;
   IBOutlet id Neutaste;
   IBOutlet id Bild0;
   IBOutlet id Bild1;
   IBOutlet id Bild2;
   IBOutlet NSTableView* Auswahltabelle;
   IBOutlet id Frage;
   IBOutlet id Bildlegende;
   IBOutlet id Klassefeld;
   IBOutlet id Nummerfeld;
   IBOutlet NSTableView*  MasterErgebnistabelle;
   IBOutlet NSTableView*  StandardErgebnistabelle;
   IBOutlet NSTableView*  ExpertErgebnistabelle;
   
   IBOutlet id window;
   
   IBOutlet id AuswahlRadioFeld;
   IBOutlet rRadioMatrix* AuswahlRadio;
   
   NSMutableArray* MusiktitelArray;
   NSMutableArray* MusikArray;
   NSMutableArray* AuswahlArray;
   NSMutableArray* NotenArray;
   NSMutableArray* FotoArray;
   NSMutableArray* EpochenArray;
   NSMutableArray* FragenArray;
   NSMutableArray* IndexArray;
   NSMutableArray* StandardErgebnisArray;
   NSMutableArray* MasterErgebnisArray;
   NSMutableArray* ExpertErgebnisArray;
   NSMutableDictionary* PList;
   NSMutableArray* DefaultArray;
   
   rSettingsWindowController* Settings;
   rErgebnisWindowController* Ergebnis;
   
   NSColor* Schriftfarbe;
   NSColor* Rahmenfarbe;
   
   
    IBOutlet id KontrollFeldA;
   IBOutlet id KontrollFeldB;
   
}

@property (assign) IBOutlet NSWindow *window;

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;



- (IBAction)saveAction:(id)sender;
- (IBAction)reportKlassewahl:(id)sender;
- (IBAction)reportPlaytaste:(id)sender;
- (IBAction)reportNeutaste:(id)sender;
- (IBAction)reportNexttaste:(id)sender;
- (IBAction)reportPrevtaste:(id)sender;
- (IBAction)reportFirsttaste:(id)sender;
- (IBAction)reportHometaste:(id)sender;
- (IBAction)reportFirsttaste:(id)sender;
- (IBAction)reportStoptaste:(id)sender;

- (IBAction)reportRadiotaste:(id)sender;
- (IBAction)reportErgebnisfenster:(id)sender;

- (int)setAuswahl;
- (int)setAuswahlMitVorgabe:(int)vorgabe;

- (void)writePList:(NSDictionary*)plist;
- (int)readPList;
- (IBAction)terminate:(id)sender;

- (int)maxVonArray:(NSArray*)intarray;
- (int)minVonArray:(NSArray*)intarray;

- (IBAction)resetDefaults:(id)sender;

@end
