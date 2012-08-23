//
//  AppDelegate.m
//  Quiz
//
//  Created by Ruedi Heimlicher on 05.August.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import <QTKit/QTKit.h>

@implementation rTabView

- (id)initWithFrame:(NSRect)frame
{
   NSLog(@"rTabview init");
   self = [super initWithFrame:frame];
if (self)
{
   [self commonInit];
   return self;
}
   return NULL;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
   //NSLog(@"rTabview coder");
   self = [super initWithCoder:aDecoder];
   if (self)
   {
      [self commonInit];
      return self;
   }
   return NULL;
}

- (void)commonInit 
{
   tagnummer = 3;
}


- (void)setTag:(NSInteger)tag
{
   [self setTag:tag];
}

- (NSInteger)tag
{
   return [self tag];
}

@end


@implementation AppDelegate

@synthesize window = _window;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize managedObjectContext = __managedObjectContext;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
   // Insert code here to initialize your application
   float schriftrot = 82;
   float schriftgruen = 95;
   float schriftblau = 224;
   
   Schriftfarbe = [NSColor colorWithCalibratedRed:schriftrot green:schriftgruen blue:schriftblau alpha:0.5];

   schriftgroesse = 20;
   
   
   
   NSImage* myImage = [NSImage imageNamed: @"choricon"];
   if (myImage)
   {
      [NSApp setApplicationIconImage: myImage];
   }
   else {
      NSLog(@"kein Icon");
   }

   
   NSImageView* Hintergrund;
   //[Hintergrund setImage:[NSImage imageNamed:@"Bach.jpg"]];
   //[Bild1 setImage:[NSImage imageNamed:@"Bach.jpg"]];
   //[[self window] setContentView:Hintergrund];
   //[[self window] setBackgroundColor:[NSColor colorWithPatternImage:[NSImage imageNamed:@"Paganini.jpg."]]];
   //[[self window] setBackgroundColor:[NSColor blueColor]];
   
   // http://www.osxentwicklerforum.de/index.php?page=Thread&threadID=14646
   // Start with a white background image the same size as the window.
   NSSize backgroundSize = [[self window] frame].size;
   //NSSize backgroundSize = [KlasseTab frame].size;
   NSImage *backgroundImage = [[NSImage alloc] initWithSize:backgroundSize];
   
   NSRect backgroundRect = NSMakeRect(0,0,[backgroundImage size].width,
                                      [backgroundImage size].height);
   
   // Load whatever object will be in the center into an NSImage.
   NSImage *objectImage = [NSImage imageNamed:@"Kirche_288.jpg"];  
   
   // Find the point at which to draw the object.
   NSPoint backgroundCenter;
   backgroundCenter.x = backgroundRect.size.width / 2;
   backgroundCenter.y = backgroundRect.size.height / 2;
   
   NSPoint drawPoint = backgroundCenter;
   drawPoint.x -= [objectImage size].width / 2;
   drawPoint.y -= [objectImage size].height / 2;
   
   // Fill the background with a color and draw the object on top of it.
   [backgroundImage lockFocus];
   [[NSColor yellowColor] set];
   NSRectFill(backgroundRect);
   [objectImage drawAtPoint:drawPoint
                   fromRect:NSZeroRect
                  operation:NSCompositeSourceOver
                   fraction:1.0];
   [[NSColor colorWithCalibratedWhite:0.95 alpha:0.5] set];
   NSRectFillUsingOperation(backgroundRect,NSCompositeSourceOver);
   
   [backgroundImage unlockFocus];
   
   // Set our background image as the window's background color.
   [[self window] setBackgroundColor:
    [NSColor colorWithPatternImage:backgroundImage]];
   
   // Release the image.
   //[backgroundImage release];
   
   NSImage *AuswahlImage = [NSImage imageNamed:@"Kirche_288.jpg"]; 
   //  [[KlasseTab view]setImage:AuswahlImage];
   
   NSNotificationCenter * nc;
	nc=[NSNotificationCenter defaultCenter];
	[nc addObserver:self
          selector:@selector(SettingDatenAktion:)
              name:@"SettingsDaten"
            object:nil];

   
   AuswahlArray = [[NSMutableArray alloc]initWithCapacity:0];
   MusikArray = [[NSMutableArray alloc]initWithCapacity:0];
   MusiktitelArray = [[NSMutableArray alloc]initWithCapacity:0];
   NotenArray = [[NSMutableArray alloc]initWithCapacity:0];
   FotoArray = [[NSMutableArray alloc]initWithCapacity:0];
   EpochenArray = [[NSMutableArray alloc]initWithCapacity:0];
   FragenArray = [[NSMutableArray alloc]initWithCapacity:0];
   IndexArray = [[NSMutableArray alloc]initWithCapacity:0];
   PList = [[NSMutableDictionary alloc]initWithCapacity:0];
   StandardErgebnisArray = [[NSMutableArray alloc]initWithCapacity:0];
   MasterErgebnisArray = [[NSMutableArray alloc]initWithCapacity:0];
   ExpertErgebnisArray = [[NSMutableArray alloc]initWithCapacity:0];
   
   [Klassewahl setKolonnen:1];
   [Klassewahl setZeilen:3];
   [Klassewahl setTitel:@"Standard" inZeile:0 inKolonne:0];
   [Klassewahl setTitel:@"Master" inZeile:1 inKolonne:0];
   [Klassewahl setTitel:@"Expert" inZeile:2 inKolonne:0];
   [Klassewahl setStatus:1 inZeile:1 inKolonne:0];
   [Klassewahl setNeedsDisplay:YES];

  // [KlasseTastenwahl setKolonnen:1];
   [KlasseTastenwahl setZeilen:3];
   [KlasseTastenwahl setTitel:@"Standard" inZeile:0 inKolonne:0];
   [KlasseTastenwahl setTitel:@"Master" inZeile:1 inKolonne:0];
   [KlasseTastenwahl setTitel:@"Expert" inZeile:2 inKolonne:0];
   [KlasseTastenwahl setStatus:1 inZeile:1 inKolonne:0];
   [KlasseTastenwahl setNeedsDisplay:YES];

   [StandardErgebnistabelle setDelegate:self];
   [StandardErgebnistabelle setDataSource:self];
   [MasterErgebnistabelle setDelegate:self];
   [MasterErgebnistabelle setDataSource:self];
   [ExpertErgebnistabelle setDelegate:self];
   [ExpertErgebnistabelle setDataSource:self];
   
   [NummerTab setDelegate:self];
   
   [Prevtaste setEnabled:NO];
   
   //NSLog(@"bundlePath: %@",[[NSBundle mainBundle]bundlePath]);
   NSString* ResourcenPfad=[[[NSBundle mainBundle]bundlePath]stringByAppendingPathComponent:@"Contents/Resources"];
   NSFileManager *Filemanager=[NSFileManager defaultManager];
   NSString* FilePfad=[[[NSBundle mainBundle]bundlePath]stringByAppendingPathComponent:@"Contents"];
   
   NSArray* tempInhaltArray=[Filemanager contentsOfDirectoryAtPath:FilePfad error:NULL];
   ;
   //NSLog(@"\n  files roh: \n%@",[tempInhaltArray description]);
   
   
   NSArray* tempFileArray=[Filemanager contentsOfDirectoryAtPath:ResourcenPfad error:NULL];
   ;
   NSLog(@"\n  tempFileArray roh: \n%@",[tempFileArray description]);
   int i=0;
   
   /*
    http://stackoverflow.com/questions/4394968/how-to-make-qtmovie-play-file-from-url-with-forced-mp3-type
    NSURL *mp3URL = [NSURL URLWithString:@"http://foo.com/bar"];
    NSData *mp3Data = [NSData dataWithContentsOfURL:mp3URL];
    
    QTDataReference *dataReference = 
    [QTDataReference dataReferenceWithReferenceToData:mp3Data
    name:@"bar.mp3"
    MIMEType:nil];
    NSError *error = nil;
    QTMovie *sound = [[QTMovie alloc] initWithDataReference:dataReference error:&error];
    [sound play];
    */
   
    for(i=0;i<[KlasseTab numberOfTabViewItems];i++)
    {
      // [MasterErgebnisArray addObject:[[NSMutableArray alloc]initWithCapacity:0]];
    }
   
   
   for(i=0;i<[tempFileArray count];i++)
   {
      NSString* tempPfad = [tempFileArray objectAtIndex:i];
      NSArray* tempPfadArray = [tempPfad componentsSeparatedByString:@"."];
      //NSLog(@"tempPfadArray raw: %@ count: %d",[tempPfadArray description],[tempPfadArray count]);
      NSMutableDictionary* tempDataDic = [[NSMutableDictionary alloc]initWithCapacity:0];
      
      NSString* tempName;
      if ([tempPfadArray count]>5)
      {
         NSArray* tempNamenArray = [tempPfadArray subarrayWithRange:NSMakeRange(4, [tempPfadArray count]-5)];
         tempName= [[tempPfadArray subarrayWithRange:NSMakeRange(4, [tempPfadArray count]-5)]componentsJoinedByString:@"."];
         //NSLog(@"tempName A: %@",[tempNamenArray componentsJoinedByString:@"."]);
         
         NSNumber* artnumber = [NSNumber numberWithInt:[[tempPfadArray objectAtIndex:0]intValue]];
         NSNumber* autornumber = [NSNumber numberWithInt:[[tempPfadArray objectAtIndex:1]intValue]];
         NSNumber* epochenumber = [NSNumber numberWithInt:[[tempPfadArray objectAtIndex:2]intValue]];
         //NSLog(@"tempName A: %@ epoche: %d",[tempNamenArray componentsJoinedByString:@"."],[[tempPfadArray objectAtIndex:2]intValue]);
         NSNumber* indexnumber = [NSNumber numberWithInt:[[tempPfadArray objectAtIndex:3]intValue]];
         
         
         [tempDataDic setObject:artnumber forKey:@"art"];
         [tempDataDic setObject:autornumber forKey:@"autor"];
         [tempDataDic setObject:epochenumber forKey:@"epoche"];
         [tempDataDic setObject:indexnumber forKey:@"index"];
         
      }
      else 
      {
         tempName = [[tempPfadArray subarrayWithRange:NSMakeRange(0, [tempPfadArray count]-2)]componentsJoinedByString:@"."];;      
      //NSLog(@"tempName B: %@",tempName);
      }
      
      // Fragen lesen
      if ([tempPfad hasSuffix:@"txt"])
      {
         //NSLog(@"Text da: tempPfad: %@",tempPfad);
         NSString* tempFragenPfad=[[NSBundle mainBundle] pathForResource:tempPfad ofType:NULL];
         //NSLog(@"Text da: tempFragenPfad: %@",tempFragenPfad);
         
         NSString* tempFragenString=[NSString stringWithContentsOfFile:tempFragenPfad encoding: NSUTF8StringEncoding error:NULL];
         ;
         
         //NSLog(@"  tempFragenString : \n%@",tempFragenString);
         NSArray* tempFragenArray = [tempFragenString componentsSeparatedByString:@"\n"];
         //NSLog(@"  tempFragenArray : \n%@",tempFragenArray);
         int k=0;
         for (k=0;k<[tempFragenArray count];k++)
         {
            NSArray* tempZeilenArray = [[tempFragenArray objectAtIndex:k] componentsSeparatedByString:@"\t"];
            //NSLog(@"  tempZeilenArray : \n%@ count: %lu",[tempZeilenArray description], [tempZeilenArray count]);
            if ([tempZeilenArray count] == 3) // Fragezeile komplett
            {
               NSNumber* klassenumber = [NSNumber numberWithInt:[[tempZeilenArray objectAtIndex:0]intValue]];
               NSNumber* nummernumber = [NSNumber numberWithInt:[[tempZeilenArray objectAtIndex:1]intValue]];
               
               NSDictionary* tempFragenDic = [NSDictionary dictionaryWithObjectsAndKeys:klassenumber,@"klasse",nummernumber,@"nummer",[tempZeilenArray objectAtIndex:2],@"frage", nil];
               [FragenArray addObject:tempFragenDic];
               //[Frage setStringValue:[tempZeilenArray objectAtIndex:2]];
            }
            
         }
      }
      
      
      switch ([[tempPfadArray objectAtIndex:0]intValue]) // Art
      {
         case 001: // sound
         {
            //[tempDataDic setObject:[tempPfadArray objectAtIndex:1] forKey:@"autor"];
            NSString* tempSoundPfad=[[NSBundle mainBundle] pathForResource:tempPfad ofType:nil];
            //NSLog(@"tempName sound: %@",tempName);
            [tempDataDic setObject:tempName forKey:@"name"];
            
            [MusiktitelArray addObject:tempName];
            NSURL *	tempmovieUrl = [NSURL fileURLWithPath:tempSoundPfad];
            
            NSError* ladefehler = [[NSError alloc]initWithDomain:QTKitErrorDomain code:1 userInfo:[NSDictionary dictionaryWithObject:tempSoundPfad forKey:@"ich"]];
            QTMovie *tempQTMovie = [[QTMovie alloc] initWithURL:tempmovieUrl error:&ladefehler];
            if (ladefehler)
            {
               NSAlert *theAlert = [NSAlert alertWithError:ladefehler];
               [theAlert runModal]; // Ignore return value.
               NSLog(@"ladefehler: %@",[ladefehler  description]);
               NSLog(@"ladefehler userInfo: %@",[[ladefehler userInfo] description]);
            }
            
            [tempQTMovie setAttribute:[NSNumber numberWithBool:YES] forKey:QTMovieOpenForPlaybackAttribute];
            [tempQTMovie setAttribute:[NSNumber numberWithBool:YES] forKey: @"QTMovieLoopsAttribute"];
            
            [tempDataDic setObject:tempQTMovie forKey:@"sound"];
            
            [MusikArray addObject:tempDataDic];
            
             
         }break;
            
         case 002: // Foto
         {
            //NSLog(@"tempPfadArray foto: %@ count: %d",[tempPfadArray description],[tempPfadArray count]);
            [tempDataDic setObject:tempPfad forKey:@"fotopfad"];
            tempName= [[tempPfadArray subarrayWithRange:NSMakeRange(4, [tempPfadArray count]-5)]componentsJoinedByString:@"."];
            [tempDataDic setObject:tempName forKey:@"name"];
            //[tempDataDic setObject:[tempPfadArray objectAtIndex:1] forKey:@"autor"];
            
            NSImage* bild = [NSImage imageNamed:tempPfad];
            if (bild)
            {
               [tempDataDic setObject:bild forKey:@"bild"];
               [FotoArray addObject:tempDataDic];
            }
            else {
               NSLog(@"kein bild: %@",[tempPfadArray objectAtIndex:[tempPfadArray count]-1]);
            }
         }break;
            
         case 003: // Noten
         {
            [tempDataDic setObject:tempPfad forKey:@"notenpfad"];
            
            tempName= [[tempPfadArray subarrayWithRange:NSMakeRange(4, [tempPfadArray count]-5)]componentsJoinedByString:@"."];
            //NSLog(@"tempPfadArray noten: %@ count: %d tempName: %@",[tempPfadArray description],[tempPfadArray count],tempName);
            
            [tempDataDic setObject:tempName forKey:@"name"];
            NSImage* bild = [NSImage imageNamed:tempPfad];
            [tempDataDic setObject:bild forKey:@"bild"];
            [NotenArray addObject:tempDataDic];
            
         }break;
            
         case 004: // Epochen
         {
            [tempDataDic setObject:tempPfad forKey:@"epochenpfad"];
            
            tempName= [[tempPfadArray subarrayWithRange:NSMakeRange(4, [tempPfadArray count]-5)]componentsJoinedByString:@"."];
            //NSLog(@"tempPfadArray epochen: %@ count: %d",[tempPfadArray description],[tempPfadArray count]);
            //NSLog(@"tempName epochen: %@",tempName);
            [tempDataDic setObject:tempName forKey:@"name"];
            NSImage* bild = [NSImage imageNamed:tempPfad];
            [tempDataDic setObject:bild forKey:@"bild"];
            [EpochenArray addObject:tempDataDic];
            
         }break;
            
            
            
      }// switch
      
   } // for i tempFileArray
   
   
   
   
   // "weiss nicht"-Zeile einfuegen
   NSMutableDictionary* tempAuswahlDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:1],@"eins",[NSNumber numberWithInt:1],@"zwei",[NSNumber numberWithInt:1],@"drei", @"weiss nicht",@"name",nil];
   
//   [AuswahlArray addObject:tempAuswahlDic];
//   NSLog(@"MusikArray: %@",[MusikArray description]);
   //NSLog(@"FotoArray: %@",[FotoArray description]);
//   NSLog(@"NotenArray: %@",[NotenArray description]);
//   NSLog(@"EpochenArray: %@",[EpochenArray description]);
   
   //NSLog(@"AuswahlArray: %@",[AuswahlArray description]);
   //NSLog(@"MusiktitelArray: %@",[MusiktitelArray description]);
   //NSLog(@"App FragenArray name: %@",[FragenArray valueForKey:@"name"]);
   
   //  [Auswahltabelle setDelegate:self];
   //  [Auswahltabelle setDataSource:self];
   //  [Auswahltabelle setBackgroundColor:[NSColor clearColor]];
   [KlasseTab selectTabViewItemAtIndex:0];
   
   [Klassefeld setStringValue:@""];
   [Nummerfeld setStringValue:@""];
   NSRect f = [AuswahlRadioFeld frame];
   //NSLog(@"frame b: %2.2f h: %2.2f",f.size.width,f.size.height);
   // AuswahlRadio = [[rRadioMatrix alloc]initWithFrame:f mitKolonnen:3 mitZeilen:1];
   //   [AuswahlRadio setKolonnen:3];
   //   [AuswahlRadio setTitel:@"weiss nicht" inZeile:0 inKolonne:2];
   //   [AuswahlRadio setStatus:1 inZeile:0 inKolonne:2];
   //  [AuswahlRadio setNeedsDisplay:YES];
   [KlasseTab selectTabViewItemAtIndex:0];
   
   if ([self readPList])
   {
      
   }
   else
   {
      // IndexArray einrichten. Array fuer jede Klasse mit Array fuer jede Nummer
      NSMutableArray* tempKlassenArray = [[NSMutableArray alloc]initWithCapacity:0];
      
      int klassenindex=0;
      int nummerindex=0;
      for (klassenindex=0;klassenindex<[KlasseTab numberOfTabViewItems]; klassenindex++) 
      {
         //[tempNummerDic setObject:FragenArray forKey:@"fragenarray"];

         NSMutableArray* tempNummerArray = [[NSMutableArray alloc]initWithCapacity:0];
         for (nummerindex=0; nummerindex<[NummerTab numberOfTabViewItems]; nummerindex++)
         {
            //NSLog(@"klassenindex: %d nummerindex: %d",klassenindex,nummerindex);
            
            
            switch (klassenindex)
            {
               case 2:
               {
                  
                  NSMutableIndexSet* epochenindex = [NSMutableIndexSet indexSet];
                  NSMutableIndexSet* notenindex = [NSMutableIndexSet indexSet];
                  NSMutableIndexSet* fotoindex = [NSMutableIndexSet indexSet];
                  NSMutableIndexSet* musikindex = [NSMutableIndexSet indexSet];

                  NSMutableDictionary* tempNummerDic = [[NSMutableDictionary alloc]initWithCapacity:0];
                  [tempNummerDic setObject:[FragenArray objectAtIndex:nummerindex] forKey:@"frage1"];
                  //NSLog(@"[FragenArray objectAtIndex:nummerindex objectForKey:frage: %@",[[FragenArray objectAtIndex:nummerindex]objectForKey:@"frage"]);
                  [tempNummerDic setObject:[[FragenArray objectAtIndex:nummerindex]objectForKey:@"frage"]forKey:@"frage"];

                  switch (nummerindex)
                  {
                     case 0:
                     {
                        // Autoren waehlen
                        //[fotoindex addIndex:PAGANINI];
                        //[fotoindex addIndex:BACH];
                        [fotoindex addIndex:SCHUETZ];
                        
                        // Noten
                        [notenindex addIndex:BACH];
                        //[notenindex addIndex:SCHUBERT];
                        //[notenindex addIndex:PAGANINI];
                        [notenindex addIndex:SCHUETZ];
                        
                        // Musik
                        [musikindex addIndex:BACH];
                        //[musikindex addIndex:SCHUBERT];
                        //[musikindex addIndex:PAGANINI];
                        [musikindex addIndex:SCHUETZ];
                        
                        // Epoche 
                        //[epochenindex addIndex:1];
                        [epochenindex addIndex:1];
                        
                     }break;
                        
                     case 1:
                     {
                        // Autoren waehlen
                        [fotoindex addIndex:SCHUBERT];
                        [fotoindex addIndex:BACH];
                        
                        // Noten
                        //[notenindex addIndex:BACH];
                        [notenindex addIndex:SCHUBERT];
                        
                        // Musik
                        //[musikindex addIndex:BACH];
                        [musikindex addIndex:SCHUBERT];
                        
                        // Epoche 
                        [epochenindex addIndex:1];
                        //[epochenindex addIndex:2];
                        
                     }break;
                        
                     case 2:
                     {
                        // Autoren waehlen
                        [fotoindex addIndex:MOZART];
                        [fotoindex addIndex:BACH];
                        
                        // Noten
                        [notenindex addIndex:BACH];
                        [notenindex addIndex:MOZART];
                        
                        // Musik
                        [musikindex addIndex:BACH];
                        [musikindex addIndex:MOZART];
                        
                        // Epoche 
                        //[epochenindex addIndex:1];
                        [epochenindex addIndex:2];
                        
                     }break;
                        
                     case 3:
                     {
                        // Autoren waehlen
                        [fotoindex addIndex:BACH];
                        [fotoindex addIndex:PAGANINI];
                        
                        // Noten
                        [notenindex addIndex:BACH];
                        [notenindex addIndex:PAGANINI];
                        
                        // Musik
                        [musikindex addIndex:BACH];
                        [musikindex addIndex:PAGANINI];
                        
                        // Epoche 
                        //[epochenindex addIndex:1];
                        [epochenindex addIndex:3];
                        
                     
                     
                     }break;
                        
                  
                     case 4:
                     {
                        // Autoren waehlen
                        //[fotoindex addIndex:BACH];
                        [fotoindex addIndex:PAGANINI];
                        
                        // Noten
                        //[notenindex addIndex:BACH];
                        [notenindex addIndex:PAGANINI];
                        
                        // Musik
                       // [musikindex addIndex:BACH];
                        [musikindex addIndex:PAGANINI];
                        
                        // Epoche 
                        [epochenindex addIndex:1];
                        [epochenindex addIndex:4];
                        
                        
                        
                     }break;
                      
                     case 5:
                     {
                        // Autoren waehlen
                        [fotoindex addIndex:BACH];
                        [fotoindex addIndex:PAGANINI];
                        
                        // Noten
                        [notenindex addIndex:BACH];
                        [notenindex addIndex:PAGANINI];
                        
                        // Musik
                        [musikindex addIndex:BACH];
                        [musikindex addIndex:PAGANINI];
                        
                        // Epoche 
                        //[epochenindex addIndex:3];
                        [epochenindex addIndex:4];
                        
                        
                        
                     }break;
                        
                        

                        

                  }// switch nummerindex
                  [tempNummerDic setObject:[NSNumber numberWithInt:nummerindex] forKey:@"nummer"];
                  [tempNummerDic setObject:[NSNumber numberWithInt:klassenindex] forKey:@"klasse"];
                  [tempNummerDic setObject:fotoindex forKey:@"fotoindex"];
                  [tempNummerDic setObject:notenindex forKey:@"notenindex"];
                  [tempNummerDic setObject:musikindex forKey:@"musikindex"];
                  [tempNummerDic setObject:epochenindex forKey:@"epochenindex"];
                  //NSLog(@"*** tempNummerDic: %@",[tempNummerDic description]);
                  [tempNummerArray addObject:tempNummerDic];
                  
                  //NSLog(@"tempNummerArray: %@",[tempNummerArray description]);
                    
               }break; // case 2
                  
            }// switch klassenindex
         }
         [tempKlassenArray addObject: tempNummerArray];
      }
      //NSLog(@"*** tempKlassenArray: %@",[tempKlassenArray description]);
      [PList setObject:tempKlassenArray forKey:@"klassenarray"];
   }// keine PList
   //NSLog(@"Settings: %@",[PList description]);
   
   
}

- (IBAction)reportPlaytaste:(id)sender
{
   if ([[player movie]rate])
   {
      [[player movie]stop];
   }
   //NSLog(@"reportPlaytaste subviews: %ld tag: %ld array: %@ ",[[[sender superview]subviews]count],[sender tag],[[[sender superview]subviews]description]);
   
   NSString* identifierstring = [sender identifier];
   int ident = [identifierstring intValue];
   NSLog(@"reportPlaytaste state: %ld  ident: %d tag: %ld", [sender state],ident,[sender tag]);
   int pos=-1;
   NSImage* pauseicon = [NSImage imageNamed:@"pauseicon.png"];
   if ([sender state])
   {
  // [sender setImage:pauseicon];
   }
     
   for (int i=0;i<[MusikArray count];i++)
   {
      if ((i+1000)==ident)
      {
         //NSLog(@"ident passt i: %d ident: %d state: %ld",i,ident,[sender state]);
         pos = i;
         if ([sender state])
         {
            //NSLog(@"taste state 1 play i: %d",i );
            NSImage* pauseicon = [NSImage imageNamed:@"pauseicon.png"];
            [sender setImage:pauseicon];
            //[[[sender superview] viewWithTag:i+1000]setImage:pauseicon];
            
            //NSLog(@"i: %d MusikArray tag %@",i,[[MusikArray objectAtIndex:[sender tag]-1000]description]);
            //NSLog(@"i: %d MusikArray ident %@",i,[[MusikArray objectAtIndex:ident-1000]description]);
            
            //   QTMovie* tempSound = [[MusikArray objectAtIndex:[sender tag]-1000]objectForKey:@"sound"];
            QTMovie* tempSound = [[MusikArray objectAtIndex:ident-1000]objectForKey:@"sound"];
            
            [player setMovie: tempSound]; 
            
            [[player movie] play];
         }
         else 
         {
            //NSLog(@"taste stop i: %d",i );
            NSImage* playicon = [NSImage imageNamed:@"playicon.png"];
            [sender setImage:playicon];
            
         }
         
      }
   }// for i
   
   //NSLog(@"taste pos: %d",pos );
   
   for (int i=0;i<5;i++)
   {
      if ([[sender superview] viewWithTag:i+1000]&& i != [sender tag]-1000)
      {
         //NSLog(@"taste reset da: i: %d",i );
 //        [[[sender superview] viewWithTag:i+1000]setState:0];
         //[[[sender superview] viewWithTag:i+1000]setTitle:@">"];
         NSImage* playicon = [NSImage imageNamed:@"playicon.png"];
         [[[sender superview] viewWithTag:i+1000]setImage:playicon];
      }
   }// for i
   
   
   
}


- (int)setAuswahl
{
   int erfolg=0;  
   NSLog(@"\n\n**   setAuswahl  *\n");
   NSTabViewItem* KlasseItem = [KlasseTab selectedTabViewItem];
   int klassewahl = [Klassewahl  selectedRow];
   int klasse = [KlasseTab  indexOfTabViewItem:KlasseItem];
   
   int nummer=0;
   if (klasse)
   {
      
      NSTabViewItem* NummerItem = [NummerTab selectedTabViewItem];
      //NSLog(@"ident: %@",[NummerTab  identifier]);
      nummer = [NummerTab  indexOfTabViewItem:NummerItem];
      
      NSMutableIndexSet* fotoindex = [NSMutableIndexSet indexSet];
      
      [fotoindex addIndexes:[[[[PList objectForKey:@"klassenarray"]objectAtIndex:klasse]objectAtIndex:nummer]objectForKey:@"fotoindex"]];
      //NSLog(@"fotoindex: %@",[fotoindex  description]);
      
      NSMutableIndexSet* notenindex = [NSMutableIndexSet indexSet];
      [notenindex addIndexes:[[[[PList objectForKey:@"klassenarray"]objectAtIndex:klasse]objectAtIndex:nummer]objectForKey:@"notenindex"]];
      
      NSMutableIndexSet* musikindex = [NSMutableIndexSet indexSet];
      [musikindex addIndexes:[[[[PList objectForKey:@"klassenarray"]objectAtIndex:klasse]objectAtIndex:nummer]objectForKey:@"musikindex"]];
      //NSLog(@"musikindex: %@",[musikindex  description]);
      
      NSMutableIndexSet* epochenindex = [NSMutableIndexSet indexSet];
      [epochenindex addIndexes:[[[[PList objectForKey:@"klassenarray"]objectAtIndex:klasse]objectAtIndex:nummer]objectForKey:@"epochenindex"]];
      //NSLog(@"epochenindex: %@",[epochenindex  description]);
      
      // Dic fuer Ergebnis des selectedTabView
      NSMutableDictionary* ErgebnisDic;
      //int checknummer = -1;
      long checknummer = NSNotFound;
      if ([MasterErgebnisArray count])
      {
         checknummer = [[MasterErgebnisArray valueForKey:@"nummer"]indexOfObject:[NSNumber numberWithInt:nummer]];
      }
     // if (checknummer >= 0) // schon ein Ergebnisdic da
      if (checknummer < NSNotFound) // schon ein Ergebnisdic da
      {
         ErgebnisDic = [MasterErgebnisArray objectAtIndex:checknummer];
      }
      else 
      {
         ErgebnisDic = [[NSMutableDictionary alloc]initWithCapacity:0];
         
      }
      //NSLog(@"checknummer: %d ErgebnisDic: %@",checknummer,[ErgebnisDic description]);
      
      int ergebnisindex=-1;
      [ErgebnisDic setObject:[NSNumber numberWithInt:nummer]forKey:@"nummer"];
      [ErgebnisDic setObject:[NSNumber numberWithInt:klasse]forKey:@"klasse"];
      [ErgebnisDic setObject:[NSNumber numberWithInt:(100*klasse + nummer)]forKey:@"code"];
      
      switch (nummer)  
      {
         case 0:
         {
            //NSArray* viewarray = [[NummerItem view]subviews];
            //NSLog(@"nummer 0 viewarray: %@",[viewarray description]);
            
            [[[NummerItem view]viewWithTag:8000] setKolonnen:3];
            [[[NummerItem view]viewWithTag:8000] setTitel:@"weiss nicht" inZeile:0 inKolonne:2];
            [[[NummerItem view]viewWithTag:8000] setStatus:1 inZeile:0 inKolonne:2];
            [[[NummerItem view]viewWithTag:8000] setAction:@selector(reportRadiotaste:)];
            [[[NummerItem view]viewWithTag:8000] setNeedsDisplay:YES];
            
            //NSLog(@"setAuswahl Klassewahl: %d Klassetab: %d nummer: %d",klassewahl,klasse,nummer);
            
            
            NSString* tempFrage;
            int i=0;
            for (i=0;i<[FragenArray count];i++)
            {
               if ([[[FragenArray objectAtIndex:i]objectForKey:@"klasse"]intValue] == klasse 
                   && [[[FragenArray objectAtIndex:i]objectForKey:@"nummer"]intValue] == nummer+1 )
               {
                  tempFrage = [[FragenArray objectAtIndex:i]objectForKey:@"frage"];
               }
            }
            //NSLog(@"tempFrage: %@",tempFrage);
            
            [[[NummerItem view]viewWithTag:(klasse*1000)+nummer]setStringValue:tempFrage];
            
            // Frage sichern
            [ErgebnisDic setObject:tempFrage forKey:@"frage"];
            
            // Foto auswaehlen
            int fotobildindex=0;
            
            for (i=0;i<[FotoArray count];i++)
            {
               if ([[[FotoArray objectAtIndex:i]objectForKey:@"art"]intValue] == 2 
                   && [fotoindex containsIndex:[[[FotoArray objectAtIndex:i]objectForKey:@"autor"]intValue]] )
               {
                  //NSLog(@"Foto da: name: %@",[[FotoArray objectAtIndex:i]objectForKey:@"name"]);
                  [fotoindex removeIndex:[[[FotoArray objectAtIndex:i]objectForKey:@"autor"]intValue] ];
                  NSImage* bild = [[FotoArray objectAtIndex:i]objectForKey:@"bild"];
                  [[[NummerItem view]viewWithTag:(6000+nummer+fotobildindex)]setImage:
                   [[FotoArray objectAtIndex:i]objectForKey:@"bild"]];
                  
                  NSMutableDictionary* tempFotoDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:0],@"eins",[NSNumber numberWithInt:0],@"zwei",[NSNumber numberWithInt:0],@"drei",[[FotoArray objectAtIndex:i]objectForKey:@"name"],@"name", nil];
                  
                  [AuswahlArray insertObject:tempFotoDic atIndex:0];
                  
                  // richtiges Ergebnis setzen
                  ergebnisindex = [[[FotoArray objectAtIndex:i]objectForKey:@"autor"]intValue];
                  [ErgebnisDic setObject:[[FotoArray objectAtIndex:i]objectForKey:@"autor"] forKey:@"lsg"];
                  [ErgebnisDic setObject:[[FotoArray objectAtIndex:i]objectForKey:@"name"] forKey:@"lsgtext"];
                  
                  // Bildlegende setzen
                  [Bildlegende setStringValue:[[FotoArray objectAtIndex:i]objectForKey:@"name"]];
                  fotobildindex++;
                  
               }
               
            }//for
            
            
            // [Auswahltabelle reloadData];
            
            
            // Auswahl bestimmen
            
            // Noten auswaehlen            
            NSMutableArray* tempNotenArray = [[NSMutableArray alloc]initWithCapacity:0];
            int notenbildindex=0;
            
            for (int j=0;j<[NotenArray count];j++)
            {
               if ([[[NotenArray objectAtIndex:j]objectForKey:@"art"]intValue] == 3 
                   && [notenindex containsIndex:[[[NotenArray objectAtIndex:j]objectForKey:@"autor"]intValue]] )
               {
                  if ([[NummerItem view]viewWithTag:(5000+100*nummer+notenbildindex)]) // Bild vorhanden
                  {
                     [[[NummerItem view]viewWithTag:(5000+100*nummer+notenbildindex)]setImage:
                      [[NotenArray objectAtIndex:j]objectForKey:@"bild"]];
                     [notenindex removeIndex:[[[NotenArray objectAtIndex:j]objectForKey:@"autor"]intValue]];
                     notenbildindex++;
                  }
                  //int tempIndex = [[NotenArray objectAtIndex:i]intValue];
                  [tempNotenArray addObject:[NotenArray objectAtIndex:j]];
                  
               }
               
            }
            //NSLog(@"tempNotenArray: %@",[tempNotenArray description]);
            
            // Musik auswaehlen
            int soundindex=0;
            NSLog(@"setAuswahl  MusikArray: %@",[[MusikArray valueForKey:@"name"]description]);
            for (i=0;i<[MusikArray count];i++)
            {
               //NSLog(@"MusikArray i: %d autor: %d",i,[[[MusikArray objectAtIndex:i]objectForKey:@"autor"]intValue]); 
               if ([[[MusikArray objectAtIndex:i]objectForKey:@"art"]intValue] == 1 
                   && [musikindex containsIndex:[[[MusikArray objectAtIndex:i]objectForKey:@"autor"]intValue]] )
               {
                  int ergebniscode =[[[MusikArray objectAtIndex:i]objectForKey:@"autor"]intValue];
                  [[[NummerItem view]viewWithTag:8000]setErgebniscode:ergebniscode inZeile:0 inKolonne:soundindex];
                  
                  //NSLog(@"Musik da: name: %@",[[MusikArray objectAtIndex:i]objectForKey:@"name"]);
                  if ([[NummerItem view]viewWithTag:(1000+soundindex)]) // Taste vorhanden
                  {
                     // identifier der Play-Taste zu position des Musikstuecks im Musikarray setzen
                     [[[NummerItem view]viewWithTag:(1000+soundindex)]setIdentifier:
                      [[NSNumber numberWithInt:(1000+i)]stringValue]];

                     // tag der Taste setzen
                     //[[[NummerItem view]viewWithTag:(1000+soundindex)]setTag:1000+i];
                     [[[NummerItem view]viewWithTag:(1000+soundindex)]setState:0];
                     
                     [musikindex removeIndex:[[[NotenArray objectAtIndex:i]objectForKey:@"autor"]intValue]];
                     soundindex++;
                     
                  } 
                  
               }
            }
            
            // Welches Stück hat dieser Komponist geschrieben?
            // autor von Foto muss gleich sein wie Musik
            
            
            
         }break; // case 0
            
         case 1:
         {
            // Wer hat dieses Stück komponiert?
            // autor von Foto muss gleich sein wie von Musik
            
            [(rRadioMatrix*)[[NummerItem view]viewWithTag:8000] setKolonnen:3];
            [[[NummerItem view]viewWithTag:8000] setTitel:@"weiss nicht" inZeile:0 inKolonne:2];
            [[[NummerItem view]viewWithTag:8000] setStatus:1 inZeile:0 inKolonne:2];
            [[[NummerItem view]viewWithTag:8000] setNeedsDisplay:YES];
            [[[NummerItem view]viewWithTag:8000] setAction:@selector(reportRadiotaste:)];
            
            // Frage lesen
            NSString* tempFrage;
            int i=0;
            for (i=0;i<[FragenArray count];i++)
            {
               if ([[[FragenArray objectAtIndex:i]objectForKey:@"klasse"]intValue] == klasse 
                   && [[[FragenArray objectAtIndex:i]objectForKey:@"nummer"]intValue] == nummer+1 )
               {
                  tempFrage = [[FragenArray objectAtIndex:i]objectForKey:@"frage"];
               }
            }
            //NSLog(@"tempFrage: %@",tempFrage);
            
            [[[NummerItem view]viewWithTag:(klasse*1000)]setStringValue:tempFrage];
            
            // Frage sichern
            [ErgebnisDic setObject:tempFrage forKey:@"frage"];
            
            
            //Bilder der Autoren suchen
            int fotobildindex=0;
            
            for (i=0;i<[FotoArray count];i++)
            {
               if ([[[FotoArray objectAtIndex:i]objectForKey:@"art"]intValue] == 2 
                   && [fotoindex containsIndex:[[[FotoArray objectAtIndex:i]objectForKey:@"autor"]intValue]] )
               {
                  // Ergebniscode in Tasten setzen: "autor"
                  int ergebniscode =[[[FotoArray objectAtIndex:i]objectForKey:@"autor"]intValue];
                  [[[NummerItem view]viewWithTag:8000]setErgebniscode:ergebniscode inZeile:0 inKolonne:fotobildindex];
                  
                  
                  //NSLog(@"Foto da fotobildindex: %d : name: %@",fotobildindex,[[FotoArray objectAtIndex:i]objectForKey:@"name"]);
                  [fotoindex removeIndex:[[[FotoArray objectAtIndex:i]objectForKey:@"autor"]intValue] ];
                  
                  NSImage* bild = [[FotoArray objectAtIndex:i]objectForKey:@"bild"];
                  
                  // Name in Auswahlradio einsetzen
                  [(rRadioMatrix*)[[NummerItem view]viewWithTag:(8000)]setTitel:[[FotoArray objectAtIndex:i]objectForKey:@"name"] inZeile:0 inKolonne:fotobildindex];
                  
                  
                  [[[NummerItem view]viewWithTag:(6000+fotobildindex)]setImage:
                   [[FotoArray objectAtIndex:i]objectForKey:@"bild"]];
                  
                  //[Bildlegende setStringValue:[[FotoArray objectAtIndex:i]objectForKey:@"name"]];
                  fotobildindex++;
                  
               }
               
            }//for
            
            
            // Noten auswaehlen
            NSMutableArray* tempNotenArray = [[NSMutableArray alloc]initWithCapacity:0];
            int notenbildindex=0;
            
            for (i=0;i<[NotenArray count];i++)
            {
               if ([[[NotenArray objectAtIndex:i]objectForKey:@"art"]intValue] == 3 
                   && [notenindex containsIndex:[[[NotenArray objectAtIndex:i]objectForKey:@"autor"]intValue]] )
               {
                  if ([[NummerItem view]viewWithTag:(5000+notenbildindex)]) // Bildobjekt vorhanden
                  {
                     [[[NummerItem view]viewWithTag:(5000+notenbildindex)]setImage:
                      [[NotenArray objectAtIndex:i]objectForKey:@"bild"]];
                     [notenindex removeIndex:[[[NotenArray objectAtIndex:i]objectForKey:@"autor"]intValue]];
                     notenbildindex++;
                  }
                  //int tempIndex = [[NotenArray objectAtIndex:i]intValue];
                  [tempNotenArray addObject:[NotenArray objectAtIndex:i]];
                  
               }
               
            }
            
            
            // Musik auswaehlen
            int soundindex=0;
            
            for (i=0;i<[MusikArray count];i++)
            {
               if ([[[MusikArray objectAtIndex:i]objectForKey:@"art"]intValue] == 1 
                   && [musikindex containsIndex:[[[NotenArray objectAtIndex:i]objectForKey:@"autor"]intValue]] )
               {
                  
                  //NSLog(@"1 Musik da: name: %@",[[MusikArray objectAtIndex:i]objectForKey:@"name"]);
                  if ([[NummerItem view]viewWithTag:(1000+soundindex)]) // Taste vorhanden
                  {
                     // identifier der Play-Taste zu position des Musikstuecks im Musikarray setzen
                     [[[NummerItem view]viewWithTag:(1000+soundindex)]setIdentifier:
                      [[NSNumber numberWithInt:(1000+i)]stringValue]];

                     //[[[NummerItem view]viewWithTag:(1000+soundindex)]setTag:1000+i];
                     
                     [musikindex removeIndex:[[[NotenArray objectAtIndex:i]objectForKey:@"autor"]intValue]];
                     soundindex++;
                     
                     // richtiges Ergebnis setzen
                     ergebnisindex = [[[NotenArray objectAtIndex:i]objectForKey:@"autor"]intValue];
                     [ErgebnisDic setObject:[[NotenArray objectAtIndex:i]objectForKey:@"autor"] forKey:@"lsg"];
                     [ErgebnisDic setObject:[[NotenArray objectAtIndex:i]objectForKey:@"name"] forKey:@"lsgtext"];

                  } 
                  
               }
            }
            
            
            
         }break; // case 1
            
         case 2: 
         {
            // Welches dieser Stücke ist früher komponiert worden?
            /*
             NSArray* viewarray = [[NummerItem view]subviews];
             NSLog(@"nummer 2 viewarray: %@",[viewarray description]);
             int k=0;
             for (k=0;k<[viewarray count];k++)
             {
             NSLog(@"k: %d tag: %ld",k,[[viewarray objectAtIndex:k]tag]);
             }
             */
            
            [(rRadioMatrix*)[[NummerItem view]viewWithTag:8000] setKolonnen:3];
            [[[NummerItem view]viewWithTag:8000] setTitel:@"weiss nicht" inZeile:0 inKolonne:2];
            [[[NummerItem view]viewWithTag:8000] setStatus:1 inZeile:0 inKolonne:2];
            [[[NummerItem view]viewWithTag:8000] setNeedsDisplay:YES];
            [[[NummerItem view]viewWithTag:8000] setAction:@selector(reportRadiotaste:)];
            
            NSImage* komponierenbild = [NSImage imageNamed:@"komponieren.jpg"];
            [[[NummerItem view]viewWithTag:7000]setImage:komponierenbild];
            
            
            // Frage lesen
            NSString* tempFrage;
            int i=0;
            for (i=0;i<[FragenArray count];i++)
            {
               if ([[[FragenArray objectAtIndex:i]objectForKey:@"klasse"]intValue] == klasse 
                   && [[[FragenArray objectAtIndex:i]objectForKey:@"nummer"]intValue] == nummer+1 )
               {
                  tempFrage = [[FragenArray objectAtIndex:i]objectForKey:@"frage"];
               }
            }
            //NSLog(@"tempFrage: %@",tempFrage);
            [[[NummerItem view]viewWithTag:(klasse*1000)]setStringValue:tempFrage];
            
            // Frage sichern
            [ErgebnisDic setObject:tempFrage forKey:@"frage"];
            

            
            // Musik auswaehlen
            int soundindex=0;
            
            // IndexSet fuer Epoche der Komponisten-Fotos
            NSMutableIndexSet* tempEpocheindex = [NSMutableIndexSet indexSet];
            
            // Array fuer Dics mit den Angaben zur Epoche
            NSMutableArray* tempEpocheArray = [[NSMutableArray alloc]initWithCapacity:0];
            
            for (i=0;i<[MusikArray count];i++)
            {
               if ([[[MusikArray objectAtIndex:i]objectForKey:@"art"]intValue] == 1 
                   && [musikindex containsIndex:[[[NotenArray objectAtIndex:i]objectForKey:@"autor"]intValue]] )
               {
                  
                  NSMutableDictionary* tempEpocheDic = [[NSMutableDictionary alloc]initWithCapacity:0];
                  // epoche einsetzen
                  //[tempEpocheindex addIndex:[[[FotoArray objectAtIndex:i]objectForKey:@"epoche"]intValue]];
                  NSNumber* epochenumber = [[MusikArray objectAtIndex:i]objectForKey:@"epoche"];
                  [tempEpocheDic setObject:[NSNumber numberWithInt:[[[MusikArray objectAtIndex:i]objectForKey:@"epoche"]intValue]] forKey:@"epoche"];

                  // Lage der Epoche im EpochenArray
                  long epochepos =[[EpochenArray valueForKey:@"epoche"]indexOfObject:epochenumber];
                  //NSLog(@"i: %d epochepos: %d ",i,epochepos);
                  //Name der Epoche an epochepos holen
                  [tempEpocheDic setObject:[[EpochenArray objectAtIndex:epochepos]objectForKey:@"name"] forKey:@"epochename"];
                  [tempEpocheDic setObject:[NSNumber numberWithInt:soundindex] forKey:@"pos"];
                  
                  NSLog(@"i: %d tempEpocheDic: %@",i, [tempEpocheDic description]);
                  [tempEpocheArray addObject:tempEpocheDic];
                  
                 
                  //int ergebniscode =[[[MusikArray objectAtIndex:i]objectForKey:@"autor"]intValue];
                  int ergebniscode =[[[MusikArray objectAtIndex:i]objectForKey:@"epoche"]intValue];
                  
                  [[[NummerItem view]viewWithTag:8000]setErgebniscode:ergebniscode inZeile:0 inKolonne:soundindex];
                  
                  
                  
                  //NSLog(@"2 Musik da: name: %@",[[MusikArray objectAtIndex:i]objectForKey:@"name"]);
                  if ([[NummerItem view]viewWithTag:(1000+soundindex)]) // Taste vorhanden
                  {
                     // identifier der Taste zu position des Musikstuecks im Musikarray setzen
                     
                     [[[NummerItem view]viewWithTag:(1000+soundindex)]setIdentifier:[[NSNumber numberWithInt:(1000+i)]stringValue]];

                     //[[[NummerItem view]viewWithTag:(1000+soundindex)]setIdentifier:[[NSNumber numberWithInt:(1000+epochepos)]stringValue]];

                     //[[[NummerItem view]viewWithTag:(1000+soundindex)]setTag: 1000+i];
                     
                     [musikindex removeIndex:[[[NotenArray objectAtIndex:i]objectForKey:@"autor"]intValue]];
                     soundindex++;
                                          
                  } 
                  
               }
            } // for i Musikarray
            
            // richtiges Ergebnis setzen
            //int richtigindex = min([musikindex firstIndex],[musikindex lastIndex]);
            //NSLog(@"nummer 2 ind0: %lu ind1: %lu max: %d",[musikindex firstIndex],[musikindex lastIndex],richtigindex);
            
            
            int richtigindex = [self minVonArray:[tempEpocheArray valueForKey:@"epoche"]];
            int pos = [[tempEpocheArray valueForKey:@"epoche"]indexOfObject:[NSNumber numberWithInt:richtigindex]];
            NSString* epochename = [[tempEpocheArray objectAtIndex:pos]objectForKey:@"epochename"];
            NSLog(@"nummer 2 richtigindex: %d pos: %d tempEpocheArray: %@ ",richtigindex, pos, [tempEpocheArray description]);
            //NSLog(@"nummer 2 richtigindex: %d pos: %d name zu richtigindex: %@ ",richtigindex, pos, epochename);
             
            if (pos) // pos des min ist an zweiter position
            {
               [ErgebnisDic setObject:@"rechts" forKey:@"lsgtext"];
               [ErgebnisDic setObject:[[tempEpocheArray valueForKey:@"epoche"]lastObject] forKey:@"lsg"];
            }
            else // pos des min ist an erster position
            {
               [ErgebnisDic setObject:@"links" forKey:@"lsgtext"];
               [ErgebnisDic setObject:[[tempEpocheArray valueForKey:@"epoche"]objectAtIndex:0] forKey:@"lsg"];
            }
            
            
            // Noten auswaehlen
            NSMutableArray* tempNotenArray = [[NSMutableArray alloc]initWithCapacity:0];
            int notenbildindex=0;
            
            for (i=0;i<[NotenArray count];i++)
            {
               if ([[[NotenArray objectAtIndex:i]objectForKey:@"art"]intValue] == 3 
                   && [notenindex containsIndex:[[[NotenArray objectAtIndex:i]objectForKey:@"autor"]intValue]] )
               {
                  //                int ergebniscode =[[[NotenArray objectAtIndex:i]objectForKey:@"autor"]intValue];
                  //                 [[[NummerItem view]viewWithTag:8000]setErgebniscode:ergebniscode inZeile:0 inKolonne:notenbildindex];
                  
                  //NSLog(@"2 Bild da: name: %@",[[MusikArray objectAtIndex:i]objectForKey:@"name"]);
                  if ([[NummerItem view]viewWithTag:(5000+notenbildindex)]) // Bildobjekt vorhanden
                  {
                     [[[NummerItem view]viewWithTag:(5000+notenbildindex)]setImage:
                      [[NotenArray objectAtIndex:i]objectForKey:@"bild"]];
                     [notenindex removeIndex:[[[NotenArray objectAtIndex:i]objectForKey:@"autor"]intValue]];
                     notenbildindex++;
                  }
                  //int tempIndex = [[NotenArray objectAtIndex:i]intValue];
                  [tempNotenArray addObject:[NotenArray objectAtIndex:i]];
                  
               }
               
            }
            
            
         }break; // case 2
            
            
         case 3: 
         {
            // Welcher dieser Komponisten lebte näher zu unserer Zeit?
            /*
             NSArray* viewarray = [[NummerItem view]subviews];
             int k=0;
             for (k=0;k<[viewarray count];k++)
             {
             NSLog(@"k: %d tag: %ld",k,[[viewarray objectAtIndex:k]tag]);
             }
             */
            [(rRadioMatrix*)[[NummerItem view]viewWithTag:8000] setKolonnen:3];
            [[[NummerItem view]viewWithTag:8000] setTitel:@"no idea" inZeile:0 inKolonne:2];
            [[[NummerItem view]viewWithTag:8000] setStatus:1 inZeile:0 inKolonne:2];
            [[[NummerItem view]viewWithTag:8000] setNeedsDisplay:YES];
            [[[NummerItem view]viewWithTag:8000] setAction:@selector(reportRadiotaste:)];
            // Frage lesen
            NSString* tempFrage;
            int i=0;
            for (i=0;i<[FragenArray count];i++)
            {
               if ([[[FragenArray objectAtIndex:i]objectForKey:@"klasse"]intValue] == klasse 
                   && [[[FragenArray objectAtIndex:i]objectForKey:@"nummer"]intValue] == nummer+1 )
               {
                  tempFrage = [[FragenArray objectAtIndex:i]objectForKey:@"frage"];
               }
            }
            //NSLog(@"tempFrage: %@",tempFrage);
            
            // Welcher dieser Komponisten lebte näher zu unserer Zeit?
            
            [[[NummerItem view]viewWithTag:(klasse*1000)]setStringValue:tempFrage];
            
            // Frage sichern
            [ErgebnisDic setObject:tempFrage forKey:@"frage"];
            
            
            // Bilder auswaehlen
            int fotobildindex=0;
            
            // IndexSet fuer Epoche der Komponisten-Fotos
            NSMutableIndexSet* tempEpocheindex = [NSMutableIndexSet indexSet];
            
            // Array fuer Dics mit den Angaben zur Epoche
            NSMutableArray* tempEpocheArray = [[NSMutableArray alloc]initWithCapacity:0];
            
            for (i=0;i<[FotoArray count];i++)
            {
               if ([[[FotoArray objectAtIndex:i]objectForKey:@"art"]intValue] == 2 
                   && [fotoindex containsIndex:[[[FotoArray objectAtIndex:i]objectForKey:@"autor"]intValue]]) 
               {
                  //NSLog(@"3 Foto da fotobildindex: %d : name: %@ epoche: %d",fotobildindex,[[FotoArray objectAtIndex:i]objectForKey:@"name"],[[[FotoArray objectAtIndex:i]objectForKey:@"epoche"]intValue]);
                  
                  NSMutableDictionary* tempEpocheDic = [[NSMutableDictionary alloc]initWithCapacity:0];
                  
                  // epoche einsetzen für das Bild an position i
                  [tempEpocheindex addIndex:[[[FotoArray objectAtIndex:i]objectForKey:@"epoche"]intValue]];
                  NSNumber* epochenumber = [[FotoArray objectAtIndex:i]objectForKey:@"epoche"];
                  [tempEpocheDic setObject:[NSNumber numberWithInt:[[[FotoArray objectAtIndex:i]objectForKey:@"epoche"]intValue]] forKey:@"epoche"];
                  
                  // Lage der Epoche im EpochenArray
                  long epochepos =[[EpochenArray valueForKey:@"epoche"]indexOfObject:epochenumber];
                  //NSLog(@"i: %d epochepos: %d ",i,epochepos);
                  
                  //Name der Epoche an epochepos holen
                  [tempEpocheDic setObject:[[EpochenArray objectAtIndex:epochepos]objectForKey:@"name"] forKey:@"epochename"];
                  
                  //NSLog(@"i: %d tempEpocheDic: %@",i, [tempEpocheDic description]);
                  [tempEpocheArray addObject:tempEpocheDic];
                  
                  
                  // Bild des Komponisten in View 6000+i einsetzen
                  [[[NummerItem view]viewWithTag:(6000+fotobildindex)]setImage:
                   [[FotoArray objectAtIndex:i]objectForKey:@"bild"]];
                  
                  // Name des Komponisten in Radiobutton 'fotobildindex' einsetzen
                  [(rRadioMatrix*)[[NummerItem view]viewWithTag:(8000)]setTitel:[[FotoArray objectAtIndex:i]objectForKey:@"name"] inZeile:0 inKolonne:fotobildindex];
                  
                   // aktuellen code es Autors aus fotoindex entfernen
                  [fotoindex removeIndex:[[[FotoArray objectAtIndex:i]objectForKey:@"autor"]intValue]];
                 
                  //[Bildlegende setStringValue:[[FotoArray objectAtIndex:i]objectForKey:@"name"]];
                  fotobildindex++;
                  
               }
            } // for i FotoArray
            
            // richtiges Ergebnis setzen
            
            // Maximum des Wertes fuer Epoche aus tempEpocheArray holen
            int richtigindex = [self maxVonArray:[tempEpocheArray valueForKey:@"epoche"]];
            
            //Position in FotoArray zu epoche holen
            int pos = [[FotoArray valueForKey:@"epoche"]indexOfObject:[NSNumber numberWithInt:richtigindex]];
            NSLog(@"nummer 3 pos: %d",pos);
            
            NSString* komponistzuepochename = [[FotoArray objectAtIndex:pos]objectForKey:@"name"];
           
            NSLog(@"nummer 3 richtigindex: %d pos: %d name zu richtigindex: %@ ",richtigindex, pos, komponistzuepochename);
 
            [ErgebnisDic setObject:[NSNumber numberWithInt:richtigindex] forKey:@"lsg"];
            [ErgebnisDic setObject:komponistzuepochename forKey:@"lsgtext"];
            
            // Musik auswaehlen
            int soundindex=0;
            
            NSArray* viewarray = [[NummerItem view]subviews];
            int k=0;
            for (k=0;k<[viewarray count];k++)
            {
               //NSLog(@"Aufgabe 3 k: %d tag: %ld %@",k,[[viewarray objectAtIndex:k]tag],[[viewarray objectAtIndex:k]description]);
            }
            
//            NSLog(@"nummer 3  musikindex : %@",[musikindex description]);
            for (i=0;i<[MusikArray count];i++)
            {
//               NSLog(@"nummer 3 i: %d musikindex : %@ autor: %d ",i,[musikindex description],[[[MusikArray objectAtIndex:i]objectForKey:@"autor"]intValue]);

               if ([[[MusikArray objectAtIndex:i]objectForKey:@"art"]intValue] == 1 
                   && [musikindex containsIndex:[[[NotenArray objectAtIndex:i]objectForKey:@"autor"]intValue]] )
               {

//                  NSLog(@"3 soundindex: %d Musik da: name: %@",soundindex,[[MusikArray objectAtIndex:i]objectForKey:@"name"]);
                  if ([[NummerItem view]viewWithTag:(1000+soundindex)]) // Play-Taste vorhanden
                  {
                     int ergebniscode =[[[MusikArray objectAtIndex:i]objectForKey:@"epoche"]intValue];
//                     NSLog(@"nummer 3 taste: %d ergebniscode Musik: %d",soundindex, ergebniscode);
                     [[[NummerItem view]viewWithTag:8000]setErgebniscode:ergebniscode inZeile:0 inKolonne:soundindex];
                     
                     
                     // identifier der Play-Taste zu position des Musikstuecks im Musikarray setzen
                     [[[NummerItem view]viewWithTag:(1000+soundindex)]setIdentifier:
                      [[NSNumber numberWithInt:(1000+i)]stringValue]];
                    
                    // [[[NummerItem view]viewWithTag:(1000+soundindex)]setTag:1000+i];
                     
                     [musikindex removeIndex:[[[MusikArray objectAtIndex:i]objectForKey:@"autor"]intValue]];
                     soundindex++;
                     
                  }
                  else 
                  {
                     
//                     NSLog(@"i: %d keine Taste",i); 
                  }
                  
               }
               else 
               {
//                  NSLog(@"i: %d index nicht da",i); 
               }
            }
            NSImage* kalenderbild = [NSImage imageNamed:@"kalender_hg.png"];
            /*
             NSRect imageFrame = [[[NummerItem view]viewWithTag:7000]frame];
             [kalenderbild lockFocus];
             // [kalenderbild setScalesWhenResized:YES];
             float radius = imageFrame.size.width/2;
             NSLog(@"radius: %2.2f",radius);
             [NSGraphicsContext saveGraphicsState];
             NSBezierPath *path = [NSBezierPath bezierPathWithRoundedRect:imageFrame
             xRadius:radius
             yRadius:radius];
             [path addClip];
             
             [kalenderbild drawInRect:imageFrame
             fromRect:NSZeroRect
             operation:NSCompositeSourceOver
             fraction:1.0];
             [kalenderbild unlockFocus];
             [NSGraphicsContext restoreGraphicsState];
             */
            
            [[[NummerItem view]viewWithTag:7000]setImage:kalenderbild];
            
            
            
         }break; // case 3
            
         case 4:
         {
            // In welcher Epoche lebte dieser Komponist?
            
            NSArray* viewarray = [[[NummerTab selectedTabViewItem]view ]subviews];
            int k=0;
            for (k=0;k<[viewarray count];k++)
            {
               //NSLog(@"Aufgabe 4 k: %d tag: %ld %@",k,[[viewarray objectAtIndex:k]tag],[[viewarray objectAtIndex:k]description]);
            }
            
            [(rRadioMatrix*)[[NummerItem view]viewWithTag:8000] setKolonnen:3];
            [[[NummerItem view]viewWithTag:8000] setTitel:@"weiss nicht" inZeile:0 inKolonne:2];
            [[[NummerItem view]viewWithTag:8000] setStatus:1 inZeile:0 inKolonne:2];
            [[[NummerItem view]viewWithTag:8000] setNeedsDisplay:YES];
            [[[NummerItem view]viewWithTag:8000] setAction:@selector(reportRadiotaste:)];
            
            // Frage lesen
            NSString* tempFrage;
            int i=0;
            for (i=0;i<[FragenArray count];i++)
            {
               if ([[[FragenArray objectAtIndex:i]objectForKey:@"klasse"]intValue] == klasse 
                   && [[[FragenArray objectAtIndex:i]objectForKey:@"nummer"]intValue] == nummer+1 )
               {
                  tempFrage = [[FragenArray objectAtIndex:i]objectForKey:@"frage"];
               }
            }
            //NSLog(@"Nr. 4 tempFrage: %@",tempFrage);
            
            // In welcher Epoche lebte dieser Komponist?
            
            [[[NummerItem view]viewWithTag:(klasse*1000)]setStringValue:tempFrage];
            // Frage sichern
            [ErgebnisDic setObject:tempFrage forKey:@"frage"];
            
            
            // Musik auswaehlen 
            int soundindex=0;

 
            for (i=0;i<[MusikArray count];i++)
            {
               if ([[[MusikArray objectAtIndex:i]objectForKey:@"art"]intValue] == 1 
                   && [musikindex containsIndex:[[[MusikArray objectAtIndex:i]objectForKey:@"autor"]intValue]] )
               {
                  
                  //NSLog(@"4 Musik da: name: %@ epoche: %d",[[MusikArray objectAtIndex:i]objectForKey:@"name"],[[[MusikArray objectAtIndex:i]objectForKey:@"epoche"]intValue]);
                 
 
                  // Musik in Play-Taste einsetzen
                  if ([[NummerItem view]viewWithTag:(1000+soundindex)]) // Taste vorhanden
                  {
                     // identifier der Play-Taste zu position des Musikstuecks im Musikarray setzen
                     [[[NummerItem view]viewWithTag:(1000+soundindex)]setIdentifier:
                      [[NSNumber numberWithInt:(1000+i)]stringValue]];
                     
                     // benutzten index aus musikindex entfernen
                     [musikindex removeIndex:[[[MusikArray objectAtIndex:i]objectForKey:@"autor"]intValue]];
                     [Bildlegende setStringValue:[[FotoArray objectAtIndex:i]objectForKey:@"name"]];
                     
                     soundindex++;
                     
                  } 
                  
               }
            }
            
            // Bild auswaehlen fuer Komponist
            int fotobildindex=0;
            
            // Epoche des Komponisten
            int lsgepoche=-1;
            for (i=0;i<[FotoArray count];i++)
            {
               if ([[[FotoArray objectAtIndex:i]objectForKey:@"art"]intValue] == 2 
                   && [fotoindex containsIndex:[[[FotoArray objectAtIndex:i]objectForKey:@"autor"]intValue]] )
               {
                  
                  NSLog(@"4 Foto da fotobildindex: %d : name: %@ epoche: %d",fotobildindex,[[FotoArray objectAtIndex:i]objectForKey:@"name"], [[[FotoArray objectAtIndex:i]objectForKey:@"epoche"]intValue]);
                  [fotoindex removeIndex:[[[FotoArray objectAtIndex:i]objectForKey:@"autor"]intValue] ];
                  
                  // Epoche des Komponisten 
                  [ErgebnisDic setObject:[[FotoArray objectAtIndex:i]objectForKey:@"epoche"] forKey:@"lsg"];
                  lsgepoche = [[[FotoArray objectAtIndex:i]objectForKey:@"epoche"]intValue];
                  //[ErgebnisDic setObject:[[FotoArray objectAtIndex:i]objectForKey:@"name"] forKey:@"lsgtext"];
                  
                  
                  //NSImage* bild = [[FotoArray objectAtIndex:i]objectForKey:@"bild"];
                  
                  // Bild der Epoche  im View 5000+fotobildindex einsetzen. 
                  [[[NummerItem view]viewWithTag:(5000+fotobildindex)]setImage:[[FotoArray objectAtIndex:i]objectForKey:@"bild"]];
                  
                  // Name der Epoche in View 9000+fotobildindex einsetzen
                  [[[NummerItem view]viewWithTag:(9000+fotobildindex)]setStringValue:[[FotoArray objectAtIndex:i]objectForKey:@"name"]];
                  
                  
                  // Name der Epoche in Radio einsetzen
                  [(rRadioMatrix*)[[NummerItem view]viewWithTag:(8000)]setTitel:[[FotoArray objectAtIndex:i]objectForKey:@"name"] inZeile:0 inKolonne:fotobildindex];
                  
                  
                  //[Bildlegende setStringValue:[[FotoArray objectAtIndex:i]objectForKey:@"name"]];
                  fotobildindex++;
                  
               }
            }
            
            //Position in EpochenArray zu epoche holen
            int pos = [[EpochenArray valueForKey:@"epoche"]indexOfObject:[NSNumber numberWithInt:lsgepoche]];
            //NSLog(@"nummer 4 pos: %d epochename: %@",pos,[[EpochenArray objectAtIndex:pos]valueForKey:@"name"]);
            
            // Name der Epoche in ErgebnisDic einsetzen
            [ErgebnisDic setObject:[[EpochenArray objectAtIndex:pos]valueForKey:@"name"] forKey:@"lsgtext"];
            
            // Epoche auswaehlen und in Radio einsetzen
            int epochebildindex=0;
            
            for (i=0;i<[EpochenArray count];i++)
            {
               if ([[[EpochenArray objectAtIndex:i]objectForKey:@"art"]intValue] == 4 
                   && [epochenindex containsIndex:[[[EpochenArray objectAtIndex:i]objectForKey:@"autor"]intValue]] )
               {
                  // Ergebniscode der Epoche in Radio einsetzen
                  int ergebniscode =[[[EpochenArray objectAtIndex:i]objectForKey:@"epoche"]intValue];
                  [[[NummerItem view]viewWithTag:8000]setErgebniscode:ergebniscode inZeile:0 inKolonne:epochebildindex];
                  
                  //Bild in View 6000+epochebildindex einsetzen
                  [[[NummerItem view]viewWithTag:(6000+epochebildindex)]setImage:[[EpochenArray objectAtIndex:i]objectForKey:@"bild"]];
                  
                  // Epoche des Bildes in Radio an pos epochebildindex einsetzen
                  [(rRadioMatrix*)[[NummerItem view]viewWithTag:(8000)]setTitel:[[EpochenArray objectAtIndex:i]objectForKey:@"name"] inZeile:0 inKolonne:epochebildindex];
                  
                  epochebildindex++;
               }
            }
            
            
         }break; // 4
            
         case 5: // Aufgabe 6 // Welches Stück wurde in dieser Epoche komponiert?
         {
            NSArray* viewarray = [[[NummerTab selectedTabViewItem]view ]subviews];
            int k=0;
            for (k=0;k<[viewarray count];k++)
            {
               //NSLog(@"Aufgabe 5 k: %d tag: %ld %@",k,[[viewarray objectAtIndex:k]tag],[[viewarray objectAtIndex:k]description]);
            }
            
            [(rRadioMatrix*)[[NummerItem view]viewWithTag:8000] setKolonnen:3];
            [[[NummerItem view]viewWithTag:8000] setTitel:@"weiss nicht" inZeile:0 inKolonne:2];
            [[[NummerItem view]viewWithTag:8000] setStatus:1 inZeile:0 inKolonne:2];
            [[[NummerItem view]viewWithTag:8000] setNeedsDisplay:YES];
            [[[NummerItem view]viewWithTag:8000] setAction:@selector(reportRadiotaste:)];
            
            // Frage lesen
            NSString* tempFrage;
            int i=0;
            for (i=0;i<[FragenArray count];i++)
            {
               if ([[[FragenArray objectAtIndex:i]objectForKey:@"klasse"]intValue] == klasse 
                   && [[[FragenArray objectAtIndex:i]objectForKey:@"nummer"]intValue] == nummer+1 )
               {
                  tempFrage = [[FragenArray objectAtIndex:i]objectForKey:@"frage"];
               }
            }
            //NSLog(@"Nr. 5 tempFrage: %@",tempFrage);
            
            // Welches Stück wurde in dieser Epoche komponiert?
            
            [[[NummerItem view]viewWithTag:(klasse*1000)]setStringValue:tempFrage];
            
            // Frage sichern
            [ErgebnisDic setObject:tempFrage forKey:@"frage"];
            
            
            // Noten auswaehlen            
            //NSMutableArray* tempNotenArray = [[NSMutableArray alloc]initWithCapacity:0];
            int notenbildindex=0;

            // Array fuer Dics mit den Angaben zur Epoche
            NSMutableArray* tempEpocheArray = [[NSMutableArray alloc]initWithCapacity:0];

            for (i=0;i<[NotenArray count];i++)
            {
               if ([[[NotenArray objectAtIndex:i]objectForKey:@"art"]intValue] == 3 
                   && [notenindex containsIndex:[[[NotenArray objectAtIndex:i]objectForKey:@"autor"]intValue]] )
               {
                  
                  NSMutableDictionary* tempEpocheDic = [[NSMutableDictionary alloc]initWithCapacity:0];
                  
                  
                  [tempEpocheDic setObject:[NSNumber numberWithInt:notenbildindex] forKey:@"pos"];
                  // epoche der Noten von position i einsetzen
                  NSNumber* epochenumber = [[NotenArray objectAtIndex:i]objectForKey:@"epoche"];
                  [tempEpocheDic setObject:[[NotenArray objectAtIndex:i]objectForKey:@"epoche"] forKey:@"epoche"];

                  
                  
                  if ([[NummerItem view]viewWithTag:(5000+notenbildindex)]) // Bild vorhanden
                  {
                     [[[NummerItem view]viewWithTag:(5000+notenbildindex)]setImage:
                      [[NotenArray objectAtIndex:i]objectForKey:@"bild"]];
                     
                     NSLog(@"5 Noten da notenbildindex: %d : name: %@ epoche: %d",notenbildindex,[[NotenArray objectAtIndex:i]objectForKey:@"name"], [[[NotenArray objectAtIndex:i]objectForKey:@"epoche"]intValue]);
                     
                     // Ergebniscode der Epoche in Radio einsetzen
                     int ergebniscode =[[[NotenArray objectAtIndex:i]objectForKey:@"epoche"]intValue];
                     [[[NummerItem view]viewWithTag:8000]setErgebniscode:ergebniscode inZeile:0 inKolonne:notenbildindex];
                     
                     
                     [notenindex removeIndex:[[[NotenArray objectAtIndex:i]objectForKey:@"autor"]intValue]];
                     notenbildindex++;
                  }
                  //int tempIndex = [[NotenArray objectAtIndex:i]intValue];
                  //[tempNotenArray addObject:[NotenArray objectAtIndex:i]];
                  [tempEpocheArray addObject:tempEpocheDic];
               }
               
            }
            NSLog(@"nummer 5 tempEpocheArray: %@",[tempEpocheArray description]);
            
            // Musik auswaehlen
            int soundindex=0;
            //NSLog(@"setAuswahl i: %d  MusikArray: %@",i,[MusikArray description]);
            for (i=0;i<[MusikArray count];i++)
            {
               //NSLog(@"MusikArray i: %d autor: %d",i,[[[MusikArray objectAtIndex:i]objectForKey:@"autor"]intValue]); 
               if ([[[MusikArray objectAtIndex:i]objectForKey:@"art"]intValue] == 1 
                   && [musikindex containsIndex:[[[MusikArray objectAtIndex:i]objectForKey:@"autor"]intValue]] )
               {
                  
                  //NSLog(@"5 Musik da: name: %@",[[MusikArray objectAtIndex:i]objectForKey:@"name"]);
                  if ([[NummerItem view]viewWithTag:(1000+soundindex)]) // Taste vorhanden
                  {
                     // identifier der Play-Taste zu position des Musikstuecks im Musikarray setzen
                     [[[NummerItem view]viewWithTag:(1000+soundindex)]setIdentifier:
                      [[NSNumber numberWithInt:(1000+i)]stringValue]];

                     // tag der Taste setzen
                     //[[[NummerItem view]viewWithTag:(1000+soundindex)]setTag:1000+i];
                     
                     [musikindex removeIndex:[[[NotenArray objectAtIndex:i]objectForKey:@"autor"]intValue]];
                     soundindex++;
                     
                     
                  } 
                  
               }
            }
            
            // Epoche auswaehlen
            int epochebildindex=0;
            int epocheergebnisindex=-1;
            for (i=0;i<[EpochenArray count];i++)
            {
               if ([[[EpochenArray objectAtIndex:i]objectForKey:@"art"]intValue] == 4 
                   && [epochenindex containsIndex:[[[EpochenArray objectAtIndex:i]objectForKey:@"autor"]intValue]] )
               {
                  NSLog(@"5 Epoche da: name: %@ epoche: %d",[[EpochenArray objectAtIndex:i]objectForKey:@"name"],[[[EpochenArray objectAtIndex:i]objectForKey:@"epoche"]intValue]);
                  [epochenindex removeIndex:[[[EpochenArray objectAtIndex:i]objectForKey:@"autor"]intValue] ];
                  
                  // index fuer richtiges Ergebnis setzen
                  epocheergebnisindex = [[[EpochenArray objectAtIndex:i]objectForKey:@"epoche"]intValue];
                  //[ErgebnisDic setObject:[[EpochenArray objectAtIndex:i]objectForKey:@"epoche"] forKey:@"lsg"];
                  
 
                  //[ErgebnisDic setObject:[[EpochenArray objectAtIndex:i]objectForKey:@"name"] forKey:@"lsgtext"];

                  //NSImage* bild = [[EpochenArray objectAtIndex:i]objectForKey:@"bild"];
                  [[[NummerItem view]viewWithTag:(6000+epochebildindex)]setImage:
                   [[EpochenArray objectAtIndex:i]objectForKey:@"bild"]];
                  [[[NummerItem view]viewWithTag:(9000+epochebildindex)]setStringValue:[[EpochenArray objectAtIndex:i]objectForKey:@"name"]];
                  
                  epochebildindex++;
                  
               }
               
            }//for
            
            //richtiges Ergebnis setzen
            
            // position der Epoche im tempEpocheArray fuer epocheergebnisindex
            int pos = [[tempEpocheArray valueForKey:@"epoche"]indexOfObject:[NSNumber numberWithInt:epocheergebnisindex]];
            //NSLog(@"nummer 5 position der Epoche im tempEpocheArray: %d",pos);
            
            if (pos) // pos des min ist an zweiter position
            {
               [ErgebnisDic setObject:@"rechts" forKey:@"lsgtext"];
               [ErgebnisDic setObject:[[tempEpocheArray valueForKey:@"epoche"]lastObject] forKey:@"lsg"];
            }
            else // pos des min ist an erster position
            {
               [ErgebnisDic setObject:@"links" forKey:@"lsgtext"];
               [ErgebnisDic setObject:[[tempEpocheArray valueForKey:@"epoche"]objectAtIndex:0] forKey:@"lsg"];
            }
             
            
            
         }break; // 5
            
            
      } // switch nummer
      
      //[[MasterErgebnisArray objectAtIndex:klasse]addObject:ErgebnisDic];
      
      switch (klasse)
      {
         case 0: //Klassewahl
         {
            
         }break;
            
         case 1: // standard
         {
            NSLog(@"standard nummer: %d",nummer);
         }break;
            
         case 2: // master
         {
            int ergebnispos = [[MasterErgebnisArray valueForKey:@"code"]indexOfObject:[ErgebnisDic objectForKey:@"code"]];
            NSLog(@"Master ErgebnisDic: %@ ergebnispos: %d",[ErgebnisDic description],ergebnispos);
            if (ergebnispos >=0)
            {
               [MasterErgebnisArray replaceObjectAtIndex:ergebnispos withObject:ErgebnisDic];
            }
            else 
            {
               [MasterErgebnisArray addObject:ErgebnisDic];
            }
            
            
            
         }break;
            
         case 3: // expert
         {
            NSLog(@"expert nummer: %d",nummer);
         }break;
            
      }// switch klasse
      //NSLog(@"setAuswahl end");
      return erfolg;
   }
   return 0;   
}

- (int)setAuswahlMitVorgabe:(int)vorgabe // Vorherige Wahl des Benutzers in Radio
{
   int erfolg=0;  
   NSLog(@"\n\n**   setAuswahl  *\n");
   NSTabViewItem* KlasseItem = [KlasseTab selectedTabViewItem];
   int klassewahl = [Klassewahl  selectedRow];
   int klasse = [KlasseTab  indexOfTabViewItem:KlasseItem];
   
   int nummer=0;
   if (klasse)
   {
      
      NSTabViewItem* NummerItem = [NummerTab selectedTabViewItem];
      //NSLog(@"ident: %@",[NummerTab  identifier]);
      nummer = [NummerTab  indexOfTabViewItem:NummerItem];
      
      NSMutableIndexSet* fotoindex = [NSMutableIndexSet indexSet];
      
      [fotoindex addIndexes:[[[[PList objectForKey:@"klassenarray"]objectAtIndex:klasse]objectAtIndex:nummer]objectForKey:@"fotoindex"]];
      //NSLog(@"fotoindex: %@",[fotoindex  description]);
      
      NSMutableIndexSet* notenindex = [NSMutableIndexSet indexSet];
      [notenindex addIndexes:[[[[PList objectForKey:@"klassenarray"]objectAtIndex:klasse]objectAtIndex:nummer]objectForKey:@"notenindex"]];
      
      NSMutableIndexSet* musikindex = [NSMutableIndexSet indexSet];
      [musikindex addIndexes:[[[[PList objectForKey:@"klassenarray"]objectAtIndex:klasse]objectAtIndex:nummer]objectForKey:@"musikindex"]];
      //NSLog(@"musikindex: %@",[musikindex  description]);
      
      NSMutableIndexSet* epochenindex = [NSMutableIndexSet indexSet];
      [epochenindex addIndexes:[[[[PList objectForKey:@"klassenarray"]objectAtIndex:klasse]objectAtIndex:nummer]objectForKey:@"epochenindex"]];
      //NSLog(@"epochenindex: %@",[epochenindex  description]);
      
      // Dic fuer Ergebnis des selectedTabView
      NSMutableDictionary* ErgebnisDic;
      //int checknummer = -1;
      long checknummer = NSNotFound;
      if ([MasterErgebnisArray count])
      {
         checknummer = [[MasterErgebnisArray valueForKey:@"nummer"]indexOfObject:[NSNumber numberWithInt:nummer]];
      }
      // if (checknummer >= 0) // schon ein Ergebnisdic da
      if (checknummer < NSNotFound) // schon ein Ergebnisdic da
      {
         ErgebnisDic = [MasterErgebnisArray objectAtIndex:checknummer];
      }
      else 
      {
         ErgebnisDic = [[NSMutableDictionary alloc]initWithCapacity:0];
         
      }
      //NSLog(@"checknummer: %d ErgebnisDic: %@",checknummer,[ErgebnisDic description]);
      
      int ergebnisindex=-1;
      [ErgebnisDic setObject:[NSNumber numberWithInt:nummer]forKey:@"nummer"];
      [ErgebnisDic setObject:[NSNumber numberWithInt:klasse]forKey:@"klasse"];
      [ErgebnisDic setObject:[NSNumber numberWithInt:(100*klasse + nummer)]forKey:@"code"];
      
      switch (nummer)  
      {
         case 0:
         {
            //NSArray* viewarray = [[NummerItem view]subviews];
            //NSLog(@"nummer 0 viewarray: %@",[viewarray description]);
            
            [[[NummerItem view]viewWithTag:8000] setKolonnen:3];
            [[[NummerItem view]viewWithTag:8000] setTitel:@"weiss nicht" inZeile:0 inKolonne:2];
            [[[NummerItem view]viewWithTag:8000] setStatus:1 inZeile:0 inKolonne:vorgabe];
            [[[NummerItem view]viewWithTag:8000] setAction:@selector(reportRadiotaste:)];
            [[[NummerItem view]viewWithTag:8000] setNeedsDisplay:YES];
            
            //NSLog(@"setAuswahl Klassewahl: %d Klassetab: %d nummer: %d",klassewahl,klasse,nummer);
            
            
            NSString* tempFrage;
            int i=0;
            for (i=0;i<[FragenArray count];i++)
            {
               if ([[[FragenArray objectAtIndex:i]objectForKey:@"klasse"]intValue] == klasse 
                   && [[[FragenArray objectAtIndex:i]objectForKey:@"nummer"]intValue] == nummer+1 )
               {
                  tempFrage = [[FragenArray objectAtIndex:i]objectForKey:@"frage"];
               }
            }
            //NSLog(@"tempFrage: %@",tempFrage);
            
            [[[NummerItem view]viewWithTag:(klasse*1000)+nummer]setStringValue:tempFrage];
            
            // Frage sichern
            [ErgebnisDic setObject:tempFrage forKey:@"frage"];
            
            // Foto auswaehlen
            int fotobildindex=0;
            
            for (i=0;i<[FotoArray count];i++)
            {
               if ([[[FotoArray objectAtIndex:i]objectForKey:@"art"]intValue] == 2 
                   && [fotoindex containsIndex:[[[FotoArray objectAtIndex:i]objectForKey:@"autor"]intValue]] )
               {
                  //NSLog(@"Foto da: name: %@",[[FotoArray objectAtIndex:i]objectForKey:@"name"]);
                  [fotoindex removeIndex:[[[FotoArray objectAtIndex:i]objectForKey:@"autor"]intValue] ];
                  NSImage* bild = [[FotoArray objectAtIndex:i]objectForKey:@"bild"];
                  [[[NummerItem view]viewWithTag:(6000+nummer+fotobildindex)]setImage:
                   [[FotoArray objectAtIndex:i]objectForKey:@"bild"]];
                  
                  NSMutableDictionary* tempFotoDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:0],@"eins",[NSNumber numberWithInt:0],@"zwei",[NSNumber numberWithInt:0],@"drei",[[FotoArray objectAtIndex:i]objectForKey:@"name"],@"name", nil];
                  
                  [AuswahlArray insertObject:tempFotoDic atIndex:0];
                  
                  // richtiges Ergebnis setzen
                  ergebnisindex = [[[FotoArray objectAtIndex:i]objectForKey:@"autor"]intValue];
                  [ErgebnisDic setObject:[[FotoArray objectAtIndex:i]objectForKey:@"autor"] forKey:@"lsg"];
                  [ErgebnisDic setObject:[[FotoArray objectAtIndex:i]objectForKey:@"name"] forKey:@"lsgtext"];
                  
                  // Bildlegende setzen
                  [Bildlegende setStringValue:[[FotoArray objectAtIndex:i]objectForKey:@"name"]];
                  fotobildindex++;
                  
               }
               
            }//for
            
            
            // [Auswahltabelle reloadData];
            
            
            // Auswahl bestimmen
            
            // Noten auswaehlen            
            NSMutableArray* tempNotenArray = [[NSMutableArray alloc]initWithCapacity:0];
            int notenbildindex=0;
            
            for (int j=0;j<[NotenArray count];j++)
            {
               if ([[[NotenArray objectAtIndex:j]objectForKey:@"art"]intValue] == 3 
                   && [notenindex containsIndex:[[[NotenArray objectAtIndex:j]objectForKey:@"autor"]intValue]] )
               {
                  if ([[NummerItem view]viewWithTag:(5000+100*nummer+notenbildindex)]) // Bild vorhanden
                  {
                     [[[NummerItem view]viewWithTag:(5000+100*nummer+notenbildindex)]setImage:
                      [[NotenArray objectAtIndex:j]objectForKey:@"bild"]];
                     [notenindex removeIndex:[[[NotenArray objectAtIndex:j]objectForKey:@"autor"]intValue]];
                     notenbildindex++;
                  }
                  //int tempIndex = [[NotenArray objectAtIndex:i]intValue];
                  [tempNotenArray addObject:[NotenArray objectAtIndex:j]];
                  
               }
               
            }
            //NSLog(@"tempNotenArray: %@",[tempNotenArray description]);
            
            // Musik auswaehlen
            int soundindex=0;
            NSLog(@"setAuswahl  MusikArray: %@",[[MusikArray valueForKey:@"name"]description]);
            for (i=0;i<[MusikArray count];i++)
            {
               //NSLog(@"MusikArray i: %d autor: %d",i,[[[MusikArray objectAtIndex:i]objectForKey:@"autor"]intValue]); 
               if ([[[MusikArray objectAtIndex:i]objectForKey:@"art"]intValue] == 1 
                   && [musikindex containsIndex:[[[MusikArray objectAtIndex:i]objectForKey:@"autor"]intValue]] )
               {
                  int ergebniscode =[[[MusikArray objectAtIndex:i]objectForKey:@"autor"]intValue];
                  [[[NummerItem view]viewWithTag:8000]setErgebniscode:ergebniscode inZeile:0 inKolonne:soundindex];
                  
                  //NSLog(@"Musik da: name: %@",[[MusikArray objectAtIndex:i]objectForKey:@"name"]);
                  if ([[NummerItem view]viewWithTag:(1000+soundindex)]) // Taste vorhanden
                  {
                     // identifier der Play-Taste zu position des Musikstuecks im Musikarray setzen
                     [[[NummerItem view]viewWithTag:(1000+soundindex)]setIdentifier:
                      [[NSNumber numberWithInt:(1000+i)]stringValue]];
                     
                     // tag der Taste setzen
                     //[[[NummerItem view]viewWithTag:(1000+soundindex)]setTag:1000+i];
                     [[[NummerItem view]viewWithTag:(1000+soundindex)]setState:0];
                     
                     [musikindex removeIndex:[[[NotenArray objectAtIndex:i]objectForKey:@"autor"]intValue]];
                     soundindex++;
                     
                  } 
                  
               }
            }
            
            // Welches Stück hat dieser Komponist geschrieben?
            // autor von Foto muss gleich sein wie Musik
            
            
            
         }break; // case 0
            
         case 1:
         {
            // Wer hat dieses Stück komponiert?
            // autor von Foto muss gleich sein wie von Musik
            
            [(rRadioMatrix*)[[NummerItem view]viewWithTag:8000] setKolonnen:3];
            [[[NummerItem view]viewWithTag:8000] setTitel:@"weiss nicht" inZeile:0 inKolonne:2];
            [[[NummerItem view]viewWithTag:8000] setStatus:1 inZeile:0 inKolonne:vorgabe];
            [[[NummerItem view]viewWithTag:8000] setNeedsDisplay:YES];
            [[[NummerItem view]viewWithTag:8000] setAction:@selector(reportRadiotaste:)];
            
            // Frage lesen
            NSString* tempFrage;
            int i=0;
            for (i=0;i<[FragenArray count];i++)
            {
               if ([[[FragenArray objectAtIndex:i]objectForKey:@"klasse"]intValue] == klasse 
                   && [[[FragenArray objectAtIndex:i]objectForKey:@"nummer"]intValue] == nummer+1 )
               {
                  tempFrage = [[FragenArray objectAtIndex:i]objectForKey:@"frage"];
               }
            }
            //NSLog(@"tempFrage: %@",tempFrage);
            
            [[[NummerItem view]viewWithTag:(klasse*1000)]setStringValue:tempFrage];
            
            // Frage sichern
            [ErgebnisDic setObject:tempFrage forKey:@"frage"];
            
            
            //Bilder der Autoren suchen
            int fotobildindex=0;
            
            for (i=0;i<[FotoArray count];i++)
            {
               if ([[[FotoArray objectAtIndex:i]objectForKey:@"art"]intValue] == 2 
                   && [fotoindex containsIndex:[[[FotoArray objectAtIndex:i]objectForKey:@"autor"]intValue]] )
               {
                  // Ergebniscode in Tasten setzen: "autor"
                  int ergebniscode =[[[FotoArray objectAtIndex:i]objectForKey:@"autor"]intValue];
                  [[[NummerItem view]viewWithTag:8000]setErgebniscode:ergebniscode inZeile:0 inKolonne:fotobildindex];
                  
                  
                  //NSLog(@"Foto da fotobildindex: %d : name: %@",fotobildindex,[[FotoArray objectAtIndex:i]objectForKey:@"name"]);
                  [fotoindex removeIndex:[[[FotoArray objectAtIndex:i]objectForKey:@"autor"]intValue] ];
                  
                  NSImage* bild = [[FotoArray objectAtIndex:i]objectForKey:@"bild"];
                  
                  // Name in Auswahlradio einsetzen
                  [(rRadioMatrix*)[[NummerItem view]viewWithTag:(8000)]setTitel:[[FotoArray objectAtIndex:i]objectForKey:@"name"] inZeile:0 inKolonne:fotobildindex];
                  
                  
                  [[[NummerItem view]viewWithTag:(6000+fotobildindex)]setImage:
                   [[FotoArray objectAtIndex:i]objectForKey:@"bild"]];
                  
                  //[Bildlegende setStringValue:[[FotoArray objectAtIndex:i]objectForKey:@"name"]];
                  fotobildindex++;
                  
               }
               
            }//for
            
            
            // Noten auswaehlen
            NSMutableArray* tempNotenArray = [[NSMutableArray alloc]initWithCapacity:0];
            int notenbildindex=0;
            
            for (i=0;i<[NotenArray count];i++)
            {
               if ([[[NotenArray objectAtIndex:i]objectForKey:@"art"]intValue] == 3 
                   && [notenindex containsIndex:[[[NotenArray objectAtIndex:i]objectForKey:@"autor"]intValue]] )
               {
                  if ([[NummerItem view]viewWithTag:(5000+notenbildindex)]) // Bildobjekt vorhanden
                  {
                     [[[NummerItem view]viewWithTag:(5000+notenbildindex)]setImage:
                      [[NotenArray objectAtIndex:i]objectForKey:@"bild"]];
                     [notenindex removeIndex:[[[NotenArray objectAtIndex:i]objectForKey:@"autor"]intValue]];
                     notenbildindex++;
                  }
                  //int tempIndex = [[NotenArray objectAtIndex:i]intValue];
                  [tempNotenArray addObject:[NotenArray objectAtIndex:i]];
                  
               }
               
            }
            
            
            // Musik auswaehlen
            int soundindex=0;
            
            for (i=0;i<[MusikArray count];i++)
            {
               if ([[[MusikArray objectAtIndex:i]objectForKey:@"art"]intValue] == 1 
                   && [musikindex containsIndex:[[[NotenArray objectAtIndex:i]objectForKey:@"autor"]intValue]] )
               {
                  
                  //NSLog(@"1 Musik da: name: %@",[[MusikArray objectAtIndex:i]objectForKey:@"name"]);
                  if ([[NummerItem view]viewWithTag:(1000+soundindex)]) // Taste vorhanden
                  {
                     // identifier der Play-Taste zu position des Musikstuecks im Musikarray setzen
                     [[[NummerItem view]viewWithTag:(1000+soundindex)]setIdentifier:
                      [[NSNumber numberWithInt:(1000+i)]stringValue]];
                     
                     //[[[NummerItem view]viewWithTag:(1000+soundindex)]setTag:1000+i];
                     
                     [musikindex removeIndex:[[[NotenArray objectAtIndex:i]objectForKey:@"autor"]intValue]];
                     soundindex++;
                     
                     // richtiges Ergebnis setzen
                     ergebnisindex = [[[NotenArray objectAtIndex:i]objectForKey:@"autor"]intValue];
                     [ErgebnisDic setObject:[[NotenArray objectAtIndex:i]objectForKey:@"autor"] forKey:@"lsg"];
                     [ErgebnisDic setObject:[[NotenArray objectAtIndex:i]objectForKey:@"name"] forKey:@"lsgtext"];
                     
                  } 
                  
               }
            }
            
            
            
         }break; // case 1
            
         case 2: 
         {
            // Welches dieser Stücke ist früher komponiert worden?
            /*
             NSArray* viewarray = [[NummerItem view]subviews];
             NSLog(@"nummer 2 viewarray: %@",[viewarray description]);
             int k=0;
             for (k=0;k<[viewarray count];k++)
             {
             NSLog(@"k: %d tag: %ld",k,[[viewarray objectAtIndex:k]tag]);
             }
             */
            
            [(rRadioMatrix*)[[NummerItem view]viewWithTag:8000] setKolonnen:3];
            [[[NummerItem view]viewWithTag:8000] setTitel:@"weiss nicht" inZeile:0 inKolonne:2];
            [[[NummerItem view]viewWithTag:8000] setStatus:1 inZeile:0 inKolonne:vorgabe];
            [[[NummerItem view]viewWithTag:8000] setNeedsDisplay:YES];
            [[[NummerItem view]viewWithTag:8000] setAction:@selector(reportRadiotaste:)];
            
            NSImage* komponierenbild = [NSImage imageNamed:@"komponieren.jpg"];
            [[[NummerItem view]viewWithTag:7000]setImage:komponierenbild];
            
            
            // Frage lesen
            NSString* tempFrage;
            int i=0;
            for (i=0;i<[FragenArray count];i++)
            {
               if ([[[FragenArray objectAtIndex:i]objectForKey:@"klasse"]intValue] == klasse 
                   && [[[FragenArray objectAtIndex:i]objectForKey:@"nummer"]intValue] == nummer+1 )
               {
                  tempFrage = [[FragenArray objectAtIndex:i]objectForKey:@"frage"];
               }
            }
            //NSLog(@"tempFrage: %@",tempFrage);
            [[[NummerItem view]viewWithTag:(klasse*1000)]setStringValue:tempFrage];
            
            // Frage sichern
            [ErgebnisDic setObject:tempFrage forKey:@"frage"];
            
            
            
            // Musik auswaehlen
            int soundindex=0;
            
            // IndexSet fuer Epoche der Komponisten-Fotos
            NSMutableIndexSet* tempEpocheindex = [NSMutableIndexSet indexSet];
            
            // Array fuer Dics mit den Angaben zur Epoche
            NSMutableArray* tempEpocheArray = [[NSMutableArray alloc]initWithCapacity:0];
            
            for (i=0;i<[MusikArray count];i++)
            {
               if ([[[MusikArray objectAtIndex:i]objectForKey:@"art"]intValue] == 1 
                   && [musikindex containsIndex:[[[NotenArray objectAtIndex:i]objectForKey:@"autor"]intValue]] )
               {
                  
                  NSMutableDictionary* tempEpocheDic = [[NSMutableDictionary alloc]initWithCapacity:0];
                  // epoche einsetzen
                  //[tempEpocheindex addIndex:[[[FotoArray objectAtIndex:i]objectForKey:@"epoche"]intValue]];
                  NSNumber* epochenumber = [[MusikArray objectAtIndex:i]objectForKey:@"epoche"];
                  [tempEpocheDic setObject:[NSNumber numberWithInt:[[[MusikArray objectAtIndex:i]objectForKey:@"epoche"]intValue]] forKey:@"epoche"];
                  
                  // Lage der Epoche im EpochenArray
                  long epochepos =[[EpochenArray valueForKey:@"epoche"]indexOfObject:epochenumber];
                  //NSLog(@"i: %d epochepos: %d ",i,epochepos);
                  //Name der Epoche an epochepos holen
                  [tempEpocheDic setObject:[[EpochenArray objectAtIndex:epochepos]objectForKey:@"name"] forKey:@"epochename"];
                  [tempEpocheDic setObject:[NSNumber numberWithInt:soundindex] forKey:@"pos"];
                  
                  NSLog(@"i: %d tempEpocheDic: %@",i, [tempEpocheDic description]);
                  [tempEpocheArray addObject:tempEpocheDic];
                  
                  
                  //int ergebniscode =[[[MusikArray objectAtIndex:i]objectForKey:@"autor"]intValue];
                  int ergebniscode =[[[MusikArray objectAtIndex:i]objectForKey:@"epoche"]intValue];
                  
                  [[[NummerItem view]viewWithTag:8000]setErgebniscode:ergebniscode inZeile:0 inKolonne:soundindex];
                  
                  
                  
                  //NSLog(@"2 Musik da: name: %@",[[MusikArray objectAtIndex:i]objectForKey:@"name"]);
                  if ([[NummerItem view]viewWithTag:(1000+soundindex)]) // Taste vorhanden
                  {
                     // identifier der Taste zu position des Musikstuecks im Musikarray setzen
                     
                     [[[NummerItem view]viewWithTag:(1000+soundindex)]setIdentifier:[[NSNumber numberWithInt:(1000+i)]stringValue]];
                     
                     //[[[NummerItem view]viewWithTag:(1000+soundindex)]setIdentifier:[[NSNumber numberWithInt:(1000+epochepos)]stringValue]];
                     
                     //[[[NummerItem view]viewWithTag:(1000+soundindex)]setTag: 1000+i];
                     
                     [musikindex removeIndex:[[[NotenArray objectAtIndex:i]objectForKey:@"autor"]intValue]];
                     soundindex++;
                     
                  } 
                  
               }
            } // for i Musikarray
            
            // richtiges Ergebnis setzen
            //int richtigindex = min([musikindex firstIndex],[musikindex lastIndex]);
            //NSLog(@"nummer 2 ind0: %lu ind1: %lu max: %d",[musikindex firstIndex],[musikindex lastIndex],richtigindex);
            
            
            int richtigindex = [self minVonArray:[tempEpocheArray valueForKey:@"epoche"]];
            int pos = [[tempEpocheArray valueForKey:@"epoche"]indexOfObject:[NSNumber numberWithInt:richtigindex]];
            NSString* epochename = [[tempEpocheArray objectAtIndex:pos]objectForKey:@"epochename"];
            NSLog(@"nummer 2 richtigindex: %d pos: %d tempEpocheArray: %@ ",richtigindex, pos, [tempEpocheArray description]);
            //NSLog(@"nummer 2 richtigindex: %d pos: %d name zu richtigindex: %@ ",richtigindex, pos, epochename);
            
            if (pos) // pos des min ist an zweiter position
            {
               [ErgebnisDic setObject:@"rechts" forKey:@"lsgtext"];
               [ErgebnisDic setObject:[[tempEpocheArray valueForKey:@"epoche"]lastObject] forKey:@"lsg"];
            }
            else // pos des min ist an erster position
            {
               [ErgebnisDic setObject:@"links" forKey:@"lsgtext"];
               [ErgebnisDic setObject:[[tempEpocheArray valueForKey:@"epoche"]objectAtIndex:0] forKey:@"lsg"];
            }
            
            
            // Noten auswaehlen
            NSMutableArray* tempNotenArray = [[NSMutableArray alloc]initWithCapacity:0];
            int notenbildindex=0;
            
            for (i=0;i<[NotenArray count];i++)
            {
               if ([[[NotenArray objectAtIndex:i]objectForKey:@"art"]intValue] == 3 
                   && [notenindex containsIndex:[[[NotenArray objectAtIndex:i]objectForKey:@"autor"]intValue]] )
               {
                  //                int ergebniscode =[[[NotenArray objectAtIndex:i]objectForKey:@"autor"]intValue];
                  //                 [[[NummerItem view]viewWithTag:8000]setErgebniscode:ergebniscode inZeile:0 inKolonne:notenbildindex];
                  
                  //NSLog(@"2 Bild da: name: %@",[[MusikArray objectAtIndex:i]objectForKey:@"name"]);
                  if ([[NummerItem view]viewWithTag:(5000+notenbildindex)]) // Bildobjekt vorhanden
                  {
                     [[[NummerItem view]viewWithTag:(5000+notenbildindex)]setImage:
                      [[NotenArray objectAtIndex:i]objectForKey:@"bild"]];
                     [notenindex removeIndex:[[[NotenArray objectAtIndex:i]objectForKey:@"autor"]intValue]];
                     notenbildindex++;
                  }
                  //int tempIndex = [[NotenArray objectAtIndex:i]intValue];
                  [tempNotenArray addObject:[NotenArray objectAtIndex:i]];
                  
               }
               
            }
            
            
         }break; // case 2
            
            
         case 3: 
         {
            // Welcher dieser Komponisten lebte näher zu unserer Zeit?
            /*
             NSArray* viewarray = [[NummerItem view]subviews];
             int k=0;
             for (k=0;k<[viewarray count];k++)
             {
             NSLog(@"k: %d tag: %ld",k,[[viewarray objectAtIndex:k]tag]);
             }
             */
            [(rRadioMatrix*)[[NummerItem view]viewWithTag:8000] setKolonnen:3];
            [[[NummerItem view]viewWithTag:8000] setTitel:@"no idea" inZeile:0 inKolonne:2];
            [[[NummerItem view]viewWithTag:8000] setStatus:1 inZeile:0 inKolonne:vorgabe];
            [[[NummerItem view]viewWithTag:8000] setNeedsDisplay:YES];
            [[[NummerItem view]viewWithTag:8000] setAction:@selector(reportRadiotaste:)];
            // Frage lesen
            NSString* tempFrage;
            int i=0;
            for (i=0;i<[FragenArray count];i++)
            {
               if ([[[FragenArray objectAtIndex:i]objectForKey:@"klasse"]intValue] == klasse 
                   && [[[FragenArray objectAtIndex:i]objectForKey:@"nummer"]intValue] == nummer+1 )
               {
                  tempFrage = [[FragenArray objectAtIndex:i]objectForKey:@"frage"];
               }
            }
            //NSLog(@"tempFrage: %@",tempFrage);
            
            // Welcher dieser Komponisten lebte näher zu unserer Zeit?
            
            [[[NummerItem view]viewWithTag:(klasse*1000)]setStringValue:tempFrage];
            
            // Frage sichern
            [ErgebnisDic setObject:tempFrage forKey:@"frage"];
            
            
            // Bilder auswaehlen
            int fotobildindex=0;
            
            // IndexSet fuer Epoche der Komponisten-Fotos
            NSMutableIndexSet* tempEpocheindex = [NSMutableIndexSet indexSet];
            
            // Array fuer Dics mit den Angaben zur Epoche
            NSMutableArray* tempEpocheArray = [[NSMutableArray alloc]initWithCapacity:0];
            
            for (i=0;i<[FotoArray count];i++)
            {
               if ([[[FotoArray objectAtIndex:i]objectForKey:@"art"]intValue] == 2 
                   && [fotoindex containsIndex:[[[FotoArray objectAtIndex:i]objectForKey:@"autor"]intValue]]) 
               {
                  //NSLog(@"3 Foto da fotobildindex: %d : name: %@ epoche: %d",fotobildindex,[[FotoArray objectAtIndex:i]objectForKey:@"name"],[[[FotoArray objectAtIndex:i]objectForKey:@"epoche"]intValue]);
                  
                  NSMutableDictionary* tempEpocheDic = [[NSMutableDictionary alloc]initWithCapacity:0];
                  
                  // epoche einsetzen für das Bild an position i
                  [tempEpocheindex addIndex:[[[FotoArray objectAtIndex:i]objectForKey:@"epoche"]intValue]];
                  NSNumber* epochenumber = [[FotoArray objectAtIndex:i]objectForKey:@"epoche"];
                  [tempEpocheDic setObject:[NSNumber numberWithInt:[[[FotoArray objectAtIndex:i]objectForKey:@"epoche"]intValue]] forKey:@"epoche"];
                  
                  // Lage der Epoche im EpochenArray
                  long epochepos =[[EpochenArray valueForKey:@"epoche"]indexOfObject:epochenumber];
                  //NSLog(@"i: %d epochepos: %d ",i,epochepos);
                  
                  //Name der Epoche an epochepos holen
                  [tempEpocheDic setObject:[[EpochenArray objectAtIndex:epochepos]objectForKey:@"name"] forKey:@"epochename"];
                  
                  //NSLog(@"i: %d tempEpocheDic: %@",i, [tempEpocheDic description]);
                  [tempEpocheArray addObject:tempEpocheDic];
                  
                  
                  // Bild des Komponisten in View 6000+i einsetzen
                  [[[NummerItem view]viewWithTag:(6000+fotobildindex)]setImage:
                   [[FotoArray objectAtIndex:i]objectForKey:@"bild"]];
                  
                  // Name des Komponisten in Radiobutton 'fotobildindex' einsetzen
                  [(rRadioMatrix*)[[NummerItem view]viewWithTag:(8000)]setTitel:[[FotoArray objectAtIndex:i]objectForKey:@"name"] inZeile:0 inKolonne:fotobildindex];
                  
                  // aktuellen code es Autors aus fotoindex entfernen
                  [fotoindex removeIndex:[[[FotoArray objectAtIndex:i]objectForKey:@"autor"]intValue]];
                  
                  //[Bildlegende setStringValue:[[FotoArray objectAtIndex:i]objectForKey:@"name"]];
                  fotobildindex++;
                  
               }
            } // for i FotoArray
            
            // richtiges Ergebnis setzen
            
            // Maximum des Wertes fuer Epoche aus tempEpocheArray holen
            int richtigindex = [self maxVonArray:[tempEpocheArray valueForKey:@"epoche"]];
            
            //Position in FotoArray zu epoche holen
            int pos = [[FotoArray valueForKey:@"epoche"]indexOfObject:[NSNumber numberWithInt:richtigindex]];
            NSLog(@"nummer 3 pos: %d",pos);
            
            NSString* komponistzuepochename = [[FotoArray objectAtIndex:pos]objectForKey:@"name"];
            
            NSLog(@"nummer 3 richtigindex: %d pos: %d name zu richtigindex: %@ ",richtigindex, pos, komponistzuepochename);
            
            [ErgebnisDic setObject:[NSNumber numberWithInt:richtigindex] forKey:@"lsg"];
            [ErgebnisDic setObject:komponistzuepochename forKey:@"lsgtext"];
            
            // Musik auswaehlen
            int soundindex=0;
            
            NSArray* viewarray = [[NummerItem view]subviews];
            int k=0;
            for (k=0;k<[viewarray count];k++)
            {
               //NSLog(@"Aufgabe 3 k: %d tag: %ld %@",k,[[viewarray objectAtIndex:k]tag],[[viewarray objectAtIndex:k]description]);
            }
            
            //            NSLog(@"nummer 3  musikindex : %@",[musikindex description]);
            for (i=0;i<[MusikArray count];i++)
            {
               //               NSLog(@"nummer 3 i: %d musikindex : %@ autor: %d ",i,[musikindex description],[[[MusikArray objectAtIndex:i]objectForKey:@"autor"]intValue]);
               
               if ([[[MusikArray objectAtIndex:i]objectForKey:@"art"]intValue] == 1 
                   && [musikindex containsIndex:[[[NotenArray objectAtIndex:i]objectForKey:@"autor"]intValue]] )
               {
                  
                  //                  NSLog(@"3 soundindex: %d Musik da: name: %@",soundindex,[[MusikArray objectAtIndex:i]objectForKey:@"name"]);
                  if ([[NummerItem view]viewWithTag:(1000+soundindex)]) // Play-Taste vorhanden
                  {
                     int ergebniscode =[[[MusikArray objectAtIndex:i]objectForKey:@"epoche"]intValue];
                     //                     NSLog(@"nummer 3 taste: %d ergebniscode Musik: %d",soundindex, ergebniscode);
                     [[[NummerItem view]viewWithTag:8000]setErgebniscode:ergebniscode inZeile:0 inKolonne:soundindex];
                     
                     
                     // identifier der Play-Taste zu position des Musikstuecks im Musikarray setzen
                     [[[NummerItem view]viewWithTag:(1000+soundindex)]setIdentifier:
                      [[NSNumber numberWithInt:(1000+i)]stringValue]];
                     
                     // [[[NummerItem view]viewWithTag:(1000+soundindex)]setTag:1000+i];
                     
                     [musikindex removeIndex:[[[MusikArray objectAtIndex:i]objectForKey:@"autor"]intValue]];
                     soundindex++;
                     
                  }
                  else 
                  {
                     
                     //                     NSLog(@"i: %d keine Taste",i); 
                  }
                  
               }
               else 
               {
                  //                  NSLog(@"i: %d index nicht da",i); 
               }
            }
            NSImage* kalenderbild = [NSImage imageNamed:@"kalender_hg.png"];
            /*
             NSRect imageFrame = [[[NummerItem view]viewWithTag:7000]frame];
             [kalenderbild lockFocus];
             // [kalenderbild setScalesWhenResized:YES];
             float radius = imageFrame.size.width/2;
             NSLog(@"radius: %2.2f",radius);
             [NSGraphicsContext saveGraphicsState];
             NSBezierPath *path = [NSBezierPath bezierPathWithRoundedRect:imageFrame
             xRadius:radius
             yRadius:radius];
             [path addClip];
             
             [kalenderbild drawInRect:imageFrame
             fromRect:NSZeroRect
             operation:NSCompositeSourceOver
             fraction:1.0];
             [kalenderbild unlockFocus];
             [NSGraphicsContext restoreGraphicsState];
             */
            
            [[[NummerItem view]viewWithTag:7000]setImage:kalenderbild];
            
            
            
         }break; // case 3
            
         case 4:
         {
            // In welcher Epoche lebte dieser Komponist?
            
            NSArray* viewarray = [[[NummerTab selectedTabViewItem]view ]subviews];
            int k=0;
            for (k=0;k<[viewarray count];k++)
            {
               //NSLog(@"Aufgabe 4 k: %d tag: %ld %@",k,[[viewarray objectAtIndex:k]tag],[[viewarray objectAtIndex:k]description]);
            }
            
            [(rRadioMatrix*)[[NummerItem view]viewWithTag:8000] setKolonnen:3];
            [[[NummerItem view]viewWithTag:8000] setTitel:@"weiss nicht" inZeile:0 inKolonne:2];
            [[[NummerItem view]viewWithTag:8000] setStatus:1 inZeile:0 inKolonne:vorgabe];
            [[[NummerItem view]viewWithTag:8000] setNeedsDisplay:YES];
            [[[NummerItem view]viewWithTag:8000] setAction:@selector(reportRadiotaste:)];
            
            // Frage lesen
            NSString* tempFrage;
            int i=0;
            for (i=0;i<[FragenArray count];i++)
            {
               if ([[[FragenArray objectAtIndex:i]objectForKey:@"klasse"]intValue] == klasse 
                   && [[[FragenArray objectAtIndex:i]objectForKey:@"nummer"]intValue] == nummer+1 )
               {
                  tempFrage = [[FragenArray objectAtIndex:i]objectForKey:@"frage"];
               }
            }
            //NSLog(@"Nr. 4 tempFrage: %@",tempFrage);
            
            // In welcher Epoche lebte dieser Komponist?
            
            [[[NummerItem view]viewWithTag:(klasse*1000)]setStringValue:tempFrage];
            // Frage sichern
            [ErgebnisDic setObject:tempFrage forKey:@"frage"];
            
            
            // Musik auswaehlen 
            int soundindex=0;
            
            
            for (i=0;i<[MusikArray count];i++)
            {
               if ([[[MusikArray objectAtIndex:i]objectForKey:@"art"]intValue] == 1 
                   && [musikindex containsIndex:[[[MusikArray objectAtIndex:i]objectForKey:@"autor"]intValue]] )
               {
                  
                  //NSLog(@"4 Musik da: name: %@ epoche: %d",[[MusikArray objectAtIndex:i]objectForKey:@"name"],[[[MusikArray objectAtIndex:i]objectForKey:@"epoche"]intValue]);
                  
                  
                  // Musik in Play-Taste einsetzen
                  if ([[NummerItem view]viewWithTag:(1000+soundindex)]) // Taste vorhanden
                  {
                     // identifier der Play-Taste zu position des Musikstuecks im Musikarray setzen
                     [[[NummerItem view]viewWithTag:(1000+soundindex)]setIdentifier:
                      [[NSNumber numberWithInt:(1000+i)]stringValue]];
                     
                     // benutzten index aus musikindex entfernen
                     [musikindex removeIndex:[[[MusikArray objectAtIndex:i]objectForKey:@"autor"]intValue]];
                     [Bildlegende setStringValue:[[FotoArray objectAtIndex:i]objectForKey:@"name"]];
                     
                     soundindex++;
                     
                  } 
                  
               }
            }
            
            // Bild auswaehlen fuer Komponist
            int fotobildindex=0;
            
            // Epoche des Komponisten
            int lsgepoche=-1;
            for (i=0;i<[FotoArray count];i++)
            {
               if ([[[FotoArray objectAtIndex:i]objectForKey:@"art"]intValue] == 2 
                   && [fotoindex containsIndex:[[[FotoArray objectAtIndex:i]objectForKey:@"autor"]intValue]] )
               {
                  
                  NSLog(@"4 Foto da fotobildindex: %d : name: %@ epoche: %d",fotobildindex,[[FotoArray objectAtIndex:i]objectForKey:@"name"], [[[FotoArray objectAtIndex:i]objectForKey:@"epoche"]intValue]);
                  [fotoindex removeIndex:[[[FotoArray objectAtIndex:i]objectForKey:@"autor"]intValue] ];
                  
                  // Epoche des Komponisten 
                  [ErgebnisDic setObject:[[FotoArray objectAtIndex:i]objectForKey:@"epoche"] forKey:@"lsg"];
                  lsgepoche = [[[FotoArray objectAtIndex:i]objectForKey:@"epoche"]intValue];
                  //[ErgebnisDic setObject:[[FotoArray objectAtIndex:i]objectForKey:@"name"] forKey:@"lsgtext"];
                  
                  
                  //NSImage* bild = [[FotoArray objectAtIndex:i]objectForKey:@"bild"];
                  
                  // Bild der Epoche  im View 5000+fotobildindex einsetzen. 
                  [[[NummerItem view]viewWithTag:(5000+fotobildindex)]setImage:[[FotoArray objectAtIndex:i]objectForKey:@"bild"]];
                  
                  // Name der Epoche in View 9000+fotobildindex einsetzen
                  [[[NummerItem view]viewWithTag:(9000+fotobildindex)]setStringValue:[[FotoArray objectAtIndex:i]objectForKey:@"name"]];
                  
                  
                  // Name der Epoche in Radio einsetzen
                  [(rRadioMatrix*)[[NummerItem view]viewWithTag:(8000)]setTitel:[[FotoArray objectAtIndex:i]objectForKey:@"name"] inZeile:0 inKolonne:fotobildindex];
                  
                  
                  //[Bildlegende setStringValue:[[FotoArray objectAtIndex:i]objectForKey:@"name"]];
                  fotobildindex++;
                  
               }
            }
            
            //Position in EpochenArray zu epoche holen
            int pos = [[EpochenArray valueForKey:@"epoche"]indexOfObject:[NSNumber numberWithInt:lsgepoche]];
            //NSLog(@"nummer 4 pos: %d epochename: %@",pos,[[EpochenArray objectAtIndex:pos]valueForKey:@"name"]);
            
            // Name der Epoche in ErgebnisDic einsetzen
            [ErgebnisDic setObject:[[EpochenArray objectAtIndex:pos]valueForKey:@"name"] forKey:@"lsgtext"];
            
            // Epoche auswaehlen und in Radio einsetzen
            int epochebildindex=0;
            
            for (i=0;i<[EpochenArray count];i++)
            {
               if ([[[EpochenArray objectAtIndex:i]objectForKey:@"art"]intValue] == 4 
                   && [epochenindex containsIndex:[[[EpochenArray objectAtIndex:i]objectForKey:@"autor"]intValue]] )
               {
                  // Ergebniscode der Epoche in Radio einsetzen
                  int ergebniscode =[[[EpochenArray objectAtIndex:i]objectForKey:@"epoche"]intValue];
                  [[[NummerItem view]viewWithTag:8000]setErgebniscode:ergebniscode inZeile:0 inKolonne:epochebildindex];
                  
                  //Bild in View 6000+epochebildindex einsetzen
                  [[[NummerItem view]viewWithTag:(6000+epochebildindex)]setImage:[[EpochenArray objectAtIndex:i]objectForKey:@"bild"]];
                  
                  // Epoche des Bildes in Radio an pos epochebildindex einsetzen
                  [(rRadioMatrix*)[[NummerItem view]viewWithTag:(8000)]setTitel:[[EpochenArray objectAtIndex:i]objectForKey:@"name"] inZeile:0 inKolonne:epochebildindex];
                  
                  epochebildindex++;
               }
            }
            
            
         }break; // 4
            
         case 5: // Aufgabe 6 // Welches Stück wurde in dieser Epoche komponiert?
         {
            NSArray* viewarray = [[[NummerTab selectedTabViewItem]view ]subviews];
            int k=0;
            for (k=0;k<[viewarray count];k++)
            {
               //NSLog(@"Aufgabe 5 k: %d tag: %ld %@",k,[[viewarray objectAtIndex:k]tag],[[viewarray objectAtIndex:k]description]);
            }
            
            [(rRadioMatrix*)[[NummerItem view]viewWithTag:8000] setKolonnen:3];
            [[[NummerItem view]viewWithTag:8000] setTitel:@"weiss nicht" inZeile:0 inKolonne:2];
            [[[NummerItem view]viewWithTag:8000] setStatus:1 inZeile:0 inKolonne:vorgabe];
            [[[NummerItem view]viewWithTag:8000] setNeedsDisplay:YES];
            [[[NummerItem view]viewWithTag:8000] setAction:@selector(reportRadiotaste:)];
            
            // Frage lesen
            NSString* tempFrage;
            int i=0;
            for (i=0;i<[FragenArray count];i++)
            {
               if ([[[FragenArray objectAtIndex:i]objectForKey:@"klasse"]intValue] == klasse 
                   && [[[FragenArray objectAtIndex:i]objectForKey:@"nummer"]intValue] == nummer+1 )
               {
                  tempFrage = [[FragenArray objectAtIndex:i]objectForKey:@"frage"];
               }
            }
            //NSLog(@"Nr. 5 tempFrage: %@",tempFrage);
            
            // Welches Stück wurde in dieser Epoche komponiert?
            
            [[[NummerItem view]viewWithTag:(klasse*1000)]setStringValue:tempFrage];
            
            // Frage sichern
            [ErgebnisDic setObject:tempFrage forKey:@"frage"];
            
            
            // Noten auswaehlen            
            //NSMutableArray* tempNotenArray = [[NSMutableArray alloc]initWithCapacity:0];
            int notenbildindex=0;
            
            // Array fuer Dics mit den Angaben zur Epoche
            NSMutableArray* tempEpocheArray = [[NSMutableArray alloc]initWithCapacity:0];
            
            for (i=0;i<[NotenArray count];i++)
            {
               if ([[[NotenArray objectAtIndex:i]objectForKey:@"art"]intValue] == 3 
                   && [notenindex containsIndex:[[[NotenArray objectAtIndex:i]objectForKey:@"autor"]intValue]] )
               {
                  
                  NSMutableDictionary* tempEpocheDic = [[NSMutableDictionary alloc]initWithCapacity:0];
                  
                  
                  [tempEpocheDic setObject:[NSNumber numberWithInt:notenbildindex] forKey:@"pos"];
                  // epoche der Noten von position i einsetzen
                  NSNumber* epochenumber = [[NotenArray objectAtIndex:i]objectForKey:@"epoche"];
                  [tempEpocheDic setObject:[[NotenArray objectAtIndex:i]objectForKey:@"epoche"] forKey:@"epoche"];
                  
                  
                  
                  if ([[NummerItem view]viewWithTag:(5000+notenbildindex)]) // Bild vorhanden
                  {
                     [[[NummerItem view]viewWithTag:(5000+notenbildindex)]setImage:
                      [[NotenArray objectAtIndex:i]objectForKey:@"bild"]];
                     
                     NSLog(@"5 Noten da notenbildindex: %d : name: %@ epoche: %d",notenbildindex,[[NotenArray objectAtIndex:i]objectForKey:@"name"], [[[NotenArray objectAtIndex:i]objectForKey:@"epoche"]intValue]);
                     
                     // Ergebniscode der Epoche in Radio einsetzen
                     int ergebniscode =[[[NotenArray objectAtIndex:i]objectForKey:@"epoche"]intValue];
                     [[[NummerItem view]viewWithTag:8000]setErgebniscode:ergebniscode inZeile:0 inKolonne:notenbildindex];
                     
                     
                     [notenindex removeIndex:[[[NotenArray objectAtIndex:i]objectForKey:@"autor"]intValue]];
                     notenbildindex++;
                  }
                  //int tempIndex = [[NotenArray objectAtIndex:i]intValue];
                  //[tempNotenArray addObject:[NotenArray objectAtIndex:i]];
                  [tempEpocheArray addObject:tempEpocheDic];
               }
               
            }
            NSLog(@"nummer 5 tempEpocheArray: %@",[tempEpocheArray description]);
            
            // Musik auswaehlen
            int soundindex=0;
            //NSLog(@"setAuswahl i: %d  MusikArray: %@",i,[MusikArray description]);
            for (i=0;i<[MusikArray count];i++)
            {
               //NSLog(@"MusikArray i: %d autor: %d",i,[[[MusikArray objectAtIndex:i]objectForKey:@"autor"]intValue]); 
               if ([[[MusikArray objectAtIndex:i]objectForKey:@"art"]intValue] == 1 
                   && [musikindex containsIndex:[[[MusikArray objectAtIndex:i]objectForKey:@"autor"]intValue]] )
               {
                  
                  //NSLog(@"5 Musik da: name: %@",[[MusikArray objectAtIndex:i]objectForKey:@"name"]);
                  if ([[NummerItem view]viewWithTag:(1000+soundindex)]) // Taste vorhanden
                  {
                     // identifier der Play-Taste zu position des Musikstuecks im Musikarray setzen
                     [[[NummerItem view]viewWithTag:(1000+soundindex)]setIdentifier:
                      [[NSNumber numberWithInt:(1000+i)]stringValue]];
                     
                     // tag der Taste setzen
                     //[[[NummerItem view]viewWithTag:(1000+soundindex)]setTag:1000+i];
                     
                     [musikindex removeIndex:[[[NotenArray objectAtIndex:i]objectForKey:@"autor"]intValue]];
                     soundindex++;
                     
                     
                  } 
                  
               }
            }
            
            // Epoche auswaehlen
            int epochebildindex=0;
            int epocheergebnisindex=-1;
            for (i=0;i<[EpochenArray count];i++)
            {
               if ([[[EpochenArray objectAtIndex:i]objectForKey:@"art"]intValue] == 4 
                   && [epochenindex containsIndex:[[[EpochenArray objectAtIndex:i]objectForKey:@"autor"]intValue]] )
               {
                  NSLog(@"5 Epoche da: name: %@ epoche: %d",[[EpochenArray objectAtIndex:i]objectForKey:@"name"],[[[EpochenArray objectAtIndex:i]objectForKey:@"epoche"]intValue]);
                  [epochenindex removeIndex:[[[EpochenArray objectAtIndex:i]objectForKey:@"autor"]intValue] ];
                  
                  // index fuer richtiges Ergebnis setzen
                  epocheergebnisindex = [[[EpochenArray objectAtIndex:i]objectForKey:@"epoche"]intValue];
                  //[ErgebnisDic setObject:[[EpochenArray objectAtIndex:i]objectForKey:@"epoche"] forKey:@"lsg"];
                  
                  
                  //[ErgebnisDic setObject:[[EpochenArray objectAtIndex:i]objectForKey:@"name"] forKey:@"lsgtext"];
                  
                  //NSImage* bild = [[EpochenArray objectAtIndex:i]objectForKey:@"bild"];
                  [[[NummerItem view]viewWithTag:(6000+epochebildindex)]setImage:
                   [[EpochenArray objectAtIndex:i]objectForKey:@"bild"]];
                  [[[NummerItem view]viewWithTag:(9000+epochebildindex)]setStringValue:[[EpochenArray objectAtIndex:i]objectForKey:@"name"]];
                  
                  epochebildindex++;
                  
               }
               
            }//for
            
            //richtiges Ergebnis setzen
            
            // position der Epoche im tempEpocheArray fuer epocheergebnisindex
            int pos = [[tempEpocheArray valueForKey:@"epoche"]indexOfObject:[NSNumber numberWithInt:epocheergebnisindex]];
            //NSLog(@"nummer 5 position der Epoche im tempEpocheArray: %d",pos);
            
            if (pos) // pos des min ist an zweiter position
            {
               [ErgebnisDic setObject:@"rechts" forKey:@"lsgtext"];
               [ErgebnisDic setObject:[[tempEpocheArray valueForKey:@"epoche"]lastObject] forKey:@"lsg"];
            }
            else // pos des min ist an erster position
            {
               [ErgebnisDic setObject:@"links" forKey:@"lsgtext"];
               [ErgebnisDic setObject:[[tempEpocheArray valueForKey:@"epoche"]objectAtIndex:0] forKey:@"lsg"];
            }
            
            
            
         }break; // 5
            
            
      } // switch nummer
      
      //[[MasterErgebnisArray objectAtIndex:klasse]addObject:ErgebnisDic];
      
      switch (klasse)
      {
         case 0: //Klassewahl
         {
            
         }break;
            
         case 1: // standard
         {
            NSLog(@"standard nummer: %d",nummer);
         }break;
            
         case 2: // master
         {
            int ergebnispos = [[MasterErgebnisArray valueForKey:@"code"]indexOfObject:[ErgebnisDic objectForKey:@"code"]];
            NSLog(@"Master ErgebnisDic: %@ ergebnispos: %d",[ErgebnisDic description],ergebnispos);
            if (ergebnispos >=0)
            {
               [MasterErgebnisArray replaceObjectAtIndex:ergebnispos withObject:ErgebnisDic];
            }
            else 
            {
               [MasterErgebnisArray addObject:ErgebnisDic];
            }
            
            
            
         }break;
            
         case 3: // expert
         {
            NSLog(@"expert nummer: %d",nummer);
         }break;
            
      }// switch klasse
      //NSLog(@"setAuswahl end");
      return erfolg;
   }
   return 0;   
}

- (IBAction)reportNeutaste:(id)sender
{
   //NSLog(@"reportNeutaste");
   if ([[player movie]rate])
   {
      [[player movie]stop];
   }
   NSMutableDictionary* SettingsdatenDic = [[NSMutableDictionary alloc]initWithCapacity:0];

   
   NSArray* klasseviewarray = [[[KlasseTab selectedTabViewItem]view ]subviews];
   //NSLog(@"reportNeutaste klasse tabviewItem: %@ ", [[KlasseTab selectedTabViewItem] label]);
   int klasse = [KlasseTab indexOfTabViewItem:[KlasseTab selectedTabViewItem]];
   //NSLog(@" klassetab views: %@ ", [klasseviewarray description]);
   
   [SettingsdatenDic setObject:[NSNumber numberWithInt:klasse] forKey:@"klasse"];
      int nummer = [NummerTab indexOfTabViewItem:[NummerTab selectedTabViewItem]];
   [SettingsdatenDic setObject:[NSNumber numberWithInt:nummer] forKey:@"nummer"];
   [SettingsdatenDic setObject:MusikArray forKey:@"musikarray"];
   [SettingsdatenDic setObject:NotenArray forKey:@"notenarray"];
   [SettingsdatenDic setObject:FotoArray forKey:@"fotoarray"];
   [SettingsdatenDic setObject:EpochenArray forKey:@"epochenarray"];
   NSMutableDictionary* tempKlassenarray = [NSMutableArray arrayWithArray:[PList objectForKey:@"klassenarray"]];
   [SettingsdatenDic setObject:[PList objectForKey:@"klassenarray"] forKey:@"klassenarray"];
   
   
   NSArray* viewarray = [[[NummerTab selectedTabViewItem]view ]subviews];
   int k=0;
   for (k=0;k<[viewarray count];k++)
   {
      //NSLog(@"k: %d tag: %ld %@",k,[[viewarray objectAtIndex:k]tag],[[viewarray objectAtIndex:k]description]);
   }
   
  // int erfolg = [self setAuswahl];
 //  NSImage* bild = [NSImage imageNamed:@"002.001.001.Joh.Seb.Bach.jpg"];
 //  [Bild0 setImage:bild];
 //  [Bild1 setImage:[NSImage imageNamed:@"002.002.001.W.A.Mozart.jpg"]];
 //  [Bild2 setImage:[NSImage imageNamed:@"002.003.001.N.Paganini.jpg"]];

   //NSLog(@"showSettingsFenster");
	if (!Settings)
	{
		Settings=[[rSettingsWindowController alloc]initWithWindowNibName:@"Settings"];
	}
	[Settings showWindow:self];
   [Settings setDaten:[SettingsdatenDic copy]];
   
   
   //NSLog(@"reportNeutaste end");
}

- (IBAction)reportErgebnisfenster:(id)sender
{
   
   if (!Ergebnis)
	{
      //Settings=[[rSettingsWindowController alloc]initWithWindowNibName:@"Settings"];
		Ergebnis=[[rErgebnisWindowController alloc]initWithWindowNibName:@"Ergebnis"];
	}
	[Ergebnis showWindow:self];
   int klasse = [KlasseTab indexOfTabViewItem:[KlasseTab selectedTabViewItem]];
   NSDictionary* tempDatenDic = [NSDictionary dictionaryWithObjectsAndKeys:MasterErgebnisArray,@"masterergebnisarray", 
                                 [NSNumber numberWithInt:klasse], @"klasse",nil ];
   [Ergebnis setDaten:tempDatenDic];
   
}

- (IBAction)reportStoptaste:(id)sender
{
   NSLog(@"reportStoptaste");
   if ([[player movie]rate])
   {
      [[player movie]stop];
   }
   int i=0;
   for (i=0;i<3;i++)
   {
      if ([[sender superview] viewWithTag:i+1000])
      {
         //NSLog(@"object da: tag: %d",i);
         [[[sender superview] viewWithTag:i+1000]setState:0];
         NSImage* playicon = [NSImage imageNamed:@"playicon.png"];
         [[[sender superview] viewWithTag:i+1000]setImage:playicon];
         //[[[sender superview] viewWithTag:i+1000]setTitle:@">"];
         
      }
   }
}


- (IBAction)reportKlassewahl:(id)sender
{
   //NSLog(@"reportKlassewahl Klasse: %ld",[sender selectedRow]);
   [KlasseTab selectTabViewItemAtIndex:[sender selectedRow]+1];
   //[[[[KlasseTab selectedTabViewItem] view]viewWithTag:3000]selectTabViewItemAtIndex:0];
   [NummerTab selectTabViewItemAtIndex:0];
   [Klassefeld setStringValue:[NSString stringWithFormat:@"Level: %ld",[sender selectedRow]+1]];
   [Nummerfeld setStringValue:[NSString stringWithFormat:@"Nummer: %ld",1]];

//   [self setAuswahl];
}

- (IBAction)reportRadiowahl:(id)sender
{
   NSLog(@"reportRadiowahl wahl: kolonne:%ld zeile:%ld",[sender selectedColumn],[sender selectedRow]);
}


- (IBAction)reportNexttaste:(id)sender
{
   int aktuellenummer = [NummerTab indexOfTabViewItem:[NummerTab selectedTabViewItem]];

   NSLog(@"reportNexttaste index: %ld aktuellenummer: %d",[NummerTab indexOfTabViewItem:[NummerTab selectedTabViewItem]],aktuellenummer);
   if ([[player movie]rate])
   {
      [[player movie]stop];
      
   }
    if([NummerTab indexOfTabViewItem:[NummerTab selectedTabViewItem]]==[NummerTab numberOfTabViewItems]-2)
         {
            [Nexttaste setEnabled:NO];
         }
    else 
    {
       [Nexttaste setEnabled:YES];
    }
   [Prevtaste setEnabled:YES];
   // eventuell Button zuruecksetzen
   NSArray* viewarray = [[[NummerTab selectedTabViewItem]view ]subviews];
  // NSLog(@"reportNexttaste viewarray: %@",[viewarray description]);
   int k=0;
   NSRange tabrange = NSMakeRange(1000, 10);
   NSIndexSet* tabindex = [NSIndexSet indexSetWithIndexesInRange:tabrange];
   for (k=0;k<[viewarray count];k++)
   {
      //NSLog(@"k: %d tag: %ld",k,[[viewarray objectAtIndex:k]tag]);
      if ([tabindex containsIndex:[[viewarray objectAtIndex:k]tag]] )
      {
         int temptag=[[viewarray objectAtIndex:k]tag];
         [[[[NummerTab selectedTabViewItem]view]viewWithTag:temptag]setState:0];
         
         NSImage* playicon = [NSImage imageNamed:@"playicon.png"];
         [[[[NummerTab selectedTabViewItem]view ]viewWithTag:temptag]setImage:playicon];
      
      }
      [[[NummerTab selectedTabViewItem]view ]setNeedsDisplay:YES];
   }
   
   [NummerTab selectNextTabViewItem:NULL];
   [Nummerfeld setStringValue:[NSString stringWithFormat:@"Nummer: %ld",aktuellenummer+1]];
   
//   [self setAuswahl];
}

- (IBAction)reportPrevtaste:(id)sender
{   
   if ([[player movie]rate])
   {
      [[player movie]stop];
   }
   if([NummerTab indexOfTabViewItem:[NummerTab selectedTabViewItem]]==1)
   {
      [Prevtaste setEnabled:NO];
   }
   else 
   {
      [Prevtaste setEnabled:YES];
   }
   [Nexttaste setEnabled:YES];

   // eventuell Button zuruecksetzen
   NSArray* viewarray = [[[NummerTab selectedTabViewItem]view ]subviews];
   // NSLog(@"reportNexttaste viewarray: %@",[viewarray description]);
   int k=0;
   NSRange tabrange = NSMakeRange(1000, 10);
   NSIndexSet* tabindex = [NSIndexSet indexSetWithIndexesInRange:tabrange];
   for (k=0;k<[viewarray count];k++)
   {
      //NSLog(@"k: %d tag: %ld",k,[[viewarray objectAtIndex:k]tag]);
      if ([tabindex containsIndex:[[viewarray objectAtIndex:k]tag]] )
      {
         int temptag=[[viewarray objectAtIndex:k]tag];
         [[[[NummerTab selectedTabViewItem]view]viewWithTag:temptag]setState:0];
         
         NSImage* playicon = [NSImage imageNamed:@"playicon.png"];
         [[[[NummerTab selectedTabViewItem]view ]viewWithTag:temptag]setImage:playicon];
         
      }
      [[[NummerTab selectedTabViewItem]view ]setNeedsDisplay:YES];
   }

   
   [NummerTab selectPreviousTabViewItem:NULL];
   [Nummerfeld setStringValue:[NSString stringWithFormat:@"Nummer: %ld",[NummerTab indexOfTabViewItem:[NummerTab selectedTabViewItem]]+1]];

//   [self setAuswahl];
}

- (IBAction)reportFirsttaste:(id)sender
{
   if ([[player movie]rate])
   {
      [[player movie]stop];
   }
   
   // eventuell Button zuruecksetzen
   NSArray* viewarray = [[[NummerTab selectedTabViewItem]view ]subviews];
   // NSLog(@"reportNexttaste viewarray: %@",[viewarray description]);
   int k=0;
   NSRange tabrange = NSMakeRange(1000, 10);
   NSIndexSet* tabindex = [NSIndexSet indexSetWithIndexesInRange:tabrange];
   for (k=0;k<[viewarray count];k++)
   {
      //NSLog(@"k: %d tag: %ld",k,[[viewarray objectAtIndex:k]tag]);
      if ([tabindex containsIndex:[[viewarray objectAtIndex:k]tag]] )
      {
         int temptag=[[viewarray objectAtIndex:k]tag];
         [[[[NummerTab selectedTabViewItem]view]viewWithTag:temptag]setState:0];
         
         NSImage* playicon = [NSImage imageNamed:@"playicon.png"];
         [[[[NummerTab selectedTabViewItem]view ]viewWithTag:temptag]setImage:playicon];
         
      }
      [[[NummerTab selectedTabViewItem]view ]setNeedsDisplay:YES];
   }

      [NummerTab selectTabViewItemAtIndex:0];

}

- (IBAction)reportHometaste:(id)sender
{
   if ([[player movie]rate])
   {
      [[player movie]stop];
   }
   
   // eventuell Button zuruecksetzen
   NSArray* viewarray = [[[NummerTab selectedTabViewItem]view ]subviews];
   // NSLog(@"reportNexttaste viewarray: %@",[viewarray description]);
   int k=0;
   NSRange tabrange = NSMakeRange(1000, 10);
   NSIndexSet* tabindex = [NSIndexSet indexSetWithIndexesInRange:tabrange];
   for (k=0;k<[viewarray count];k++)
   {
      //NSLog(@"k: %d tag: %ld",k,[[viewarray objectAtIndex:k]tag]);
      if ([tabindex containsIndex:[[viewarray objectAtIndex:k]tag]] )
      {
         int temptag=[[viewarray objectAtIndex:k]tag];
         [[[[NummerTab selectedTabViewItem]view]viewWithTag:temptag]setState:0];
         
         NSImage* playicon = [NSImage imageNamed:@"playicon.png"];
         [[[[NummerTab selectedTabViewItem]view ]viewWithTag:temptag]setImage:playicon];
         
      }
      [[[NummerTab selectedTabViewItem]view ]setNeedsDisplay:YES];
   }


   [KlasseTab selectTabViewItemAtIndex:0];
   [NummerTab selectTabViewItemAtIndex:0];

}
- (IBAction)reportRadiotaste:(id)sender;
{
   int nummer = [NummerTab indexOfTabViewItem:[NummerTab selectedTabViewItem]];
   int klasse = [KlasseTab indexOfTabViewItem:[KlasseTab selectedTabViewItem]];
   switch (klasse)
   {
      case 1:
      {
         
      }break;
         
      case 2:
      {
         int zeile =[sender selectedRow];
         int kolonne = [sender selectedColumn];
         int ergebniscode = [sender ergebniscodeInZeile:zeile inKolonne:kolonne];
         int benutzerwahl = [[[MasterErgebnisArray objectAtIndex:nummer]objectForKey:@"wahl"]intValue];
         NSLog(@"reportRadiotaste nummer: %d kolonne: %d ergebniscode: %d benutzerwahl: %d",nummer,kolonne,ergebniscode,benutzerwahl);
         //NSLog(@"MasterErgebnisArray  %@", [MasterErgebnisArray description]);
         //   if ([MasterErgebnisArray objectAtIndex:kolonne])
         
         NSLog(@"reportRadiotaste MasterErgebnisArray zeile: %d kolonne: %d ErgebnisDic: %@",zeile, kolonne, [[MasterErgebnisArray objectAtIndex:nummer]description]);
         //position des Dic fuer tabview nummer im  MasterErgebnisArray an Index klasse
         int nummerpos = [[MasterErgebnisArray valueForKey:@"nummer"]indexOfObject:[NSNumber numberWithInt:nummer]];
         NSLog(@"MasterErgebnisArray nummerpos: %d",nummerpos);
         
         
         int lsg = [[[MasterErgebnisArray objectAtIndex:nummerpos]objectForKey:@"lsg"]intValue];
 
         //[KontrollFeldA setIntValue:ergebniscode];
         //[KontrollFeldB setIntValue:lsg];
         
         if (lsg == ergebniscode)
         {
            NSLog(@"ergebniscode: %d ist richtig",ergebniscode);
            [[MasterErgebnisArray objectAtIndex:nummerpos]setObject:[NSNumber numberWithInt:1] forKey:@"richtig"];
         
         }
         else 
         {
            {
               NSLog(@"ergebniscode: %d ist falsch",ergebniscode);
            }
         }
         
         // Wahl des Benutzers. Code der Lösung
         [[MasterErgebnisArray objectAtIndex:nummerpos]setObject:[NSNumber numberWithInt:ergebniscode] forKey:@"wahl"];
         // Wahl des Benutzers. Position der geklickten Taste
         [[MasterErgebnisArray objectAtIndex:nummerpos]setObject:[NSNumber numberWithInt:kolonne] forKey:@"wahlpos"];
         [[MasterErgebnisArray objectAtIndex:nummerpos]setObject:[NSNumber numberWithInt:(lsg == ergebniscode)] forKey:@"richtig"];
         
         
         NSLog(@"MasterErgebnisArray pos: %d  nach Taste: %@",nummerpos,[[MasterErgebnisArray objectAtIndex:nummerpos] description]);
         [MasterErgebnistabelle reloadData];
         
      }break;
 
   }
}


- (int)readPList
{
   // we need to get the plist data...
   NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"plist"];
   //NSLog(@"plistPath: %@",plistPath);
   NSFileManager* nc = [NSFileManager defaultManager];
//   NSMutableArray *dataArray = [[NSMutableArray alloc] initWithCapacity:0]; 
   if ([nc fileExistsAtPath:plistPath])
   {
      NSMutableDictionary* plist = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
      if ([plist count])
      {
         NSLog(@"PList schon vorhanden: %@",[plist description]);
         [PList setDictionary: [NSMutableDictionary dictionaryWithContentsOfFile:plistPath]];
         return 1;
      }
      else
      {
         NSLog(@"plist leer");
         return 0;
      }
   }
   NSLog(@"keine PList");
   return 0;
}

- (void)writePList:(NSDictionary*)plist
{
   // we need to get the plist data...
   NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"plist"];
   //NSLog(@"plistPath: %@",plistPath);
   NSFileManager* nc = [NSFileManager defaultManager];
//   NSMutableArray *dataArray = [[NSMutableArray alloc] initWithCapacity:0]; 
   if ([nc fileExistsAtPath:plistPath])
   {
     // [PList setDictionary: [NSMutableDictionary dictionaryWithContentsOfFile:plistPath]];
      
   }
   else 
   {
      
   }
   /*
   // add a new entry
   NSDictionary *addQuestion = [[NSDictionary alloc] initWithObjectsAndKeys:@"Blank.png",@"Icon",
                                [Klassefeld stringValue],@"klasse",
                                [Nummerfeld stringValue],@"nummer",
                                @"1",@"Custom",
                                [NSArray arrayWithObjects:@"Yes",@"No",nil],@"Values",
                                nil];
   NSLog(@"addQuestion: %@",[addQuestion description]);
   [dataArray addObject:addQuestion];
   NSLog(@"dataArray: %@",[dataArray description]);
   */
   // rewrite the plist
   int erfolg = [PList writeToFile:plistPath atomically:YES];
   NSLog(@"erfolg: %d",erfolg);
}

//@"SettingDaten"
- (void)SettingDatenAktion:(NSNotification*)note
{
	//NSLog(@"SettingDatenAktion: note: %@",[[note userInfo]description]);
   int klasse = [[[note userInfo]objectForKey:@"klasse"]intValue];
   int nummer = [[[note userInfo]objectForKey:@"nummer"]intValue];
  
   [[PList objectForKey:@"klassenarray"] replaceObjectAtIndex:klasse withObject:[[note userInfo]objectForKey:@"indexarray"]];
   [self setAuswahl];
   
   
  // IndexArray = [(NSMutableArray*)[[DatenDic objectForKey:@"plist"]objectForKey:@"klassenarray"]objectAtIndex:self.klasseWert];

}

- (int)maxVonArray:(NSArray*)intarray
{
   NSInteger highestNumber=-1;
   NSInteger numberIndex;
   for (NSNumber *theNumber in intarray)
   {
      //NSLog(@"[theNumber integerValue]: %ld ",[theNumber integerValue]);
      if ([theNumber integerValue] > highestNumber) 
      {
         highestNumber = [theNumber integerValue];
         numberIndex = [intarray indexOfObject:theNumber];
      }
   }
   long x = arc4random();
   //NSLog(@"Highest number: %ld at index: %ld x: %ld", highestNumber, numberIndex,x);
   return highestNumber;
}

- (int)minVonArray:(NSArray*)intarray
{
   NSInteger lowestNumber= INT_MAX;
   NSInteger numberIndex;
   for (NSNumber *theNumber in intarray)
   {
      //NSLog(@"[theNumber integerValue]: %ld ",[theNumber integerValue]);
      if ([theNumber integerValue] < lowestNumber) 
      {
         lowestNumber = [theNumber integerValue];
         numberIndex = [intarray indexOfObject:theNumber];
      }
   }
   
   //NSLog(@"Highest number: %ld at index: %ld x: %ld", highestNumber, numberIndex,x);
   return lowestNumber;
}



- (IBAction)terminate:(id)sender
{
   
   [NSApp terminate:self]; 
}

#pragma mark TabView
- (void)tabView:(NSTabView *)tabView willSelectTabViewItem:(NSTabViewItem*)tabViewItem
{
	//	NSLog(@"TestTabFeld aktuelles TabViewItem: %@",[[TestTabFeld selectedTabViewItem] label]);
		NSLog(@"TestTabFeld willSelectTabViewItem: %@",[tabViewItem label]);
	
	//		Bisheriges Item abschliessen
   //NSLog(@"willSelectTabViewItem: %ld",[tabView indexOfTabViewItem:tabViewItem ]);
   
   //int aktuellercode = [KlasseTab indexOfTabViewItem:[KlasseTab selectedTabViewItem]]*100 + [tabView indexOfTabViewItem:tabViewItem ];
   //int nextcode = ([KlasseTab indexOfTabViewItem:[KlasseTab selectedTabViewItem]])*100 + [tabView indexOfTabViewItem:tabViewItem];
   //NSLog(@"willSelectTabViewItem nextcode: %d",nextcode);

   
	switch ([tabView indexOfTabViewItem:tabViewItem ])
	{
		case 0://Testliste
		{
         
      }break;
         
   }
}

- (void)tabView:(NSTabView *)tabView didSelectTabViewItem:(NSTabViewItem *)tabViewItem
{
   //NSLog(@"didSelectTabViewItem: %ld",[tabView indexOfTabViewItem:tabViewItem ]);
   int aktuellenummer = [tabView indexOfTabViewItem:tabViewItem ];
   int aktuellercode = ([KlasseTab indexOfTabViewItem:[KlasseTab selectedTabViewItem]])*100 + aktuellenummer;

   long ergebnispos = [[MasterErgebnisArray valueForKey:@"code"]indexOfObject:[NSNumber numberWithInt: aktuellercode]];
   NSLog(@"didSelectTabViewItem item: %ld: ergebnispos: %ld",[tabView indexOfTabViewItem:tabViewItem] ,ergebnispos);
   if (ergebnispos < NSNotFound)
   {
      NSLog(@"didSelectTabViewItem: ErgebnisDic: %@",[MasterErgebnisArray objectAtIndex:ergebnispos]);
      
      int wahl = -1;
      if ([[MasterErgebnisArray objectAtIndex:ergebnispos]objectForKey:@"wahl"])
      {
         wahl = [[[MasterErgebnisArray objectAtIndex:ergebnispos]objectForKey:@"wahl"]intValue];
      }
      //[self setAuswahl];
      //return;
      if (wahl >= 0)
      {
         int wahlpos = [[[MasterErgebnisArray objectAtIndex:ergebnispos]objectForKey:@"wahlpos"]intValue];
         NSLog(@"didSelectTabViewItem: wahl: %d wahlpos: %d",wahl, wahlpos);
  
         [self setAuswahlMitVorgabe:wahlpos];
      }
      else 
      {
         [self setAuswahlMitVorgabe:2];
      }
   }
   else 
   {
      NSLog(@"kein ErgebnisDic");
      [self setAuswahl]; // weiss nicht
   }
       
}

#pragma mark TableView

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView
{
   if ([[aTableView identifier]isEqual:@"standard"])
   {
         return [StandardErgebnisArray count];
   }
   else if ([[aTableView identifier]isEqual:@"master"])
   {
      return [MasterErgebnisArray count];
   }
   else if ([[aTableView identifier]isEqual:@"expert"])
   {
      return [ExpertErgebnisArray count];
   }


}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
   //NSLog(@"objectValueForTableColumn rowIndex: %d",rowIndex);
   
   //int klasse = [KlasseTab  indexOfTabViewItem:[KlasseTab selectedTabViewItem]];
   
   //NSLog(@"objectValueForTableColumn rowIndex: %d klasse: %d",rowIndex,klasse);
   
   if ([[aTableView identifier]isEqual:@"standard"])
   {
      if (rowIndex < [StandardErgebnisArray count] )
      {
         return [[StandardErgebnisArray objectAtIndex:rowIndex]objectForKey:[aTableColumn identifier]];
      }
      
   }
   else if ([[aTableView identifier]isEqual:@"master"])
   {
      if (rowIndex < [MasterErgebnisArray count] )
      {
         return [[MasterErgebnisArray objectAtIndex:rowIndex]objectForKey:[aTableColumn identifier]];
      }
      
   }
   else if ([[aTableView identifier]isEqual:@"expert"])
   {
      if (rowIndex < [ExpertErgebnisArray count] )
      {
         return [[ExpertErgebnisArray objectAtIndex:rowIndex]objectForKey:[aTableColumn identifier]];
      }
      
   }

   
   
   
return NULL;

}

- (void)tableView:(NSTableView *)aTableView 
   setObjectValue:(id)anObject 
   forTableColumn:(NSTableColumn *)aTableColumn 
              row:(long)rowIndex
{
   NSLog(@"setObjectValueForTableColumn anObject: %d",[anObject intValue]);
   
   NSMutableDictionary* einDic;
   if (rowIndex<[MasterErgebnisArray count])
	{
		einDic=[MasterErgebnisArray objectAtIndex:rowIndex];
      int status = [anObject intValue];
      NSString* ident = [aTableColumn identifier];
		[einDic setObject:anObject forKey:ident];
     
      }
     // [[AuswahlArray lastObject] setObject:[NSNumber numberWithInt:status] forKey:ident];
      
      [aTableView reloadData];
	
    
}



// Returns the directory the application uses to store the Core Data store file. This code uses a directory named "RH.Quiz" in the user's Application Support directory.
- (NSURL *)applicationFilesDirectory
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *appSupportURL = [[fileManager URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask] lastObject];
    return [appSupportURL URLByAppendingPathComponent:@"RH.Quiz"];
}

// Creates if necessary and returns the managed object model for the application.
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel) {
        return __managedObjectModel;
    }
	
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Quiz" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return __managedObjectModel;
}

// Returns the persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. (The directory for the store is created, if necessary.)
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator) {
        return __persistentStoreCoordinator;
    }
    
    NSManagedObjectModel *mom = [self managedObjectModel];
    if (!mom) {
        NSLog(@"%@:%@ No model to generate a store from", [self class], NSStringFromSelector(_cmd));
        return nil;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *applicationFilesDirectory = [self applicationFilesDirectory];
    NSError *error = nil;
    
    NSDictionary *properties = [applicationFilesDirectory resourceValuesForKeys:[NSArray arrayWithObject:NSURLIsDirectoryKey] error:&error];
    
    if (!properties) {
        BOOL ok = NO;
        if ([error code] == NSFileReadNoSuchFileError) {
            ok = [fileManager createDirectoryAtPath:[applicationFilesDirectory path] withIntermediateDirectories:YES attributes:nil error:&error];
        }
        if (!ok) {
            [[NSApplication sharedApplication] presentError:error];
            return nil;
        }
    } else {
        if (![[properties objectForKey:NSURLIsDirectoryKey] boolValue]) {
            // Customize and localize this error.
            NSString *failureDescription = [NSString stringWithFormat:@"Expected a folder to store application data, found a file (%@).", [applicationFilesDirectory path]];
            
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [dict setValue:failureDescription forKey:NSLocalizedDescriptionKey];
            error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:101 userInfo:dict];
            
            [[NSApplication sharedApplication] presentError:error];
            return nil;
        }
    }
    
    NSURL *url = [applicationFilesDirectory URLByAppendingPathComponent:@"Quiz.storedata"];
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
    if (![coordinator addPersistentStoreWithType:NSXMLStoreType configuration:nil URL:url options:nil error:&error]) {
        [[NSApplication sharedApplication] presentError:error];
        return nil;
    }
    __persistentStoreCoordinator = coordinator;
    
    return __persistentStoreCoordinator;
}

// Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) 
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext) {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:@"Failed to initialize the store" forKey:NSLocalizedDescriptionKey];
        [dict setValue:@"There was an error building up the data file." forKey:NSLocalizedFailureReasonErrorKey];
        NSError *error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        [[NSApplication sharedApplication] presentError:error];
        return nil;
    }
    __managedObjectContext = [[NSManagedObjectContext alloc] init];
    [__managedObjectContext setPersistentStoreCoordinator:coordinator];

    return __managedObjectContext;
}

// Returns the NSUndoManager for the application. In this case, the manager returned is that of the managed object context for the application.
- (NSUndoManager *)windowWillReturnUndoManager:(NSWindow *)window
{
    return [[self managedObjectContext] undoManager];
}

// Performs the save action for the application, which is to send the save: message to the application's managed object context. Any encountered errors are presented to the user.
- (IBAction)saveAction:(id)sender
{
    NSError *error = nil;
    
    if (![[self managedObjectContext] commitEditing]) {
        NSLog(@"%@:%@ unable to commit editing before saving", [self class], NSStringFromSelector(_cmd));
    }
    
    if (![[self managedObjectContext] save:&error]) {
        [[NSApplication sharedApplication] presentError:error];
    }
}

- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender
{
    // Save changes in the application's managed object context before the application terminates.
    
    if (!__managedObjectContext) {
        return NSTerminateNow;
    }
    
    if (![[self managedObjectContext] commitEditing]) {
        NSLog(@"%@:%@ unable to commit editing to terminate", [self class], NSStringFromSelector(_cmd));
        return NSTerminateCancel;
    }
    
    if (![[self managedObjectContext] hasChanges]) {
        return NSTerminateNow;
    }
    
    NSError *error = nil;
    if (![[self managedObjectContext] save:&error]) {

        // Customize this code block to include application-specific recovery steps.              
        BOOL result = [sender presentError:error];
        if (result) {
            return NSTerminateCancel;
        }

        NSString *question = NSLocalizedString(@"Could not save changes while quitting. Quit anyway?", @"Quit without saves error question message");
        NSString *info = NSLocalizedString(@"Quitting now will lose any changes you have made since the last successful save", @"Quit without saves error question info");
        NSString *quitButton = NSLocalizedString(@"Quit anyway", @"Quit anyway button title");
        NSString *cancelButton = NSLocalizedString(@"Cancel", @"Cancel button title");
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:question];
        [alert setInformativeText:info];
        [alert addButtonWithTitle:quitButton];
        [alert addButtonWithTitle:cancelButton];

        NSInteger answer = [alert runModal];
        
        if (answer == NSAlertAlternateReturn) {
            return NSTerminateCancel;
        }
    }

    return NSTerminateNow;
}

@end
