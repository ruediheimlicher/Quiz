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
   //NSLog(@"rTabview setTag: %ld",tag);
   [self setTag:tag];
}

- (NSInteger)tag
{
   //NSLog(@"rTabview tag: %ld",[self tag]);
   return -1;
}

@end


@implementation AppDelegate

@synthesize window = _window;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize managedObjectContext = __managedObjectContext;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
   Fragefeldrect = NSMakeRect(20, 344, 816, 70);
   Auswahlradiorect = NSMakeRect(110, 275, 716, 57);
   
   grossesBildrect = NSMakeRect(840, 77, 310, 330);
   Bild0rect = NSMakeRect(17, 10, 240, 240);
   Bild1rect = NSMakeRect(272, 10, 240, 240);
   Bild2rect = NSMakeRect(840, 77, 307, 328);
   Taste0rect = NSMakeRect(107, 23, 60, 60);
   Taste1rect = NSMakeRect(362, 23, 60, 60);
   Taste2rect = NSMakeRect(963, 110, 80, 80);
   Legenderect = NSMakeRect(840, 0, 307, 70);

   
   
   
      // Insert code here to initialize your application
   float schriftrot = 82;
   float schriftgruen = 95;
   float schriftblau = 224;
   
   Schriftfarbe = [NSColor colorWithCalibratedRed:schriftrot green:schriftgruen blue:schriftblau alpha:0.5];
   
   Schriftfarbe = [NSColor whiteColor];
   
   titelschriftgroesse = 28;
   legendeschriftgroesse = 28;
   radioschriftgroesse = 20;
   
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
   [[NSColor colorWithCalibratedWhite:0.65 alpha:0.5] set];
   NSRectFillUsingOperation(backgroundRect,NSCompositeSourceOver);
   
   [backgroundImage unlockFocus];
   
   // Set our background image as the window's background color.
   [[self window] setBackgroundColor:
    [NSColor colorWithPatternImage:backgroundImage]];
   
   // Release the image.
   //[backgroundImage release];
   
   
   
   for(int i=1;i<[KlasseTab numberOfTabViewItems];i++)
   {
      
      NSArray* viewarray = [[[KlasseTab tabViewItemAtIndex:i] view]subviews];
      //NSLog(@"KlasseTab index: %d viewarray vor: %@",i,[viewarray description]);
      int nummertabindex = -1;
      for (int k=0;k<[viewarray count];k++)
      {
         //NSLog(@"k: %d  ident: %@",k,[[viewarray objectAtIndex:k]identifier]);
         if ([[[viewarray  objectAtIndex:k]identifier]intValue] == 100*i)
         {
            //NSLog(@"\n\nk: %d  View mit ident da: %@",k,[[viewarray  objectAtIndex:k]description]);
            nummertabindex = k;
         }
      }
      if (nummertabindex >=0) // Nummertab vorhanden
      {
         
         //NSLog(@"KlasseTab  %d nummertabindex: %d ident: %@ NummerTab: %@",i,nummertabindex,[[viewarray  objectAtIndex:nummertabindex]identifier],[[viewarray  objectAtIndex:nummertabindex]description]);
         
         // Nummertab der Klasse
         rTabView* tempNummertab = [viewarray  objectAtIndex:nummertabindex];
         //NSLog(@"tempNummertab anz: %ld",[tempNummertab numberOfTabViewItems ]);
         
         for(int t=0;t<[tempNummertab numberOfTabViewItems ];t++)
         {
            
            NSRect r = [[[tempNummertab tabViewItemAtIndex:t]view]frame];
            //NSLog(@"tab %d View x: %2.2f y: %2.2f w: %2.2f h: %2.2f",t,r.origin.x, r.origin.y,r.size.width,r.size.height);
            
            
            NSArray* tempviewarray = [[[tempNummertab tabViewItemAtIndex:t]view] subviews];
            //NSLog(@"KlasseTab tempviewarray: %@",[tempviewarray description]);
            //for (int n=0;n<[tempviewarray count];n++)
            {
               //NSLog(@"View tag: %ld",[[tempviewarray objectAtIndex:n]tag]);
            }
            if ([[[tempNummertab tabViewItemAtIndex:t]view]viewWithTag:2000])
            {
               //NSLog(@"item: %ld Fragefeld da",t);
               //NSRect r = [[[[tempNummertab tabViewItemAtIndex:t]view]viewWithTag:2000]frame];
               //NSLog(@"vor x: %2.2f y: %2.2f w: %2.2f h: %2.2f",r.origin.x, r.origin.y,r.size.width,r.size.height);
               [[[[tempNummertab tabViewItemAtIndex:t]view]viewWithTag:2000]setFrame:Fragefeldrect];
               //r = [[[[tempNummertab tabViewItemAtIndex:t]view]viewWithTag:2000]frame];
               //NSLog(@"nach x: %2.2f y: %2.2f w: %2.2f h: %2.2f",r.origin.x, r.origin.y,r.size.width,r.size.height);
               
            }
            
            if ([[[tempNummertab tabViewItemAtIndex:t]view]viewWithTag:8000])
            {
               [[[[tempNummertab tabViewItemAtIndex:t]view]viewWithTag:8000]setFrame:Auswahlradiorect];
            }
            
            // Bildlegende
            if ([[[tempNummertab tabViewItemAtIndex:t]view]viewWithTag:9000])
            {
               [[[[tempNummertab tabViewItemAtIndex:t]view]viewWithTag:9000]setFrame:Legenderect];
            }
            
            
            switch(t)
            {
               case 0:
               {
                  [[[[tempNummertab tabViewItemAtIndex:t]view]viewWithTag:1000]setFrame:Taste0rect];
                  [[[[tempNummertab tabViewItemAtIndex:t]view]viewWithTag:1001]setFrame:Taste1rect];
                  [[[[tempNummertab tabViewItemAtIndex:t]view]viewWithTag:5000]setFrame:Bild0rect];
                  [[[[tempNummertab tabViewItemAtIndex:t]view]viewWithTag:5001]setFrame:Bild1rect];
                  [[[[tempNummertab tabViewItemAtIndex:t]view]viewWithTag:6000]setFrame:Bild2rect];
                  
                  
               }break;
                  
               case  1:
               {
                  [[[[tempNummertab tabViewItemAtIndex:t]view]viewWithTag:1000]setFrame:Taste2rect];
                  //[[[[tempNummertab tabViewItemAtIndex:t]view]viewWithTag:1001]setFrame:Taste1rect];
                  [[[[tempNummertab tabViewItemAtIndex:t]view]viewWithTag:6000]setFrame:Bild0rect];
                  [[[[tempNummertab tabViewItemAtIndex:t]view]viewWithTag:6001]setFrame:Bild1rect];
                  [[[[tempNummertab tabViewItemAtIndex:t]view]viewWithTag:5000]setFrame:Bild2rect];
                  
               }break;
                  
               case  2:
               {
                  [[[[tempNummertab tabViewItemAtIndex:t]view]viewWithTag:1000]setFrame:Taste0rect];
                  [[[[tempNummertab tabViewItemAtIndex:t]view]viewWithTag:1001]setFrame:Taste1rect];
                  [[[[tempNummertab tabViewItemAtIndex:t]view]viewWithTag:5000]setFrame:Bild0rect];
                  [[[[tempNummertab tabViewItemAtIndex:t]view]viewWithTag:5001]setFrame:Bild1rect];
                  [[[[tempNummertab tabViewItemAtIndex:t]view]viewWithTag:7000]setFrame:Bild2rect];
                  
               }break;
                  
               case  3:
               {
                  [[[[tempNummertab tabViewItemAtIndex:t]view]viewWithTag:1000]setFrame:Taste0rect];
                  [[[[tempNummertab tabViewItemAtIndex:t]view]viewWithTag:1001]setFrame:Taste1rect];
                  [[[[tempNummertab tabViewItemAtIndex:t]view]viewWithTag:6000]setFrame:Bild0rect];
                  [[[[tempNummertab tabViewItemAtIndex:t]view]viewWithTag:6001]setFrame:Bild1rect];
                  [[[[tempNummertab tabViewItemAtIndex:t]view]viewWithTag:7000]setFrame:Bild2rect];
                  
               }break;
                  
               case  4:
               {
                  [[[[tempNummertab tabViewItemAtIndex:t]view]viewWithTag:1000]setFrame:Taste2rect];
                  //[[[[tempNummertab tabViewItemAtIndex:t]view]viewWithTag:1001]setFrame:Taste1rect];
                  [[[[tempNummertab tabViewItemAtIndex:t]view]viewWithTag:6000]setFrame:Bild0rect];
                  [[[[tempNummertab tabViewItemAtIndex:t]view]viewWithTag:6001]setFrame:Bild1rect];
                  [[[[tempNummertab tabViewItemAtIndex:t]view]viewWithTag:5000]setFrame:Bild2rect];
                  
               }break;
                  
               case  5:
               {
                  [[[[tempNummertab tabViewItemAtIndex:t]view]viewWithTag:1000]setFrame:Taste0rect];
                  [[[[tempNummertab tabViewItemAtIndex:t]view]viewWithTag:1001]setFrame:Taste1rect];
                  [[[[tempNummertab tabViewItemAtIndex:t]view]viewWithTag:5000]setFrame:Bild0rect];
                  [[[[tempNummertab tabViewItemAtIndex:t]view]viewWithTag:5001]setFrame:Bild1rect];
                  [[[[tempNummertab tabViewItemAtIndex:t]view]viewWithTag:6000]setFrame:Bild2rect];
                  
               }break;
                  
                  
            }// switch
            
            
            
            
            [[[tempNummertab tabViewItemAtIndex:t]view]setNeedsDisplay:YES];
         }
         
         //
         
         
      }
      
   }
   
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
   DefaultArray = [[NSMutableArray alloc]initWithCapacity:0];
   
   [Klassewahl setKolonnen:1];
   [Klassewahl setZeilen:2];
   [Klassewahl setTitel:@"Standard" inZeile:0 inKolonne:0];
   [Klassewahl setTitel:@"Master" inZeile:1 inKolonne:0];
//   [Klassewahl setTitel:@"Expert" inZeile:2 inKolonne:0];
   [Klassewahl setStatus:1 inZeile:1 inKolonne:0];
   [Klassewahl setNeedsDisplay:YES];

  // [KlasseTastenwahl setKolonnen:1];
   [KlasseTastenwahl setZeilen:2];
   [KlasseTastenwahl setTitel:@"Standard" inZeile:0 inKolonne:0];
   [KlasseTastenwahl setTitel:@"Master" inZeile:1 inKolonne:0];
 //  [KlasseTastenwahl setTitel:@"Expert" inZeile:2 inKolonne:0];
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
   [Nexttaste setEnabled:NO];

   //NSLog(@"bundlePath: %@",[[NSBundle mainBundle]bundlePath]);
   NSString* ResourcenPfad=[[[NSBundle mainBundle]bundlePath]stringByAppendingPathComponent:@"Contents/Resources"];
   NSFileManager *Filemanager=[NSFileManager defaultManager];
   NSString* FilePfad=[[[NSBundle mainBundle]bundlePath]stringByAppendingPathComponent:@"Contents"];
   
   NSArray* tempInhaltArray=[Filemanager contentsOfDirectoryAtPath:FilePfad error:NULL];
   ;
   //NSLog(@"\n  files roh: \n%@",[tempInhaltArray description]);
   
   
   NSArray* tempFileArray=[Filemanager contentsOfDirectoryAtPath:ResourcenPfad error:NULL];
   ;
   //NSLog(@"\n  tempFileArray roh: \n%@",[tempFileArray description]);
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
         //tempName = [[tempPfadArray subarrayWithRange:NSMakeRange(0, [tempPfadArray count]-2)]componentsJoinedByString:@"."];;
         //NSLog(@"tempName B: %@",tempName);
         //NSLog(@"tempPfad: %@",tempPfad);

      }
      
      // Fragen lesen
      if ([tempPfad hasSuffix:@"txt"])
      {
         
         if ([tempPfad isEqualTo:@"fragen.txt"])
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
               //NSLog(@"k: %d  tempZeilenArray : \n%@ count: %lu",k,[tempZeilenArray description], [tempZeilenArray count]);
               if ([tempZeilenArray count] == 3) // Fragezeile komplett
               {
                  NSNumber* klassenumber = [NSNumber numberWithInt:[[tempZeilenArray objectAtIndex:0]intValue]];
                  NSNumber* nummernumber = [NSNumber numberWithInt:[[tempZeilenArray objectAtIndex:1]intValue]];
                  
                  NSDictionary* tempFragenDic = [NSDictionary dictionaryWithObjectsAndKeys:klassenumber,@"klasse",nummernumber,@"nummer",[tempZeilenArray objectAtIndex:2],@"frage", nil];
                  [FragenArray addObject:tempFragenDic];
                  //[Frage setStringValue:[tempZeilenArray objectAtIndex:2]];
               }
               
            }
         } // fragen
         
         
           
      
      
      
   }// if .txt

      /* in readData
      if ([tempPfad isEqualTo:@"quizsettings"])
      {
         //NSLog(@"quizsettings da: tempPfad: %@",tempPfad);
         
         NSData *data = [[NSMutableData alloc]initWithContentsOfFile:[ResourcenPfad stringByAppendingPathComponent:tempPfad]];
         NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
         
         NSMutableDictionary* settingsdataDic=[[NSMutableDictionary alloc]initWithCapacity:0];
         settingsdataDic = [unarchiver decodeObjectForKey: @"plist"];
         [unarchiver finishDecoding];
         NSLog(@"finishlaunch settingsdataDic: %@",[settingsdataDic description]);
         
      } // settings
     */
      
      switch ([[tempPfadArray objectAtIndex:0]intValue]) // Art
      {
         case 1: // sound
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
   
   
   
   
   
//   [AuswahlArray addObject:tempAuswahlDic];
//   NSLog(@"MusikArray: %@",[MusikArray description]);
   //NSLog(@"FotoArray: %@",[FotoArray description]);
//   NSLog(@"NotenArray: %@",[NotenArray description]);
//   NSLog(@"EpochenArray: %@",[EpochenArray description]);
   
   //NSLog(@"AuswahlArray: %@",[AuswahlArray description]);
   //NSLog(@"MusiktitelArray: %@",[MusiktitelArray description]);
   
   //  [Auswahltabelle setDelegate:self];
   //  [Auswahltabelle setDataSource:self];
   //  [Auswahltabelle setBackgroundColor:[NSColor clearColor]];
   [KlasseTab selectTabViewItemAtIndex:0];
   
   [Klassefeld setStringValue:@""];
   [Nummerfeld setStringValue:@""];
   //NSLog(@"frame b: %2.2f h: %2.2f",f.size.width,f.size.height);
   // AuswahlRadio = [[rRadioMatrix alloc]initWithFrame:f mitKolonnen:3 mitZeilen:1];
   //   [AuswahlRadio setKolonnen:3];
   //   [AuswahlRadio setTitel:@"weiss nicht" inZeile:0 inKolonne:2];
   //   [AuswahlRadio setStatus:1 inZeile:0 inKolonne:2];
   //  [AuswahlRadio setNeedsDisplay:YES];
   [KlasseTab selectTabViewItemAtIndex:0];
   
   
   
   //NSLog(@"vor readData");
   [self readData];
   //NSLog(@"nach readData");

   
   
    
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
   //NSLog(@"reportPlaytaste state: %ld  ident: %d tag: %ld", [sender state],ident,[sender tag]);
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
            //NSLog(@"taste state 1 play i: %d description: %@",i ,[sender description]);
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
            //NSLog(@"taste stop i: %d description: %@",i ,[sender description]);
            NSImage* playicon = [NSImage imageNamed:@"playicon.png"];
            [sender setImage:playicon];
            
         }
         
      }
      else
      {
         //NSLog(@"taste err i: %d",i );
      }
   }// for i
   
   //NSLog(@"taste pos: %d",pos );
   
   for (int i=0;i<10;i++)
   {
      if ([[sender superview] viewWithTag:i+1000]&& i != [sender tag]-1000)
      {
         //NSLog(@"taste reset da: i: %d",i );
         [[[sender superview] viewWithTag:i+1000]setState:0];
         //[[[sender superview] viewWithTag:i+1000]setTitle:@">"];
         NSImage* playicon = [NSImage imageNamed:@"playicon.png"];
         [[[sender superview] viewWithTag:i+1000]setImage:playicon];
      
      }
   }// for i
   
   
   
}



- (int)setAuswahlMitVorgabe:(int)vorgabe // Vorherige Wahl des Benutzers in Radio
{
   NSMutableParagraphStyle* centerstyle = [[NSMutableParagraphStyle alloc] init];
   [centerstyle setAlignment:NSCenterTextAlignment];
   
   int erfolg=0;
   //NSLog(@"\n\n**   setAuswahlMitVorgabe: %d  *\n",vorgabe);
   NSTabViewItem* KlasseItem = [KlasseTab selectedTabViewItem];
   int klassewahl = [Klassewahl  selectedRow];
   int klasse = [KlasseTab  indexOfTabViewItem:KlasseItem];
    //NSLog(@"setAuswahlMitVorgabe klasse: %d",klasse);
   int nummer=0;
   if (klasse)
   {
      NSTabViewItem* KlasseItem = [KlasseTab tabViewItemAtIndex:klasse];
      NSArray* viewarray = [[KlasseItem view]subviews];
//      NSLog(@"setAuswahl KlasseTab klasse: %d viewarray: %@",klasse,[viewarray description]);
      for (int k=0;k<[viewarray count];k++)
      {
         NSString* tempIdentString = [[NSNumber numberWithInt:klasse*100]stringValue];
//         NSLog(@"k: %d  ident: %@",k,[[viewarray objectAtIndex:k]identifier]);
         if ([[[viewarray objectAtIndex:k]identifier]isEqualTo:tempIdentString])
         {
//            NSLog(@"NummerItem da");
//            NummerTab = [viewarray objectAtIndex:k];
//            [NummerTab setDelegate:self];
         }
      }

     // NSTabViewItem* NummerItem; = [[KlasseTab tabViewItemAtIndex:klasse]viewWithIdentifier:]
      NSTabViewItem* NummerItem = [NummerTab selectedTabViewItem];
//      NSLog(@"ident: %@ tag: %d",[NummerTab  identifier],[NummerTab  tag]);
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
            
            NSArray* viewarray = [[NummerItem view]subviews];
            //NSLog(@"nummer 0 viewarray vor: %@",[viewarray description]);
            
            for (int k=0;k<[viewarray count];k++)
            {
               //NSLog(@"k: %d tag: %ld ident: %@",k,[[viewarray objectAtIndex:k]tag],[[viewarray objectAtIndex:k]identifier]);
            }

            [[[NummerItem view]viewWithTag:8000] setKolonnen:3];
            [[[NummerItem view]viewWithTag:8000] setTitel:@"weiss nicht" inZeile:0 inKolonne:2];
            [[[NummerItem view]viewWithTag:8000] setStatus:1 inZeile:0 inKolonne:vorgabe];
            [[[NummerItem view]viewWithTag:8000] setAction:@selector(reportRadiotaste:)];
            [[[NummerItem view]viewWithTag:8000] setNeedsDisplay:YES];
            
            //NSLog(@"setAuswahl Klassewahl: %d klasse: %d nummer: %d",klassewahl,klasse,nummer);
            
            
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
            
            NSAttributedString *attributedFrage = [[NSAttributedString alloc]
                                                   initWithString: tempFrage attributes: [NSDictionary
                                                                                          dictionaryWithObjectsAndKeys: Schriftfarbe, NSForegroundColorAttributeName,
                                                                                          [NSFont fontWithName:@"Lucida Grande Bold" size:titelschriftgroesse],NSFontAttributeName,
                                                                                          nil]];
            
            [[[NummerItem view]viewWithTag:(2000)+nummer]setAttributedStringValue:attributedFrage];
            //[[[NummerItem view]viewWithTag:(2000)+nummer]setStringValue:@"***"];
            
            // Frage sichern
            [ErgebnisDic setObject:tempFrage forKey:@"frage"];

            // Foto auswaehlen
            int fotobildindex=0;
            
            int richtigautor =0;
            for (i=0;i<[FotoArray count];i++)
            {
               if ([[[FotoArray objectAtIndex:i]objectForKey:@"art"]intValue] == 2
                   && [fotoindex containsIndex:[[[FotoArray objectAtIndex:i]objectForKey:@"autor"]intValue]] )
               {
                  //NSLog(@"Foto da: name: %@",[[FotoArray objectAtIndex:i]objectForKey:@"name"]);
                  [fotoindex removeIndex:[[[FotoArray objectAtIndex:i]objectForKey:@"autor"]intValue] ];
                 // NSImage* bild = [[FotoArray objectAtIndex:i]objectForKey:@"bild"];
                  [[[NummerItem view]viewWithTag:(6000+nummer+fotobildindex)]setImage:
                   [[FotoArray objectAtIndex:i]objectForKey:@"bild"]];
                  
                  
                  // richtiges Ergebnis setzen. Wird nachher noch mit position verglichen und als links oder rechts fixiert
                  ergebnisindex = [[[FotoArray objectAtIndex:i]objectForKey:@"autor"]intValue];
//                  [ErgebnisDic setObject:[[FotoArray objectAtIndex:i]objectForKey:@"autor"] forKey:@"lsg"];
//                 [ErgebnisDic setObject:[[FotoArray objectAtIndex:i]objectForKey:@"name"] forKey:@"lsgtext"];
                  
                  richtigautor = [[[FotoArray objectAtIndex:i]objectForKey:@"autor"]intValue];
                  // Bildlegende setzen
                  
                  
                  NSAttributedString *attributedLegende = [[NSAttributedString alloc]
                                                           initWithString: [[FotoArray objectAtIndex:i]objectForKey:@"name"] attributes: [NSDictionary
                                                                                                                                          dictionaryWithObjectsAndKeys: Schriftfarbe, NSForegroundColorAttributeName,
                                                                                                                                          [NSFont fontWithName:@"Lucida Grande Bold" size:legendeschriftgroesse],NSFontAttributeName,
                                                                                                                                          centerstyle, NSParagraphStyleAttributeName,
                                                                                                                                          nil]];
                  
                  [[[NummerItem view]viewWithTag:(9000+0)]setAttributedStringValue:attributedLegende];
                  
                  //[Bildlegende setStringValue:[[FotoArray objectAtIndex:i]objectForKey:@"name"]];
                  fotobildindex++;
                  
               }
               
            }//for
            
            
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
            //NSLog(@"setAuswahl nummer 0  MusikArray: %@",[[MusikArray valueForKey:@"name"]description]);
            //NSLog(@"setAuswahl nummer 0  musikindex: %@",[musikindex description]);
            
            // Array fuer Dics mit den Angaben zum Autor
            NSMutableArray* tempAutorArray = [[NSMutableArray alloc]initWithCapacity:0];
            
            for (i=0;i<[MusikArray count];i++)
            {
               //NSLog(@"MusikArray i: %d autor: %d",i,[[[MusikArray objectAtIndex:i]objectForKey:@"autor"]intValue]);
               if ([[[MusikArray objectAtIndex:i]objectForKey:@"art"]intValue] == 1
                   && [musikindex containsIndex:[[[MusikArray objectAtIndex:i]objectForKey:@"autor"]intValue]] )
               {
                  NSMutableDictionary* tempAutorDic = [[NSMutableDictionary alloc]initWithCapacity:0];
                  // Name des autors einsetzen
                  [tempAutorDic setObject:[[MusikArray objectAtIndex:i]objectForKey:@"name"] forKey:@"autorname"];

                  int ergebniscode =[[[MusikArray objectAtIndex:i]objectForKey:@"autor"]intValue];
                  [[[NummerItem view]viewWithTag:8000]setErgebniscode:ergebniscode inZeile:0 inKolonne:soundindex];
                  
                  // code des autors einsetzen
                  [tempAutorDic setObject:[NSNumber numberWithInt:[[[MusikArray objectAtIndex:i]objectForKey:@"autor"]intValue]] forKey:@"autor"];
                                    
                  //NSLog(@"i: %d tempAutorDic: %@",i, [tempAutorDic description]);
                  [tempAutorArray addObject:tempAutorDic];

                  //  NSLog(@"nummer 0 Musik da: name: %@",[[MusikArray objectAtIndex:i]objectForKey:@"name"]);
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
               else
               {
                  //NSLog(@"nummer 0 Musik nicht da");
               }
            }
            
            //NSLog(@"nummer 0 richtigautor: %d tempAutorArray %@",richtigautor, [tempAutorArray description]);
            
            long richtigpos = [[tempAutorArray valueForKey:@"autor"]indexOfObject:[NSNumber numberWithInt:richtigautor]];
            //NSLog(@"nummer 0 richtigpos: %d ",richtigpos);
            NSString* richtigautorname;
            // Name des richtigen Komponisten
            if (richtigpos < NSNotFound)
            {
               richtigautorname = [[tempAutorArray objectAtIndex:richtigpos]objectForKey:@"autorname"];
            }
            else
            {
               richtigautorname = @"*";
            }
            [ErgebnisDic setObject:richtigautorname forKey:@"richtigtext"];
            
            //NSLog(@"MusikArray: %@",[MusikArray valueForKey:@"name"]);
            //Richtige Position einsetzen
            if (richtigpos && richtigpos < NSNotFound) // pos des richtigen Autors ist an zweiter position
            {
               [ErgebnisDic setObject:@"rechts" forKey:@"lsgtext"];
               long lsgpos = [[MusikArray valueForKey:@"autor"]indexOfObject:[[tempAutorArray valueForKey:@"autor"]lastObject]];
               //NSLog(@"rechts lsgpos: %ld", lsgpos);
               if (lsgpos < NSNotFound)
               {
                  [ErgebnisDic setObject:[[tempAutorArray valueForKey:@"autor"]lastObject] forKey:@"lsg"];
               }
               else
               {
                  [ErgebnisDic setObject:@"*" forKey:@"lsg"];
               }
            
            }
            else // pos des min ist an erster position
            {
               [ErgebnisDic setObject:@"links" forKey:@"lsgtext"];
               long lsgpos = [[MusikArray valueForKey:@"autor"]indexOfObject:[[tempAutorArray valueForKey:@"autor"]objectAtIndex:0]];
               //NSLog(@"links lsgpos: %ld", lsgpos);
               if (lsgpos < NSNotFound)
               {               
                  [ErgebnisDic setObject:[[tempAutorArray valueForKey:@"autor"]objectAtIndex:0] forKey:@"lsg"];
               }  
               else
               {
                  [ErgebnisDic setObject:@"*" forKey:@"lsg"];
               }
            }

            //NSLog(@"nummer 0 ErgebnisDic %@", [ErgebnisDic description]);

            
            // Welches Stück hat dieser Komponist geschrieben?
            // autor von Foto muss gleich sein wie Musik
            
            
            
         }break; // case 0
            
         case 1:
         {
            //NSLog(@"nummer 1 start");
            // Wer hat dieses Stück komponiert?
            // autor von Foto muss gleich sein wie von Musik
            NSArray* viewarray = [[NummerItem view]subviews];
            //NSLog(@"nummer 1 viewarray vor: %@",[viewarray description]);
            int k=0;
            for (k=0;k<[viewarray count];k++)
            {
               //NSLog(@"k: %d tag: %ld ident: %@",k,[[viewarray objectAtIndex:k]tag],[[viewarray objectAtIndex:k]identifier]);
            }
            
            [(rRadioMatrix*)[[NummerItem view]viewWithTag:8000] setKolonnen:3];
            [[[NummerItem view]viewWithTag:8000] setTitel:@"weiss nicht" inZeile:0 inKolonne:2];
            [[[NummerItem view]viewWithTag:8000] setStatus:1 inZeile:0 inKolonne:vorgabe];
            [[[NummerItem view]viewWithTag:8000] setNeedsDisplay:YES];
            [[[NummerItem view]viewWithTag:8000] setAction:@selector(reportRadiotaste:)];
            
            // Frage lesen
            //NSLog(@"FragenArray: %@",[FragenArray description]);
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
            
            NSAttributedString *attributedFrage = [[NSAttributedString alloc]
                                                   initWithString: tempFrage attributes: [NSDictionary
                                                                                          dictionaryWithObjectsAndKeys: Schriftfarbe, NSForegroundColorAttributeName,
                                                                                          [NSFont fontWithName:@"Lucida Grande Bold" size:titelschriftgroesse],NSFontAttributeName,
                                                                                          nil]];
            
           // [[[NummerItem view]viewWithTag:(klasse*3000)]setAttributedStringValue:attributedFrage];
            [[[NummerItem view]viewWithTag:(2000)]setAttributedStringValue:attributedFrage];

            //[[[NummerItem view]viewWithTag:(klasse*1000)]setStringValue:tempFrage];
            
            // Frage sichern
            [ErgebnisDic setObject:tempFrage forKey:@"frage"];
            
            
            //Bilder der Autoren suchen
            int fotobildindex=0;

            // Array fuer Dics mit den Angaben zum Autor
            NSMutableArray* tempAutorArray = [[NSMutableArray alloc]initWithCapacity:0];
            

            for (i=0;i<[FotoArray count];i++)
            {
               if ([[[FotoArray objectAtIndex:i]objectForKey:@"art"]intValue] == 2
                   && [fotoindex containsIndex:[[[FotoArray objectAtIndex:i]objectForKey:@"autor"]intValue]] )
               {
                  
                  // Autor vorhanden, daten zum Autor in tempAutorArray sichern
                  NSMutableDictionary* tempAutorDic = [[NSMutableDictionary alloc]initWithCapacity:0];
                  [tempAutorDic setObject:[[FotoArray objectAtIndex:i]objectForKey:@"name"] forKey:@"autorname"];
                  [tempAutorDic setObject:[NSNumber numberWithInt:[[[FotoArray objectAtIndex:i]objectForKey:@"autor"]intValue]] forKey:@"autor"];
                  
                  [tempAutorArray addObject:tempAutorDic];
                  
                  // Ergebniscode in Tasten setzen: "autor"
                  int ergebniscode =[[[FotoArray objectAtIndex:i]objectForKey:@"autor"]intValue];
                  [[[NummerItem view]viewWithTag:8000]setErgebniscode:ergebniscode inZeile:0 inKolonne:fotobildindex];
                  
                  
                  //NSLog(@"nummer 2 Foto da fotobildindex: %d : ergebniscode: %d name: %@",fotobildindex, ergebniscode, [[FotoArray objectAtIndex:i]objectForKey:@"name"]);
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
               }
            }
            
            // Musik auswaehlen 1 Stueck
            int soundindex=0;
            
            int richtigautor =0;
            
            //NSLog(@"reportAuswahl nummer 1 musikindex: %@",[musikindex description]);
            //NSLog(@"reportAuswahl nummer 1 Musikarray: %@",[[MusikArray valueForKey:@"name" ]description]);
            for (i=0;i<[MusikArray count];i++)
            {
               if ([[[MusikArray objectAtIndex:i]objectForKey:@"art"]intValue] == 1
                   && [musikindex containsIndex:[[[MusikArray objectAtIndex:i]objectForKey:@"autor"]intValue]] )
               {
                   
                  //NSLog(@"nummer 1 Musik da i: %d soundindex: %d name: %@",i, soundindex,[[MusikArray objectAtIndex:i]objectForKey:@"name"]);
                  if ([[NummerItem view]viewWithTag:(1000+soundindex)]) // Taste vorhanden
                  {
                     
                     // identifier der Play-Taste zu position des Musikstuecks im Musikarray setzen
                     [[[NummerItem view]viewWithTag:(1000+soundindex)]setIdentifier:[[NSNumber numberWithInt:(1000+i)]stringValue]];
                     //NSLog(@"nummer 1 Taste da ident: %@",[[NSNumber numberWithInt:(1000+i)]stringValue]);
                     //[[[NummerItem view]viewWithTag:(1000+soundindex)]setTag:1000+i];
                     
                     richtigautor = [[[MusikArray objectAtIndex:i]objectForKey:@"autor"]intValue];
                     
                     [musikindex removeIndex:[[[MusikArray objectAtIndex:i]objectForKey:@"autor"]intValue]];
                     soundindex++;
                     
                     // richtiges Ergebnis setzen
                     ergebnisindex = [[[MusikArray objectAtIndex:i]objectForKey:@"autor"]intValue];
                     [ErgebnisDic setObject:[[MusikArray objectAtIndex:i]objectForKey:@"autor"] forKey:@"lsg"];
                      
                     
                     [ErgebnisDic setObject:[[MusikArray objectAtIndex:i]objectForKey:@"name"] forKey:@"lsgtext"];
                     //NSLog(@"nummer 1  i: %d lsg: %d lsgtext: %@",i, [[[MusikArray objectAtIndex:i]objectForKey:@"autor"]intValue],[[MusikArray objectAtIndex:i]objectForKey:@"name"]);

                  }
                  
               }
            }
            
            // Autorname fuer richtigautor suchen
            long richtigpos = [[tempAutorArray valueForKey:@"autor"]indexOfObject:[NSNumber numberWithInt:richtigautor]];
            
            NSString* richtigautorname = [[tempAutorArray objectAtIndex:richtigpos]objectForKey:@"autorname"];
            [ErgebnisDic setObject:richtigautorname forKey:@"lsgtext"];
            
            //NSLog(@"reportAuswahl nummer 1  richtigautor: %d richtigpos: %ld richtigautorname: %@",richtigautor, richtigpos,richtigautorname);
            
            
            //NSLog(@"nummer 1 ErgebnisDic %@", [ErgebnisDic description]);

            
            //NSLog(@"reportAuswahl nummer 1 end musikindex");
            
            //NSLog(@"nummer 1 viewarray nach: %@",[viewarray description]);
            //NSLog(@"nummer 1 viewarray nach");
            for (k=0;k<[viewarray count];k++)
            {
               //NSLog(@"k: %d tag: %ld ident: %@",k,[[viewarray objectAtIndex:k]tag],[[viewarray objectAtIndex:k]identifier]);
            }

            //NSLog(@"nummer 1 end");
         }break; // case 1
            
         case 2:
         {
            // Welches dieser Stücke ist früher komponiert worden?
            
            NSArray* viewarray = [[NummerItem view]subviews];
            //NSLog(@"nummer 2 viewarray: %@",[viewarray description]);
            int k=0;
            for (k=0;k<[viewarray count];k++)
            {
               //NSLog(@"k: %d tag: %ld ident: %@",k,[[viewarray objectAtIndex:k]tag],[[viewarray objectAtIndex:k]identifier]);
            }
            
            
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
            NSAttributedString *attributedFrage = [[NSAttributedString alloc]
                                                   initWithString: tempFrage attributes: [NSDictionary
                                                                                          dictionaryWithObjectsAndKeys: Schriftfarbe, NSForegroundColorAttributeName,
                                                                                          [NSFont fontWithName:@"Lucida Grande Bold" size:titelschriftgroesse],NSFontAttributeName,
                                                                                          nil]];
            
            //[[[NummerItem view]viewWithTag:(klasse*3000)]setAttributedStringValue:attributedFrage];
            [[[NummerItem view]viewWithTag:(2000)]setAttributedStringValue:attributedFrage];
            
            // Frage sichern
            [ErgebnisDic setObject:tempFrage forKey:@"frage"];
            
            // Musik auswaehlen
            int soundindex=0;
            //NSLog(@"reportAuswahl nummer 2 musikindex: %@",[musikindex description]);
            
            // IndexSet fuer Epoche der Komponisten-Fotos
            NSMutableIndexSet* tempEpocheindex = [NSMutableIndexSet indexSet];
            
            // Array fuer Dics mit den Angaben zur Epoche
            NSMutableArray* tempEpocheArray = [[NSMutableArray alloc]initWithCapacity:0];
            
            for (i=0;i<[MusikArray count];i++)
            {
               //NSLog(@"nummer 2 [MusikArray an index: %d %@",i,[[MusikArray objectAtIndex:i] description]);
               if ([[[MusikArray objectAtIndex:i]objectForKey:@"art"]intValue] == 1
                   && [musikindex containsIndex:[[[MusikArray objectAtIndex:i]objectForKey:@"autor"]intValue]] )
               {
                  
                  NSMutableDictionary* tempEpocheDic = [[NSMutableDictionary alloc]initWithCapacity:0];
                  [tempEpocheDic setObject:[[MusikArray objectAtIndex:i]objectForKey:@"autor"] forKey:@"autor"];
                  
                  
                  // epoche einsetzen
                  NSNumber* epochenumber = [[MusikArray objectAtIndex:i]objectForKey:@"epoche"];
                  [tempEpocheDic setObject:[NSNumber numberWithInt:[[[MusikArray objectAtIndex:i]objectForKey:@"epoche"]intValue]] forKey:@"epoche"];
                  
                  // Lage der Epoche im EpochenArray
                  long epochepos =[[EpochenArray valueForKey:@"epoche"]indexOfObject:epochenumber];
                  //NSLog(@"i: %d epochepos: %d ",i,epochepos);
                  //Name der Epoche an epochepos holen
                  [tempEpocheDic setObject:[[EpochenArray objectAtIndex:epochepos]objectForKey:@"name"] forKey:@"epochename"];
                  [tempEpocheDic setObject:[NSNumber numberWithInt:soundindex] forKey:@"pos"];
                  
                  //NSLog(@"i: %d tempEpocheDic: %@",i, [tempEpocheDic description]);
                  [tempEpocheArray addObject:tempEpocheDic];
                  
                  
                  //int ergebniscode =[[[MusikArray objectAtIndex:i]objectForKey:@"autor"]intValue];
                  int ergebniscode =[[[MusikArray objectAtIndex:i]objectForKey:@"epoche"]intValue];
                  
                  [[[NummerItem view]viewWithTag:8000]setErgebniscode:ergebniscode inZeile:0 inKolonne:soundindex];
                  
                  
                  
                  //   NSLog(@"2 Musik da soundindex: %d : name: %@",soundindex,[[MusikArray objectAtIndex:i]objectForKey:@"name"]);
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
            
            //NSLog(@"nummer 2 viewarray nach: %@",[viewarray description]);
            for (int k=0;k<[viewarray count];k++)
            {
               // NSLog(@"k: %d tag: %ld ident: %@",k,[[viewarray objectAtIndex:k]tag],[[viewarray objectAtIndex:k]identifier]);
            }
            
            // richtiges Ergebnis setzen
            //int richtigindex = min([musikindex firstIndex],[musikindex lastIndex]);
            //NSLog(@"nummer 2 ind0: %lu ind1: %lu max: %d",[musikindex firstIndex],[musikindex lastIndex],richtigindex);
            
            
            int richtigindex = [self minVonArray:[tempEpocheArray valueForKey:@"epoche"]];
            long richtigpos = [[tempEpocheArray valueForKey:@"epoche"]indexOfObject:[NSNumber numberWithInt:richtigindex]];
            
            NSString* epochename;
            NSString* epocheautorname;
            int richtigautor = -1;
            long richtigautorpos = NSNotFound;
            if (richtigpos < NSNotFound)
            {
               epochename = [[tempEpocheArray objectAtIndex:richtigpos]objectForKey:@"epochename"];
               
               richtigautor = [[[tempEpocheArray objectAtIndex:richtigpos]objectForKey:@"autor"]intValue];
               //NSLog(@"nummer 2 FotoArray valueForKey autor: %@",[[FotoArray valueForKey:@"autor"]description]);
               // pos von richtigautor im Fotoarray
               richtigautorpos = [[FotoArray valueForKey:@"autor"]indexOfObject:[[tempEpocheArray objectAtIndex:richtigpos]objectForKey:@"autor"]];
               
               if (richtigautorpos < NSNotFound)
               {
                  // Name des Komponisten aus Fotoarray
                  epocheautorname = [[FotoArray objectAtIndex:richtigautorpos]objectForKey:@"name"];
               }
               else // nur name der epoche
               {
                  epocheautorname = [[tempEpocheArray objectAtIndex:richtigpos]objectForKey:@"autor"];
               }
            }
            else
            {
               epochename = @"*";
               epocheautorname = @"*";
               
            }
            
            [ErgebnisDic setObject:epochename forKey:@"richtigtext" ];
           [ErgebnisDic setObject:epocheautorname forKey:@"richtiganmerkung" ];
            
            //NSLog(@"nummer 2 richtigindex: %d pos: %d tempEpocheArray: %@ ",richtigindex, pos, [tempEpocheArray description]);
            //NSLog(@"nummer 2 richtigindex: %d richtigpos: %ld richtigautor: %d epochename zu richtigindex: %@ richtigautorpos: %ld epocheautorname: %@",richtigindex, richtigpos, richtigautor, epochename, richtigautorpos,epocheautorname);
            
            
            if (richtigpos && richtigpos < NSNotFound) // pos des min ist an zweiter position
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
                  // int ergebniscode =[[[NotenArray objectAtIndex:i]objectForKey:@"autor"]intValue];
                  //  [[[NummerItem view]viewWithTag:8000]setErgebniscode:ergebniscode inZeile:0 inKolonne:notenbildindex];
                  
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
            //NSLog(@"nummer 2 viewarray nach: %@",[viewarray description]);
           
            for (int k=0;k<[viewarray count];k++)
            {
               //NSLog(@"k: %d tag: %ld ident: %@",k,[[viewarray objectAtIndex:k]tag],[[viewarray objectAtIndex:k]identifier]);
            }
 
            
         }break; // case 2
            
            
         case 3:
         {
            NSLog(@"setauswahl nummer 3");
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
            
            // Welcher dieser Komponisten lebte näher zu unserer Zeit?
            
            NSAttributedString *attributedFrage = [[NSAttributedString alloc]
                                                   initWithString: tempFrage attributes: [NSDictionary
                                                                                          dictionaryWithObjectsAndKeys: Schriftfarbe, NSForegroundColorAttributeName,
                                                                                          [NSFont fontWithName:@"Lucida Grande Bold" size:titelschriftgroesse],NSFontAttributeName,
                                                                                          nil]];
            
           // [[[NummerItem view]viewWithTag:(klasse*3000)]setAttributedStringValue:attributedFrage];
            [[[NummerItem view]viewWithTag:(2000)]setAttributedStringValue:attributedFrage];

            //[[[NummerItem view]viewWithTag:(klasse*1000)]setStringValue:tempFrage];
            
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
                  
                  [tempEpocheDic setObject:[[FotoArray objectAtIndex:i]objectForKey:@"name"] forKey:@"autorname"];
                  
                  // epoche einsetzen für das Bild an position i
                  [tempEpocheindex addIndex:[[[FotoArray objectAtIndex:i]objectForKey:@"epoche"]intValue]];
                  NSNumber* epochenumber = [[FotoArray objectAtIndex:i]objectForKey:@"epoche"];
                  [tempEpocheDic setObject:[NSNumber numberWithInt:[[[FotoArray objectAtIndex:i]objectForKey:@"epoche"]intValue]] forKey:@"epoche"];
                  
                  //NSLog(@"nummer 3 i: %d epochenumber: %d ",i,[epochenumber intValue]);
                  // Lage der Epoche im EpochenArray
                  long epochepos =[[EpochenArray valueForKey:@"epoche"]indexOfObject:epochenumber];
                  //NSLog(@"nummer 3 i: %d epochepos: %d ",i,epochepos);
                  
                  //Name der Epoche an epochepos holen
                  [tempEpocheDic setObject:[[EpochenArray objectAtIndex:epochepos]objectForKey:@"name"] forKey:@"epochename"];
                  
                  //NSLog(@"nummer 3 i: %d tempEpocheDic: %@",i, [tempEpocheDic description]);
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
            long richtigindex = [self maxVonArray:[tempEpocheArray valueForKey:@"epoche"]];
            
            long richtigpos = [[tempEpocheArray valueForKey:@"epoche"]indexOfObject:[NSNumber numberWithInt:richtigindex]];
            
            
            
           // NSLog(@"nummer 3 richtigpos: %ld",richtigpos);
            
            //  pos = [[FotoArray valueForKey:@"epoche"]indexOfObject:[NSNumber numberWithInt:richtigindex]];
            NSString* epochename;
            NSString* komponistzuepochename;
            
            if (richtigpos < NSNotFound)
            {
               komponistzuepochename = [[tempEpocheArray objectAtIndex:richtigpos]objectForKey:@"autorname"];
               epochename = [[tempEpocheArray objectAtIndex:richtigpos]objectForKey:@"epochename"];
            }
            else
            {
               komponistzuepochename = @"-";
               epochename = @"*";
            }
            
            NSLog(@"nummer 3 richtigindex: %d richtigpos: %d epochename: name zu richtigindex: %@ ",richtigindex, richtigpos, epochename,komponistzuepochename);
            
            [ErgebnisDic setObject:[NSNumber numberWithInt:richtigindex] forKey:@"lsg"];
            [ErgebnisDic setObject:komponistzuepochename forKey:@"lsgtext"];
            [ErgebnisDic setObject:epochename forKey:@"richtigtext"];
            // Musik auswaehlen
            int soundindex=0;
            
            NSArray* viewarray = [[NummerItem view]subviews];
            
            //NSLog(@"nummer  3 viewarray vor");
            for (int k=0;k<[viewarray count];k++)
            {
               //NSLog(@"nummer 3 k: %d tag: %ld %@",k,[[viewarray objectAtIndex:k]tag],[[viewarray objectAtIndex:k]identifier]);
            }
            
            //NSLog(@"nummer 3  musikindex : %@",[musikindex description]);
            for (i=0;i<[MusikArray count];i++)
            {
               //NSLog(@"nummer 3 i: %d musikindex : %@ autor: %d ",i,[musikindex description],[[[MusikArray objectAtIndex:i]objectForKey:@"autor"]intValue]);
               
               if ([[[MusikArray objectAtIndex:i]objectForKey:@"art"]intValue] == 1
                   && [musikindex containsIndex:[[[MusikArray objectAtIndex:i]objectForKey:@"autor"]intValue]] )
               {
                  
                  
                  //NSLog(@"nummer 3 soundindex: %d Musik da: name: %@",soundindex,[[MusikArray objectAtIndex:i]objectForKey:@"name"]);
                  if ([[NummerItem view]viewWithTag:(1000+soundindex)]) // Play-Taste vorhanden
                  {
                     int ergebniscode =[[[MusikArray objectAtIndex:i]objectForKey:@"epoche"]intValue];
                     //NSLog(@"nummer 3 taste: %d ergebniscode Musik: %d",soundindex, ergebniscode);
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
            
            //NSLog(@"nummer  3 viewarray nach");
            for (int k=0;k<[viewarray count];k++)
            {
               //NSLog(@"nummer 3 k: %d tag: %ld %@",k,[[viewarray objectAtIndex:k]tag],[[viewarray objectAtIndex:k]identifier]);
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
            
            //[[[NummerItem view]viewWithTag:(klasse*1000)]setStringValue:tempFrage];
            NSAttributedString *attributedFrage = [[NSAttributedString alloc]
                                                   initWithString: tempFrage attributes: [NSDictionary
                                                                                          dictionaryWithObjectsAndKeys: Schriftfarbe, NSForegroundColorAttributeName,
                                                                                          [NSFont fontWithName:@"Lucida Grande Bold" size:titelschriftgroesse],NSFontAttributeName,
                                                                                          nil]];
            
            //[[[NummerItem view]viewWithTag:(klasse*3000)]setAttributedStringValue:attributedFrage];
            [[[NummerItem view]viewWithTag:(2000)]setAttributedStringValue:attributedFrage];
            
            
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
                  [ErgebnisDic setObject:[[MusikArray objectAtIndex:i]objectForKey:@"name"]forKey:@"richtigtext"];
                  
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
                  
                  //NSLog(@"4 Foto da fotobildindex: %d : name: %@ epoche: %d",fotobildindex,[[FotoArray objectAtIndex:i]objectForKey:@"name"], [[[FotoArray objectAtIndex:i]objectForKey:@"epoche"]intValue]);
                  [fotoindex removeIndex:[[[FotoArray objectAtIndex:i]objectForKey:@"autor"]intValue] ];
                  
                  // Epoche des Komponisten
                  [ErgebnisDic setObject:[[FotoArray objectAtIndex:i]objectForKey:@"epoche"] forKey:@"lsg"];
                  lsgepoche = [[[FotoArray objectAtIndex:i]objectForKey:@"epoche"]intValue];
                  //[ErgebnisDic setObject:[[FotoArray objectAtIndex:i]objectForKey:@"name"] forKey:@"lsgtext"];
                  
                  
                  //NSImage* bild = [[FotoArray objectAtIndex:i]objectForKey:@"bild"];
                  
                  // Bild der Epoche  im View 5000+fotobildindex einsetzen.
                  [[[NummerItem view]viewWithTag:(5000+fotobildindex)]setImage:[[FotoArray objectAtIndex:i]objectForKey:@"bild"]];
                  
                  // Name der Epoche in View 9000+fotobildindex einsetzen
                  
                  NSAttributedString *attributedLegende = [[NSAttributedString alloc]
                                                           initWithString: [[FotoArray objectAtIndex:i]objectForKey:@"name"] attributes: [NSDictionary
                                                                                                                                          dictionaryWithObjectsAndKeys: Schriftfarbe, NSForegroundColorAttributeName,
                                                                                                                                          [NSFont fontWithName:@"Lucida Grande Bold" size:legendeschriftgroesse],NSFontAttributeName,
                                                                                                                                          centerstyle, NSParagraphStyleAttributeName,
                                                                                                                                          nil]];
                  
                  [[[NummerItem view]viewWithTag:(9000+fotobildindex)]setAttributedStringValue:attributedLegende];
                  
                  //[[[NummerItem view]viewWithTag:(9000+fotobildindex)]setStringValue:[[FotoArray objectAtIndex:i]objectForKey:@"name"]];
                  
                  
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
            
            //[[[NummerItem view]viewWithTag:(klasse*1000)]setStringValue:tempFrage];
            NSAttributedString *attributedFrage = [[NSAttributedString alloc]
                                                   initWithString: tempFrage attributes: [NSDictionary
                                                                                          dictionaryWithObjectsAndKeys: Schriftfarbe, NSForegroundColorAttributeName,
                                                                                          [NSFont fontWithName:@"Lucida Grande Bold" size:titelschriftgroesse],NSFontAttributeName,
                                                                                          nil]];
            
            //[[[NummerItem view]viewWithTag:(klasse*3000)]setAttributedStringValue:attributedFrage];
            [[[NummerItem view]viewWithTag:(2000)]setAttributedStringValue:attributedFrage];
            
            
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
                  [tempEpocheDic setObject:[[NotenArray objectAtIndex:i]objectForKey:@"name"]forKey:@"autorname"];
                  
                  
                  if ([[NummerItem view]viewWithTag:(5000+notenbildindex)]) // Bild vorhanden
                  {
                     [[[NummerItem view]viewWithTag:(5000+notenbildindex)]setImage:
                      [[NotenArray objectAtIndex:i]objectForKey:@"bild"]];
                     
                     //NSLog(@"5 Noten da notenbildindex: %d : name: %@ epoche: %d",notenbildindex,[[NotenArray objectAtIndex:i]objectForKey:@"name"], [[[NotenArray objectAtIndex:i]objectForKey:@"epoche"]intValue]);
                     
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
            //NSLog(@"nummer 5 tempEpocheArray: %@",[tempEpocheArray description]);
            
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
            NSString*  epocheergebnisname;
            for (i=0;i<[EpochenArray count];i++)
            {
               if ([[[EpochenArray objectAtIndex:i]objectForKey:@"art"]intValue] == 4
                   && [epochenindex containsIndex:[[[EpochenArray objectAtIndex:i]objectForKey:@"autor"]intValue]] )
               {
                  //NSLog(@"5 Epoche da: name: %@ epoche: %d",[[EpochenArray objectAtIndex:i]objectForKey:@"name"],[[[EpochenArray objectAtIndex:i]objectForKey:@"epoche"]intValue]);
                  
                  [epochenindex removeIndex:[[[EpochenArray objectAtIndex:i]objectForKey:@"autor"]intValue] ];
                  
                  // index fuer richtiges Ergebnis setzen
                  epocheergebnisindex = [[[EpochenArray objectAtIndex:i]objectForKey:@"epoche"]intValue];
                  //[ErgebnisDic setObject:[[EpochenArray objectAtIndex:i]objectForKey:@"epoche"] forKey:@"lsg"];
                  epocheergebnisname = [[EpochenArray objectAtIndex:i]objectForKey:@"name"];
                  
                  //[ErgebnisDic setObject:[[EpochenArray objectAtIndex:i]objectForKey:@"name"] forKey:@"lsgtext"];
                  
                  //NSImage* bild = [[EpochenArray objectAtIndex:i]objectForKey:@"bild"];
                  [[[NummerItem view]viewWithTag:(6000+epochebildindex)]setImage:
                   [[EpochenArray objectAtIndex:i]objectForKey:@"bild"]];
                  
                  NSAttributedString *attributedLegende = [[NSAttributedString alloc]
                                                           initWithString: [[EpochenArray objectAtIndex:i]objectForKey:@"name"] attributes: [NSDictionary
                                                                                                                                             dictionaryWithObjectsAndKeys: Schriftfarbe, NSForegroundColorAttributeName,
                                                                                                                                             [NSFont fontWithName:@"Lucida Grande Bold" size:legendeschriftgroesse],NSFontAttributeName,
                                                                                                                                             centerstyle, NSParagraphStyleAttributeName,
                                                                                                                                             nil]];
                  
                  [[[NummerItem view]viewWithTag:(9000+epochebildindex)]setAttributedStringValue:attributedLegende];
                  
                  
                  
                  
                  //[[[NummerItem view]viewWithTag:(9000+epochebildindex)]setStringValue:[[EpochenArray objectAtIndex:i]objectForKey:@"name"]];
                  
                  
                  epochebildindex++;
                  
               }
               
            }//for
            
            //richtiges Ergebnis setzen
            
            // position der Epoche im tempEpocheArray fuer epocheergebnisindex
            long pos = [[tempEpocheArray valueForKey:@"epoche"]indexOfObject:[NSNumber numberWithInt:epocheergebnisindex]];
            //NSLog(@"nummer 5 position der Epoche im tempEpocheArray: %d",pos);
            
            if (pos) // pos des min ist an zweiter position
            {
               [ErgebnisDic setObject:@"rechts" forKey:@"lsgtext"];
               [ErgebnisDic setObject:[[tempEpocheArray valueForKey:@"epoche"]lastObject] forKey:@"lsg"];
               [ErgebnisDic setObject:[[tempEpocheArray valueForKey:@"autorname"]lastObject] forKey:@"richtiganmerkung"];
               [ErgebnisDic setObject:epocheergebnisname forKey:@"richtigtext"];
            }
            else // pos des min ist an erster position
            {
               [ErgebnisDic setObject:@"links" forKey:@"lsgtext"];
               [ErgebnisDic setObject:[[tempEpocheArray valueForKey:@"epoche"]objectAtIndex:0] forKey:@"lsg"];
               [ErgebnisDic setObject:[[tempEpocheArray valueForKey:@"autorname"]objectAtIndex:0] forKey:@"richtiganmerkung"];
               [ErgebnisDic setObject:epocheergebnisname forKey:@"richtigtext"];

            }
            
            //NSLog(@"nummer 5 ErgebnisDic %@", [ErgebnisDic description]);

            
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
            //NSLog(@"standard nummer: %d",nummer);
            int ergebnispos = [[MasterErgebnisArray valueForKey:@"code"]indexOfObject:[ErgebnisDic objectForKey:@"code"]];
            //NSLog(@"Master ErgebnisDic: %@ ergebnispos: %d",[ErgebnisDic description],ergebnispos);
            if (ergebnispos >=0)
            {
               [MasterErgebnisArray replaceObjectAtIndex:ergebnispos withObject:ErgebnisDic];
            }
            else
            {
               [MasterErgebnisArray addObject:ErgebnisDic];
            }

         }break;
            
         case 2: // master
         {
            int ergebnispos = [[MasterErgebnisArray valueForKey:@"code"]indexOfObject:[ErgebnisDic objectForKey:@"code"]];
            //NSLog(@"Master ErgebnisDic: %@ ergebnispos: %d",[ErgebnisDic description],ergebnispos);
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

- (IBAction)reportSettingfenster:(id)sender
{
   //NSLog(@"reportSettingfenster");
   if ([[player movie]rate])
   {
      [[player movie]stop];
   }
   NSMutableDictionary* SettingsdatenDic = [[NSMutableDictionary alloc]initWithCapacity:0];

   
   NSArray* klasseviewarray = [[[KlasseTab selectedTabViewItem]view ]subviews];
   //NSLog(@"reportSettingfenster klasse tabviewItem: %@ ", [[KlasseTab selectedTabViewItem] label]);
   int klasse = [KlasseTab indexOfTabViewItem:[KlasseTab selectedTabViewItem]];
   //NSLog(@" klassetab views: %@ ", [klasseviewarray description]);
   
   [SettingsdatenDic setObject:[NSNumber numberWithInt:klasse] forKey:@"klasse"];
   int nummer = [NummerTab indexOfTabViewItem:[NummerTab selectedTabViewItem]];
   [SettingsdatenDic setObject:[NSNumber numberWithInt:nummer] forKey:@"nummer"];
   [SettingsdatenDic setObject:MusikArray forKey:@"musikarray"];
   [SettingsdatenDic setObject:NotenArray forKey:@"notenarray"];
   [SettingsdatenDic setObject:FotoArray forKey:@"fotoarray"];
   [SettingsdatenDic setObject:EpochenArray forKey:@"epochenarray"];
   [SettingsdatenDic setObject:FragenArray forKey:@"fragenarray"];
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
   
   
   //NSLog(@"reportSettingfenster end");
}

- (IBAction)reportErgebnisfenster:(id)sender
{
   
   if (!Ergebnis)
	{
      //Settings=[[rSettingsWindowController alloc]initWithWindowNibName:@"Settings"];
		Ergebnis=[[rErgebnisWindowController alloc]initWithWindowNibName:@"Ergebnis"];
	}
	[Ergebnis showWindow:self];
   long klasse = [KlasseTab indexOfTabViewItem:[KlasseTab selectedTabViewItem]];
   
   //NSLog(@"reportErgebnisfenster MasterErgebnisArray: %@",[MasterErgebnisArray description]);
   NSDictionary* tempDatenDic = [NSDictionary dictionaryWithObjectsAndKeys:MasterErgebnisArray,@"masterergebnisarray",
                                 [NSNumber numberWithInt:klasse], @"klasse",nil ];
   [Ergebnis setDaten:tempDatenDic];
   
}

- (IBAction)resetErgebnisse:(id)sender
{
   NSLog(@"resetErgebnisse MasterErgebnisArray vor: %@",[MasterErgebnisArray description]);
   for(int i=0;i<[MasterErgebnisArray count];i++)
   {
      if ([[MasterErgebnisArray objectAtIndex:i]objectForKey:@"wahl"])
      {
         [[MasterErgebnisArray objectAtIndex:i]setObject:[NSNumber numberWithInt:-1] forKey:@"wahl"];
      }
      if ([[MasterErgebnisArray objectAtIndex:i]objectForKey:@"wahlpos"])
      {
         [[MasterErgebnisArray objectAtIndex:i]setObject:[NSNumber numberWithInt:-1] forKey:@"wahlpos"];
      }
   }
   NSLog(@"resetErgebnisse MasterErgebnisArray nach: %@",[MasterErgebnisArray description]);

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
   //NSLog(@"reportKlassewahl Klasse: %ld",[sender selectedRow]+1);
   
   
   [KlasseTab selectTabViewItemAtIndex:[sender selectedRow]+1];
   //[[[[KlasseTab selectedTabViewItem] view]viewWithTag:3000]selectTabViewItemAtIndex:0];
   int klasse = [sender selectedRow]+1;
   NSArray* viewarray = [[[KlasseTab selectedTabViewItem] view]subviews];
   
   //NSLog(@"reportKlassewahl KlasseTab klasse: %d viewarray: %@",klasse,[viewarray description]);
   for (int k=0;k<[viewarray count];k++)
   {
      NSString* tempIdentString = [[NSNumber numberWithInt:klasse*100]stringValue];
      //NSLog(@"k: %d  ident: %@ tag: %ld",k,[[viewarray objectAtIndex:k]identifier],[[viewarray objectAtIndex:k]tag]);
      if ([[[viewarray objectAtIndex:k]identifier]isEqualTo:tempIdentString])
      {
         //NSLog(@"NummerItem da ident: %@",[[viewarray objectAtIndex:k]identifier]);
         NummerTab = [viewarray objectAtIndex:k];
         [NummerTab setDelegate:self];
      }
   }

   
   
   
   [NummerTab selectTabViewItemAtIndex:0];
   
   [self setAuswahlMitVorgabe:2];
   
   NSAttributedString *attributedKlasse = [[NSAttributedString alloc]
                                          initWithString: [NSString stringWithFormat:@"Level: %ld",[sender selectedRow]+1] attributes: [NSDictionary
                                                                                 dictionaryWithObjectsAndKeys: Schriftfarbe, NSForegroundColorAttributeName,
                                                                                 [NSFont fontWithName:@"Lucida Grande Bold" size:legendeschriftgroesse],NSFontAttributeName,
                                                                                 nil]];
   
   //[Klassefeld setAttributedStringValue:attributedKlasse];
   if ([[[KlasseTab selectedTabViewItem]view] viewWithTag:9100])
        {
           //NSLog(@"KlasseTab da");
   [[[[KlasseTab selectedTabViewItem]view] viewWithTag:9100]setAttributedStringValue:attributedKlasse];
        }
   NSAttributedString *attributedNummer = [[NSAttributedString alloc]
                                           initWithString: [NSString stringWithFormat:@"Nummer: %d",1] attributes: [NSDictionary
                                                                                                                                         dictionaryWithObjectsAndKeys: Schriftfarbe, NSForegroundColorAttributeName,
                                                                                                                                         [NSFont fontWithName:@"Lucida Grande Bold" size:legendeschriftgroesse],NSFontAttributeName,
                                                                                                                                         nil]];
  //[Nummerfeld setAttributedStringValue:attributedNummer];

   if ([[[KlasseTab selectedTabViewItem]view] viewWithTag:9101])
   {
      //NSLog(@"KlasseTab da");
      [[[[KlasseTab selectedTabViewItem]view] viewWithTag:9101]setAttributedStringValue:attributedNummer];
   }

   [Nexttaste setEnabled:YES];
   
   //NSLog(@"reportKlassewahl end");
   
   //   [self setAuswahl];
}



- (IBAction)reportNexttaste:(id)sender
{
   int aktuellenummer = [NummerTab indexOfTabViewItem:[NummerTab selectedTabViewItem]];

   //NSLog(@"reportNexttaste index: %ld aktuellenummer: %d",[NummerTab indexOfTabViewItem:[NummerTab selectedTabViewItem]],aktuellenummer);
   if ([[player movie]rate])
   {
      [[player movie]stop];
      
   }
   
   [[Ergebnis window]orderOut:NULL];
   
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
  //NSLog(@"reportNexttaste viewarray: %@",[viewarray description]);
   
   
   
  /*
   // tag-Bereich der Playtasten
   NSRange tabrange = NSMakeRange(1000, 10);
   NSIndexSet* tabindex = [NSIndexSet indexSetWithIndexesInRange:tabrange];
   for (int k=0;k<[viewarray count];k++)
   {
      NSLog(@"k: %d tag: %ld",k,[[viewarray objectAtIndex:k]tag]);
      if ([tabindex containsIndex:[[viewarray objectAtIndex:k]tag]] )
      {
         int temptag=[[viewarray objectAtIndex:k]tag];
         [[[[NummerTab selectedTabViewItem]view]viewWithTag:temptag]setState:0];
         NSLog(@"Playtaste da");
         NSImage* playicon = [NSImage imageNamed:@"playicon.png"];
         [[[[NummerTab selectedTabViewItem]view ]viewWithTag:temptag]setImage:playicon];
      
      }
      [[[NummerTab selectedTabViewItem]view ]setNeedsDisplay:YES];
   }
   */
   
   [NummerTab selectNextTabViewItem:NULL];
   
   //[Nummerfeld setStringValue:[NSString stringWithFormat:@"Nummer: %ld",aktuellenummer+1]];
   
   NSAttributedString *attributedNummer = [[NSAttributedString alloc]
                                           initWithString: [NSString stringWithFormat:@"Nummer: %d",aktuellenummer+2] attributes: [NSDictionary
                                                                                                                    dictionaryWithObjectsAndKeys: Schriftfarbe, NSForegroundColorAttributeName,
                                                                                                                    [NSFont fontWithName:@"Lucida Grande Bold" size:legendeschriftgroesse],NSFontAttributeName,
                                                                                                                    nil]];
   //[Nummerfeld setAttributedStringValue:attributedNummer];
   if ([[[KlasseTab selectedTabViewItem]view] viewWithTag:9101])
   {
      //NSLog(@"KlasseTab da");
      [[[[KlasseTab selectedTabViewItem]view] viewWithTag:9101]setAttributedStringValue:attributedNummer];
   }

   
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
   
   [[Ergebnis window]orderOut:NULL];

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
   //[Nummerfeld setStringValue:[NSString stringWithFormat:@"Nummer: %ld",[NummerTab indexOfTabViewItem:[NummerTab selectedTabViewItem]]+1]];

   NSAttributedString *attributedNummer = [[NSAttributedString alloc]
                                           initWithString: [NSString stringWithFormat:@"Nummer: %ld",[NummerTab indexOfTabViewItem:[NummerTab selectedTabViewItem]]+1] attributes: [NSDictionary
                                                                                                                                    dictionaryWithObjectsAndKeys: Schriftfarbe, NSForegroundColorAttributeName,
                                                                                                                                    [NSFont fontWithName:@"Lucida Grande Bold" size:legendeschriftgroesse],NSFontAttributeName,
                                                                                                                                    nil]];
   //[Nummerfeld setAttributedStringValue:attributedNummer];
   if ([[[KlasseTab selectedTabViewItem]view] viewWithTag:9101])
   {
      //NSLog(@"KlasseTab da");
      [[[[KlasseTab selectedTabViewItem]view] viewWithTag:9101]setAttributedStringValue:attributedNummer];
   }

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
   
   // Nummer zuruecksetzen
      NSAttributedString *attributedNummer = [[NSAttributedString alloc]
                                           initWithString: [NSString stringWithFormat:@"Nummer: %d",1] attributes: [NSDictionary
                                                                                                                                                                                    dictionaryWithObjectsAndKeys: Schriftfarbe, NSForegroundColorAttributeName,
                                                                                                                                                                                    [NSFont fontWithName:@"Lucida Grande Bold" size:legendeschriftgroesse],NSFontAttributeName,
                                                                                                                                                                                    nil]];
   if ([[[KlasseTab selectedTabViewItem]view] viewWithTag:9101])
   {
      //NSLog(@"KlasseTab da");
      [[[[KlasseTab selectedTabViewItem]view] viewWithTag:9101]setAttributedStringValue:attributedNummer];
   }

}

- (IBAction)reportHometaste:(id)sender
{
   if ([[player movie]rate])
   {
      [[player movie]stop];
   }
   
   [[Ergebnis window]orderOut:NULL];
   
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
   [Nexttaste setEnabled:NO];
   [Prevtaste setEnabled:NO];
}
- (IBAction)reportRadiotaste:(id)sender;
{
   long nummer = [NummerTab indexOfTabViewItem:[NummerTab selectedTabViewItem]];
   long klasse = [KlasseTab indexOfTabViewItem:[KlasseTab selectedTabViewItem]];
   switch (klasse)
   {
      case 1:
      {
         int zeile =[sender selectedRow];
         int kolonne = [sender selectedColumn];
         int ergebniscode = [sender ergebniscodeInZeile:zeile inKolonne:kolonne];
         int benutzerwahl = [[[MasterErgebnisArray objectAtIndex:nummer]objectForKey:@"wahl"]intValue];
         //NSLog(@"reportRadiotaste nummer: %d kolonne: %d ergebniscode: %d benutzerwahl: %d",nummer,kolonne,ergebniscode,benutzerwahl);
         //NSLog(@"MasterErgebnisArray  %@", [MasterErgebnisArray description]);
         //   if ([MasterErgebnisArray objectAtIndex:kolonne])
         
         //NSLog(@"\n\n    reportRadiotaste MasterErgebnisArray zeile: %d kolonne: %d ErgebnisDic: %@",zeile, kolonne, [[MasterErgebnisArray objectAtIndex:nummer]description]);
         //position des Dic fuer tabview nummer im  MasterErgebnisArray an Index klasse
         int nummerpos = [[MasterErgebnisArray valueForKey:@"nummer"]indexOfObject:[NSNumber numberWithInt:nummer]];
         //NSLog(@"MasterErgebnisArray nummerpos: %d",nummerpos);
         
         
         int lsg = [[[MasterErgebnisArray objectAtIndex:nummerpos]objectForKey:@"lsg"]intValue];
         
         //[KontrollFeldA setIntValue:ergebniscode];
         //[KontrollFeldB setIntValue:lsg];
         
         if (lsg == ergebniscode)
         {
            //NSLog(@"ergebniscode: %d ist richtig",ergebniscode);
            [[MasterErgebnisArray objectAtIndex:nummerpos]setObject:[NSNumber numberWithInt:1] forKey:@"richtig"];
            
         }
         else
         {
            if (ergebniscode >= 8000) // weiss nicht
            {
               //NSLog(@"ergebniscode: %d ist weiss nicht",ergebniscode);
               [[MasterErgebnisArray objectAtIndex:nummerpos]setObject:[NSNumber numberWithInt:-1] forKey:@"richtig"];
               ergebniscode = -1;
            }
            else
            {
               [[MasterErgebnisArray objectAtIndex:nummerpos]setObject:[NSNumber numberWithInt:0] forKey:@"richtig"];
               //NSLog(@"ergebniscode: %d ist falsch",ergebniscode);
               
            }
         }
         
         // Wahl des Benutzers. Code der Lösung
         
         [[MasterErgebnisArray objectAtIndex:nummerpos]setObject:[NSNumber numberWithInt:ergebniscode] forKey:@"wahl"];
         
         // text fuer wahl einfuegen
         switch (nummer)
         {
            case 0:
            {
               // ergebniscode ist code des Autors
               //NSLog(@"nummer: %ld wahl: %d",nummer,[[NSNumber numberWithInt:ergebniscode]intValue]);
               long wahlpos = [[FotoArray valueForKey:@"autor"]indexOfObject:[NSNumber numberWithInt:ergebniscode]];
               if (wahlpos < NSNotFound)
               {
                  NSString* wahlautorname = [[FotoArray objectAtIndex:wahlpos]objectForKey:@"name"];
                  //NSLog(@"wahlautorname: %@",wahlautorname);
                  [[MasterErgebnisArray objectAtIndex:nummerpos]setObject:wahlautorname forKey:@"wahltext"];
               }
               else
               {
                  [[MasterErgebnisArray objectAtIndex:nummerpos]setObject:@"*" forKey:@"wahltext"];
               }
               
            }   break;
               
            case 1:
            {
               // ergebniscode ist code des Autors
               //NSLog(@"nummer: %ld wahl: %d",nummer,[[NSNumber numberWithInt:ergebniscode]intValue]);
               long wahlpos = [[FotoArray valueForKey:@"autor"]indexOfObject:[NSNumber numberWithInt:ergebniscode]];
               if (wahlpos < NSNotFound)
               {
                  NSString* wahlautorname = [[FotoArray objectAtIndex:wahlpos]objectForKey:@"name"];
                  //NSLog(@"nummer 1 wahlautorname: %@",wahlautorname);
                  [[MasterErgebnisArray objectAtIndex:nummerpos]setObject:wahlautorname forKey:@"wahltext"];
               }
               else
               {
                  [[MasterErgebnisArray objectAtIndex:nummerpos]setObject:@"*" forKey:@"wahltext"];
               }
               
            }   break;
               
            case 2:
            {
               // ergebniscode ist code der Epoche
               //NSLog(@"nummer: %ld wahl: %d",nummer,[[NSNumber numberWithInt:ergebniscode]intValue]);
               long wahlpos = [[EpochenArray valueForKey:@"epoche"]indexOfObject:[NSNumber numberWithInt:ergebniscode]];
               if (wahlpos < NSNotFound)
               {
                  //NSLog(@"EpochenArray an index %ld: %@",wahlpos,[[EpochenArray objectAtIndex:wahlpos]description])  ;
                  NSString* wahlepochename = [[EpochenArray objectAtIndex:wahlpos]objectForKey:@"name"];
                  //NSLog(@"nummer 1 wahlepochename: %@",wahlepochename);
                  [[MasterErgebnisArray objectAtIndex:nummerpos]setObject:wahlepochename forKey:@"wahltext"];
               }
               else
               {
                  [[MasterErgebnisArray objectAtIndex:nummerpos]setObject:@"*" forKey:@"wahltext"];
               }
            }break;
               
            case 3:// ergebniscode ist code der epoche
            {
               //NSLog(@"nummer: %ld wahl: %d",nummer,[[NSNumber numberWithInt:ergebniscode]intValue]);
               long wahlpos = [[EpochenArray valueForKey:@"epoche"]indexOfObject:[NSNumber numberWithInt:ergebniscode]];
               if (wahlpos < NSNotFound)
               {
                  //NSLog(@"EpochenArray an index %ld: %@",wahlpos,[[EpochenArray objectAtIndex:wahlpos]description])  ;
                  NSString* wahlepochename = [[EpochenArray objectAtIndex:wahlpos]objectForKey:@"name"];
                  //NSLog(@"nummer 1 wahlepochename: %@",wahlepochename);
                  [[MasterErgebnisArray objectAtIndex:nummerpos]setObject:wahlepochename forKey:@"wahltext"];
               }
               else
               {
                  [[MasterErgebnisArray objectAtIndex:nummerpos]setObject:@"*" forKey:@"wahltext"];
               }
               
            }break;
               
            case 4:// ergebniscode ist code der epoche
            {
               //NSLog(@"nummer: %ld wahl: %d",nummer,[[NSNumber numberWithInt:ergebniscode]intValue]);
               long wahlpos = [[EpochenArray valueForKey:@"epoche"]indexOfObject:[NSNumber numberWithInt:ergebniscode]];
               if (wahlpos < NSNotFound)
               {
                  //NSLog(@"EpochenArray an index %ld: %@",wahlpos,[[EpochenArray objectAtIndex:wahlpos]description])  ;
                  NSString* wahlepochename = [[EpochenArray objectAtIndex:wahlpos]objectForKey:@"name"];
                  //NSLog(@"nummer 1 wahlepochename: %@",wahlepochename);
                  [[MasterErgebnisArray objectAtIndex:nummerpos]setObject:wahlepochename forKey:@"wahltext"];
               }
               else
               {
                  [[MasterErgebnisArray objectAtIndex:nummerpos]setObject:@"*" forKey:@"wahltext"];
               }
               
            }break;
               
            case 5:// ergebniscode ist code der epoche
            {
               //NSLog(@"nummer: %ld wahl: %d",nummer,[[NSNumber numberWithInt:ergebniscode]intValue]);
               long wahlpos = [[EpochenArray valueForKey:@"epoche"]indexOfObject:[NSNumber numberWithInt:ergebniscode]];
               if (wahlpos < NSNotFound)
               {
                  //NSLog(@"EpochenArray an index %ld: %@",wahlpos,[[EpochenArray objectAtIndex:wahlpos]description])  ;
                  NSString* wahlepochename = [[EpochenArray objectAtIndex:wahlpos]objectForKey:@"name"];
                  //NSLog(@"nummer 1 wahlepochename: %@",wahlepochename);
                  //NSLog(@"MasterErgebnisArray an index %ld: %@",nummerpos,[[MasterErgebnisArray objectAtIndex:nummerpos]description])  ;
                  [[MasterErgebnisArray objectAtIndex:nummerpos]setObject:wahlepochename forKey:@"wahltext"];
                  
               }
               else
               {
                  [[MasterErgebnisArray objectAtIndex:nummerpos]setObject:@"*" forKey:@"wahltext"];
               }
               
            }break;
               
               
            default:
               break;
         }
         
         
         
         // Wahl des Benutzers. Position der geklickten Taste
         [[MasterErgebnisArray objectAtIndex:nummerpos]setObject:[NSNumber numberWithInt:kolonne] forKey:@"wahlpos"];
         //[[MasterErgebnisArray objectAtIndex:nummerpos]setObject:[NSNumber numberWithInt:(lsg == ergebniscode)] forKey:@"richtig"];
         
         
         //NSLog(@"MasterErgebnisArray pos: %d  nach Taste: %@",nummerpos,[[MasterErgebnisArray objectAtIndex:nummerpos] description]);
         [MasterErgebnistabelle reloadData];
         
      }break;
         
      case 2:
      {
         int zeile =[sender selectedRow];
         int kolonne = [sender selectedColumn];
         int ergebniscode = [sender ergebniscodeInZeile:zeile inKolonne:kolonne];
         int benutzerwahl = [[[MasterErgebnisArray objectAtIndex:nummer]objectForKey:@"wahl"]intValue];
         //NSLog(@"reportRadiotaste nummer: %d kolonne: %d ergebniscode: %d benutzerwahl: %d",nummer,kolonne,ergebniscode,benutzerwahl);
         //NSLog(@"MasterErgebnisArray  %@", [MasterErgebnisArray description]);
         //   if ([MasterErgebnisArray objectAtIndex:kolonne])
         
         //NSLog(@"\n\n    reportRadiotaste MasterErgebnisArray zeile: %d kolonne: %d ErgebnisDic: %@",zeile, kolonne, [[MasterErgebnisArray objectAtIndex:nummer]description]);
         //position des Dic fuer tabview nummer im  MasterErgebnisArray an Index klasse
         int nummerpos = [[MasterErgebnisArray valueForKey:@"nummer"]indexOfObject:[NSNumber numberWithInt:nummer]];
         //NSLog(@"MasterErgebnisArray nummerpos: %d",nummerpos);
         
         
         int lsg = [[[MasterErgebnisArray objectAtIndex:nummerpos]objectForKey:@"lsg"]intValue];
 
         //[KontrollFeldA setIntValue:ergebniscode];
         //[KontrollFeldB setIntValue:lsg];
         
         if (lsg == ergebniscode)
         {
            //NSLog(@"ergebniscode: %d ist richtig",ergebniscode);
            [[MasterErgebnisArray objectAtIndex:nummerpos]setObject:[NSNumber numberWithInt:1] forKey:@"richtig"];
         
         }
         else 
         {
            if (ergebniscode >= 8000) // weiss nicht
            {
               //NSLog(@"ergebniscode: %d ist weiss nicht",ergebniscode);
               [[MasterErgebnisArray objectAtIndex:nummerpos]setObject:[NSNumber numberWithInt:-1] forKey:@"richtig"];
               ergebniscode = -1;
            }
            else
            {
               [[MasterErgebnisArray objectAtIndex:nummerpos]setObject:[NSNumber numberWithInt:0] forKey:@"richtig"];
               //NSLog(@"ergebniscode: %d ist falsch",ergebniscode);
              
            }
         }
         
         // Wahl des Benutzers. Code der Lösung
         
         [[MasterErgebnisArray objectAtIndex:nummerpos]setObject:[NSNumber numberWithInt:ergebniscode] forKey:@"wahl"];
         
         // text fuer wahl einfuegen
         switch (nummer)
         {
            case 0:
            {
               // ergebniscode ist code des Autors
               //NSLog(@"nummer: %ld wahl: %d",nummer,[[NSNumber numberWithInt:ergebniscode]intValue]);
               long wahlpos = [[FotoArray valueForKey:@"autor"]indexOfObject:[NSNumber numberWithInt:ergebniscode]];
            if (wahlpos < NSNotFound)
            {
               NSString* wahlautorname = [[FotoArray objectAtIndex:wahlpos]objectForKey:@"name"];
               //NSLog(@"wahlautorname: %@",wahlautorname);
               [[MasterErgebnisArray objectAtIndex:nummerpos]setObject:wahlautorname forKey:@"wahltext"];
            }
               else
               {
                  [[MasterErgebnisArray objectAtIndex:nummerpos]setObject:@"*" forKey:@"wahltext"];
               }
            
            }   break;
               
            case 1:
            {
               // ergebniscode ist code des Autors
               //NSLog(@"nummer: %ld wahl: %d",nummer,[[NSNumber numberWithInt:ergebniscode]intValue]);
               long wahlpos = [[FotoArray valueForKey:@"autor"]indexOfObject:[NSNumber numberWithInt:ergebniscode]];
               if (wahlpos < NSNotFound)
               {
                  NSString* wahlautorname = [[FotoArray objectAtIndex:wahlpos]objectForKey:@"name"];
                  //NSLog(@"nummer 1 wahlautorname: %@",wahlautorname);
                  [[MasterErgebnisArray objectAtIndex:nummerpos]setObject:wahlautorname forKey:@"wahltext"];
               }
               else
               {
                  [[MasterErgebnisArray objectAtIndex:nummerpos]setObject:@"*" forKey:@"wahltext"];
               }
               
            }   break;
               
            case 2:
            {
               // ergebniscode ist code der Epoche
               //NSLog(@"nummer: %ld wahl: %d",nummer,[[NSNumber numberWithInt:ergebniscode]intValue]);
               long wahlpos = [[EpochenArray valueForKey:@"epoche"]indexOfObject:[NSNumber numberWithInt:ergebniscode]];
               if (wahlpos < NSNotFound)
               {
                  //NSLog(@"EpochenArray an index %ld: %@",wahlpos,[[EpochenArray objectAtIndex:wahlpos]description])  ;
                  NSString* wahlepochename = [[EpochenArray objectAtIndex:wahlpos]objectForKey:@"name"];
                  //NSLog(@"nummer 1 wahlepochename: %@",wahlepochename);
                  [[MasterErgebnisArray objectAtIndex:nummerpos]setObject:wahlepochename forKey:@"wahltext"];
               }
               else
               {
                  [[MasterErgebnisArray objectAtIndex:nummerpos]setObject:@"*" forKey:@"wahltext"];
               }
            }break;
            
            case 3:// ergebniscode ist code der epoche
            {
               //NSLog(@"nummer: %ld wahl: %d",nummer,[[NSNumber numberWithInt:ergebniscode]intValue]);
               long wahlpos = [[EpochenArray valueForKey:@"epoche"]indexOfObject:[NSNumber numberWithInt:ergebniscode]];
               if (wahlpos < NSNotFound)
               {
                  //NSLog(@"EpochenArray an index %ld: %@",wahlpos,[[EpochenArray objectAtIndex:wahlpos]description])  ;
                  NSString* wahlepochename = [[EpochenArray objectAtIndex:wahlpos]objectForKey:@"name"];
                  //NSLog(@"nummer 1 wahlepochename: %@",wahlepochename);
                  [[MasterErgebnisArray objectAtIndex:nummerpos]setObject:wahlepochename forKey:@"wahltext"];
               }
               else
               {
                  [[MasterErgebnisArray objectAtIndex:nummerpos]setObject:@"*" forKey:@"wahltext"];
               }
              
            }break;
               
            case 4:// ergebniscode ist code der epoche
            {
               //NSLog(@"nummer: %ld wahl: %d",nummer,[[NSNumber numberWithInt:ergebniscode]intValue]);
               long wahlpos = [[EpochenArray valueForKey:@"epoche"]indexOfObject:[NSNumber numberWithInt:ergebniscode]];
               if (wahlpos < NSNotFound)
               {
                  //NSLog(@"EpochenArray an index %ld: %@",wahlpos,[[EpochenArray objectAtIndex:wahlpos]description])  ;
                  NSString* wahlepochename = [[EpochenArray objectAtIndex:wahlpos]objectForKey:@"name"];
                  //NSLog(@"nummer 1 wahlepochename: %@",wahlepochename);
                  [[MasterErgebnisArray objectAtIndex:nummerpos]setObject:wahlepochename forKey:@"wahltext"];
               }
               else
               {
                  [[MasterErgebnisArray objectAtIndex:nummerpos]setObject:@"*" forKey:@"wahltext"];
               }

            }break;
               
            case 5:// ergebniscode ist code der epoche
            {
               //NSLog(@"nummer: %ld wahl: %d",nummer,[[NSNumber numberWithInt:ergebniscode]intValue]);
               long wahlpos = [[EpochenArray valueForKey:@"epoche"]indexOfObject:[NSNumber numberWithInt:ergebniscode]];
               if (wahlpos < NSNotFound)
               {
                  //NSLog(@"EpochenArray an index %ld: %@",wahlpos,[[EpochenArray objectAtIndex:wahlpos]description])  ;
                  NSString* wahlepochename = [[EpochenArray objectAtIndex:wahlpos]objectForKey:@"name"];
                  //NSLog(@"nummer 1 wahlepochename: %@",wahlepochename);
                  //NSLog(@"MasterErgebnisArray an index %ld: %@",nummerpos,[[MasterErgebnisArray objectAtIndex:nummerpos]description])  ;
                  [[MasterErgebnisArray objectAtIndex:nummerpos]setObject:wahlepochename forKey:@"wahltext"];
                  
               }
               else
               {
                  [[MasterErgebnisArray objectAtIndex:nummerpos]setObject:@"*" forKey:@"wahltext"];
               }
              
            }break;
               
            
            default:
               break;
         }
         
         
         
         // Wahl des Benutzers. Position der geklickten Taste
         [[MasterErgebnisArray objectAtIndex:nummerpos]setObject:[NSNumber numberWithInt:kolonne] forKey:@"wahlpos"];
         //[[MasterErgebnisArray objectAtIndex:nummerpos]setObject:[NSNumber numberWithInt:(lsg == ergebniscode)] forKey:@"richtig"];
         
         
         //NSLog(@"MasterErgebnisArray pos: %d  nach Taste: %@",nummerpos,[[MasterErgebnisArray objectAtIndex:nummerpos] description]);
         [MasterErgebnistabelle reloadData];
         
      }break;
 
   }
}

- (NSArray*)arrayVonIndexSet:(NSIndexSet*)indexset
{
   NSMutableArray* tempArray = [[NSMutableArray alloc]initWithCapacity:0];
   
   int pos=0;
   int tempindex=[indexset firstIndex];
   while(tempindex != NSNotFound  && pos < 4) // nicht mehr als 4 indexes
   {
      [tempArray addObject:[NSNumber numberWithInt:tempindex]];
      tempindex=[indexset indexGreaterThanIndex: tempindex];
      pos++;
   }
   return (NSArray*)tempArray;
}


- (NSMutableIndexSet*)indexSetVonArray:(NSArray*)indexarray
{
   NSMutableIndexSet* tempset = [NSMutableIndexSet indexSet];
   for (int i=0;i<[indexarray count];i++)
   {
      [tempset addIndex:[[indexarray objectAtIndex:i]intValue]];
   }
   return tempset;
}

- (IBAction)resetDefaults:(id)sender
{
   NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
   NSDictionary * dict = [defs dictionaryRepresentation];
   for (id key in dict)
   {
      NSLog(@"key: %@",key);
      if ([key isEqual:@"defaultarray"])
      {
         NSLog(@"kill key: %@",key);
         [defs removeObjectForKey:key];}
      }
   [defs synchronize];
}

- (int)readData
{
   //NSLog(@"readData start");
   
   NSMutableArray* ResourceKlassenArray = [[NSMutableArray alloc]initWithCapacity:0];
   NSString* ResourcenPfad=[[[NSBundle mainBundle]bundlePath]stringByAppendingPathComponent:@"Contents/Resources"];
   NSFileManager *Filemanager=[NSFileManager defaultManager];

   NSString* dataPfad = [ResourcenPfad stringByAppendingPathComponent:@"quizsettings"];
   if ([Filemanager fileExistsAtPath:dataPfad isDirectory:NO])
   {
      //NSLog(@"quizsettings da: dataPfad: %@",dataPfad);
      
      NSData *data = [[NSMutableData alloc]initWithContentsOfFile:dataPfad];
      NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
      
      NSMutableDictionary* settingsdataDic=[[NSMutableDictionary alloc]initWithCapacity:0];
      settingsdataDic = [unarchiver decodeObjectForKey: @"plist"];
      [unarchiver finishDecoding];
      //NSLog(@"readData settingsdataDic da");
      //NSLog(@"readData settingsdataDic: %@",[settingsdataDic description]);
      if ([settingsdataDic objectForKey:@"klassenarray"])
      {
         //NSLog(@"Klassenarray da: %@",[[settingsdataDic objectForKey:@"klassenarray"] description]);
        // NSLog(@"readData frage: %@",[[[settingsdataDic objectForKey:@"klassenarray"]valueForKey:@"frage"] description]);
        // NSLog(@"readData musikindex: %@",[[[settingsdataDic objectForKey:@"klassenarray"]valueForKey:@"musikindex"] description]);
        // NSLog(@"readData fotoindex: %@",[[[settingsdataDic objectForKey:@"klassenarray"]valueForKey:@"fotoindex"] description]);
        // NSLog(@"readData notenindex: %@",[[[settingsdataDic objectForKey:@"klassenarray"]valueForKey:@"notenindex"] description]);
        // NSLog(@"readData epochenindex: %@",[[[settingsdataDic objectForKey:@"klassenarray"]valueForKey:@"epochenindex"] description]);

         
      ResourceKlassenArray = [NSMutableArray arrayWithArray:[settingsdataDic objectForKey:@"klassenarray"]];
      //
      }
      else
      {
         //NSLog(@"quizsettings leer");
      }
   } // settings
   else
   {
      NSLog(@"quizsettings nicht da");
   }
   
   int erfolg = 0;
   // start
      
      // IndexArray einrichten. Array fuer jede Klasse mit Array fuer jede Nummer
      NSMutableArray* tempKlassenArray = [[NSMutableArray alloc]initWithCapacity:0];
      
      
      int klassenindex=0;
      int nummerindex=0;
      for (klassenindex=0;klassenindex<[KlasseTab numberOfTabViewItems]; klassenindex++)
      {
         //NSLog(@"klasse: %d data: %@",klassenindex, [[ResourceKlassenArray objectAtIndex:klassenindex]description] );
          // tabs der nummer abfragen
         
         NSMutableArray* tempNummerArray = [[NSMutableArray alloc]initWithCapacity:0];
         
         NSMutableDictionary* tempResourceNummerDic = [[NSMutableDictionary alloc]initWithCapacity:0];
         NSMutableArray* tempResourceNummerArray = [[NSMutableArray alloc]initWithCapacity:0];
         
         //for (nummerindex=0; nummerindex<[NummerTab numberOfTabViewItems]; nummerindex++)
         for (nummerindex=0; nummerindex<6; nummerindex++)
         {
            //NSLog(@"nummerindex: %d ResourceKlassenArray: %@",nummerindex,[ResourceKlassenArray description]);
            if (ResourceKlassenArray &&[ResourceKlassenArray count] )
            {
            if (ResourceKlassenArray &&[[ResourceKlassenArray objectAtIndex:klassenindex]count] )
            {
               NSMutableArray* tempzeilenarray = [NSMutableArray arrayWithArray:[ResourceKlassenArray objectAtIndex:klassenindex]];
               
                 tempResourceNummerDic = (NSMutableDictionary*)[tempzeilenarray objectAtIndex:nummerindex];
                 //NSLog(@"nummer: %d tempResourceNummerArray: %@",nummerindex, [tempResourceNummerArray description] );
               
             }
            }
            
            //NSLog(@"klassenindex: %d nummerindex: %d",klassenindex,nummerindex);
            //Dic fuer 'nummer'
            NSMutableDictionary* tempNummerDic = [[NSMutableDictionary alloc]initWithCapacity:0];
            
            switch (klassenindex)
            {
                  case 1:
                  {
                     NSMutableIndexSet* epochenindex = [NSMutableIndexSet indexSet];
                     NSMutableIndexSet* notenindex = [NSMutableIndexSet indexSet];
                     NSMutableIndexSet* fotoindex = [NSMutableIndexSet indexSet];
                     NSMutableIndexSet* musikindex = [NSMutableIndexSet indexSet];
                     
                     if ([tempResourceNummerDic objectForKey:@"epochenindex"])
                     {
                        [epochenindex addIndexes:[tempResourceNummerDic objectForKey:@"epochenindex"]];
                     }
                     if ([tempResourceNummerDic objectForKey:@"notenindex"])
                     {
                        [notenindex addIndexes:[tempResourceNummerDic objectForKey:@"notenindex"]];
                     }
                     if ([tempResourceNummerDic objectForKey:@"fotoindex"])
                     {
                        [fotoindex addIndexes:[tempResourceNummerDic objectForKey:@"fotoindex"]];
                     }
                     
                     if ([tempResourceNummerDic objectForKey:@"musikindex"])
                     {
                        [musikindex addIndexes:[tempResourceNummerDic objectForKey:@"musikindex"]];
                     }
                     
                     switch (nummerindex)
                     {
                        case 0:
                        {
                           // Autoren waehlen
                           if ([fotoindex count]==0)
                           {
                              [fotoindex addIndex:MOZART];
                           }
                           
                           // Noten
                           if ([notenindex count]==0)
                           {
                              [notenindex addIndex:MOZART];
                              [notenindex addIndex:SCHUETZ];
                           }
                           
                           // Musik
                           if ([musikindex count]==0)
                           {
                              [musikindex addIndex:MOZART];
                              [musikindex addIndex:SCHUETZ];
                           }
                           
                           // Epoche
                           if ([epochenindex count]==0)
                           {
                              [epochenindex addIndex:ROMANTIK];
                           }
                           else
                           {
                              //NSLog(@"epochenindex schon da: %@",[epochenindex description]);
                           }
                        }break;
                           
                        case 1:
                        {
                           // Autoren waehlen
                           if ([fotoindex count]==0)
                           {
                              [fotoindex addIndex:VIKTORIA];
                              [fotoindex addIndex:BRITTEN];
                              
                              // Defaults einsetzen
                           }
                           
                           
                           // Noten
                           if ([notenindex count]==0)
                           {
                              [notenindex addIndex:VIKTORIA];
                              
                           }
                           
                           // Musik
                           if ([musikindex count]==0)
                           {
                              [musikindex addIndex:VIKTORIA];
                              
                           }
                           
                           // Epoche
                           if ([epochenindex count]==0)
                           {
                              [epochenindex addIndex:BAROCK];
                              //[epochenindex addIndex:KLASSIK];
                              
                           }
                           
                        }break;
                           
                        case 2: // Welches dieser Stücke ist früher komponiert worden?
                        {
                           // Autoren waehlen
                           if ([fotoindex count]==0)
                           {
                              [fotoindex addIndex:HAYDN];
                              [fotoindex addIndex:ISERLOHN];
                              // Defaults einsetzen
                              
                           }
                           
                           
                           // Noten
                           if ([notenindex count]==0)
                           {
                              [notenindex addIndex:ISERLOHN];
                              [notenindex addIndex:HAYDN];
                              // Defaults einsetzen
                              
                           }
                           
                           // Musik
                           if ([musikindex count]==0)
                           {
                              [musikindex addIndex:ISERLOHN];
                              [musikindex addIndex:HAYDN];
                              // Defaults einsetzen
                              
                           }
                           
                           // Epoche
                           if ([epochenindex count]==0)
                           {
                              [epochenindex addIndex:MODERNE];
                              
                           }
                           
                        }break;
                           
                        case 3: //Welcher diese rKomponisten lebte naeher zu unserer Zeit?
                        {
                           // Autoren waehlen
                           if ([fotoindex count]==0)
                           {
                              [fotoindex addIndex:RHEINBERGER];
                              [fotoindex addIndex:ZELENKA];
                              // Defaults einsetzen
                              
                           }
                           
                           // Noten
                           if ([notenindex count]==0)
                           {
                              [notenindex addIndex:RHEINBERGER];
                              [notenindex addIndex:ZELENKA];
                              // Defaults einsetzen
                              
                           }
                           
                           // Musik
                           if ([musikindex count]==0)
                           {
                              [musikindex addIndex:RHEINBERGER];
                              [musikindex addIndex:ZELENKA];
                              // Defaults einsetzen
                              
                           }
                           
                           // Epoche
                           if ([epochenindex count]==0)
                           {
                              //[epochenindex addIndex:RENAISSANCE];
                              [epochenindex addIndex:KLASSIK];
                              
                           }
                           
                           
                           
                        }break;
                           
                           
                        case 4: // In welcher Epoche lebte dieser Komponist?
                        {
                           // Autoren waehlen
                           if ([fotoindex count]==0)
                           {
                              [fotoindex addIndex:RUTTER];
                              // Defaults einsetzen
                              
                           }
                           
                           // Noten
                           if ([notenindex count]==0)
                           {
                              [notenindex addIndex:RUTTER];
                              // Defaults einsetzen
                              
                           }
                           
                           // Musik
                           if ([musikindex count]==0)
                           {
                              [musikindex addIndex:RUTTER];
                              // Defaults einsetzen
                           }
                           
                           // Epoche
                           if ([epochenindex count]==0)
                           {
                              [epochenindex addIndex:RENAISSANCE];
                              [epochenindex addIndex:MODERNE];
                              
                           }
                           
                           
                           
                        }break;
                           
                        case 5: // Welches Stück wurde in dieser Epoche komponiert?
                        {
                           // Autoren waehlen
                           if ([fotoindex count]==0)
                           {
                              [fotoindex addIndex:BACH];
                              [fotoindex addIndex:RUTTER];
                              // Defaults einsetzen
                              
                           }
                           
                           // Noten
                           if ([notenindex count]==0)
                           {
                              [notenindex addIndex:BACH];
                              [notenindex addIndex:RUTTER];
                              // Defaults einsetzen
                              
                           }
                           
                           // Musik
                           if ([musikindex count]==0)
                           {
                              [musikindex addIndex:BACH];
                              [musikindex addIndex:RUTTER];
                              // Defaults einsetzen
                              
                           }
                           
                           // Epoche
                           if ([epochenindex count]==0)
                           {
                              [epochenindex addIndex:MODERNE];
                              
                           }
                           
                           
                        }break;
                           
                     }// switch nummerindex
                     
                     //NSLog(@"nummerindex: %ld fotoindex fix: %@",nummerindex,[fotoindex description]);
                     
                     //Dic fuer 'nummer'
                     //                 NSMutableDictionary* tempNummerDic = [[NSMutableDictionary alloc]initWithCapacity:0];
                     
                     //        [tempNummerDic setObject:[FragenArray objectAtIndex:nummerindex] forKey:@"frage1"];
                     //NSLog(@"[FragenArray objectAtIndex:nummerindex objectForKey:frage: %@",[[FragenArray objectAtIndex:nummerindex]objectForKey:@"frage"]);
                     [tempNummerDic setObject:[[FragenArray objectAtIndex:nummerindex]objectForKey:@"frage"]forKey:@"frage"];
                     
                     [tempNummerDic setObject:[NSNumber numberWithInt:nummerindex] forKey:@"nummer"];
                     [tempNummerDic setObject:[NSNumber numberWithInt:klassenindex] forKey:@"klasse"];
                     [tempNummerDic setObject:fotoindex forKey:@"fotoindex"];
                     [tempNummerDic setObject:notenindex forKey:@"notenindex"];
                     [tempNummerDic setObject:musikindex forKey:@"musikindex"];
                     [tempNummerDic setObject:epochenindex forKey:@"epochenindex"];
                     //NSLog(@"\n*** nummerindex: %d tempNummerDic: %@\n*\n*",nummerindex,[tempNummerDic description]);
                     [tempNummerArray addObject:tempNummerDic];
                     
                     
                     //NSLog(@"nummer: %d tempNummerArray: %@",nummerindex,[tempNummerArray description]);
                     
                  }break; // case 2
                     
                     
               case 2:
               {
                  NSMutableIndexSet* epochenindex = [NSMutableIndexSet indexSet];
                  NSMutableIndexSet* notenindex = [NSMutableIndexSet indexSet];
                  NSMutableIndexSet* fotoindex = [NSMutableIndexSet indexSet];
                  NSMutableIndexSet* musikindex = [NSMutableIndexSet indexSet];
                  
                if ([tempResourceNummerDic objectForKey:@"epochenindex"])
                {
                   [epochenindex addIndexes:[tempResourceNummerDic objectForKey:@"epochenindex"]];
                }
                  if ([tempResourceNummerDic objectForKey:@"notenindex"])
                  {
                     [notenindex addIndexes:[tempResourceNummerDic objectForKey:@"notenindex"]];
                  }
                  if ([tempResourceNummerDic objectForKey:@"fotoindex"])
                  {
                     [fotoindex addIndexes:[tempResourceNummerDic objectForKey:@"fotoindex"]];
                  }
                  
                  if ([tempResourceNummerDic objectForKey:@"musikindex"])
                  {
                     [musikindex addIndexes:[tempResourceNummerDic objectForKey:@"musikindex"]];
                  }
                      
                     switch (nummerindex)
                     {
                        case 0:
                        {
                           // Autoren waehlen
                           if ([fotoindex count]==0)
                           {
                              //[fotoindex addIndex:PAGANINI];
                              //[fotoindex addIndex:BACH];
                              [fotoindex addIndex:SCHUETZ];

                           }
                           
                           // Noten
                           if ([notenindex count]==0)
                           {
                              [notenindex addIndex:BACH];
                              //[notenindex addIndex:SCHUBERT];
                              //[notenindex addIndex:PAGANINI];
                              [notenindex addIndex:SCHUETZ];
                              
                           }
                           
                           // Musik
                           if ([musikindex count]==0)
                           {
                              [musikindex addIndex:BACH];
                              //[musikindex addIndex:SCHUBERT];
                              //[musikindex addIndex:PAGANINI];
                              [musikindex addIndex:SCHUETZ];

                              
                           }
                           
                           // Epoche
                           if ([epochenindex count]==0)
                           {
                              //[epochenindex addIndex:ROMANTIK];
                              [epochenindex addIndex:BAROCK];

                           }
                           else
                           {
                              //NSLog(@"epochenindex schon da: %@",[epochenindex description]);
                           }
                        }break;
                           
                        case 1:
                        {
                           // Autoren waehlen
                           if ([fotoindex count]==0)
                           {
                              [fotoindex addIndex:HAYDN];
                              [fotoindex addIndex:BACH];
                              
                              // Defaults einsetzen
                           }
                           
                           
                           // Noten
                           if ([notenindex count]==0)
                           {
                              //[notenindex addIndex:BACH];
                              [notenindex addIndex:HAYDN];
                                                            
                           }
                           
                           // Musik
                           if ([musikindex count]==0)
                           {
                              //[musikindex addIndex:BACH];
                              [musikindex addIndex:HAYDN];
                                                            
                           }
                           
                           // Epoche
                           if ([epochenindex count]==0)
                           {
                              [epochenindex addIndex:BAROCK];
                              //[epochenindex addIndex:KLASSIK];
                              
                           }
                           
                        }break;
                           
                        case 2: // Welches dieser Stücke ist früher komponiert worden?
                        {
                           // Autoren waehlen
                           if ([fotoindex count]==0)
                           {
                              [fotoindex addIndex:HAYDN];
                              [fotoindex addIndex:VIKTORIA];
                              // Defaults einsetzen
                              
                           }
                           
                           
                           // Noten
                           if ([notenindex count]==0)
                           {
                              [notenindex addIndex:VIKTORIA];
                              [notenindex addIndex:HAYDN];
                              // Defaults einsetzen
                              
                           }
                           
                           // Musik
                           if ([musikindex count]==0)
                           {
                              [musikindex addIndex:VIKTORIA];
                              [musikindex addIndex:HAYDN];
                              // Defaults einsetzen
                              
                           }
                           
                           // Epoche
                           if ([epochenindex count]==0)
                           {
                              //[epochenindex addIndex:BAROCK];
                              [epochenindex addIndex:RENAISSANCE];
                              
                           }
                           
                        }break;
                           
                        case 3: // 
                        {
                           // Autoren waehlen
                           if ([fotoindex count]==0)
                           {
                              [fotoindex addIndex:BACH];
                              [fotoindex addIndex:VIKTORIA];
                              // Defaults einsetzen
                              
                           }
                           
                           // Noten
                           if ([notenindex count]==0)
                           {
                              [notenindex addIndex:BACH];
                              [notenindex addIndex:VIKTORIA];
                              // Defaults einsetzen
                              
                           }
                           
                           // Musik
                           if ([musikindex count]==0)
                           {
                              [musikindex addIndex:BACH];
                              [musikindex addIndex:VIKTORIA];
                              // Defaults einsetzen
                              
                           }
                           
                           // Epoche
                           if ([epochenindex count]==0)
                           {
                              [epochenindex addIndex:RENAISSANCE];
                              //[epochenindex addIndex:KLASSIK];
                               
                           }
                           
                           
                           
                        }break;
                           
                           
                        case 4:
                        {
                           // Autoren waehlen
                           if ([fotoindex count]==0)
                           {
                              //[fotoindex addIndex:BACH];
                              [fotoindex addIndex:HAYDN];
                              // Defaults einsetzen
                              
                           }
                           
                           // Noten
                           if ([notenindex count]==0)
                           {
                              //[notenindex addIndex:BACH];
                              [notenindex addIndex:HAYDN];
                              // Defaults einsetzen
                              
                           }
                           
                           // Musik
                           if ([musikindex count]==0)
                           {
                              // [musikindex addIndex:BACH];
                              [musikindex addIndex:HAYDN];
                              // Defaults einsetzen
                           }
                           
                           // Epoche
                           if ([epochenindex count]==0)
                           {
                              [epochenindex addIndex:RENAISSANCE];
                              [epochenindex addIndex:KLASSIK];
                              
                           }
                           
                           
                           
                        }break;
                           
                        case 5:
                        {
                           // Autoren waehlen
                           if ([fotoindex count]==0)
                           {
                              [fotoindex addIndex:BACH];
                              [fotoindex addIndex:HAYDN];
                              // Defaults einsetzen
                              
                           }
                           
                           // Noten
                           if ([notenindex count]==0)
                           {
                              [notenindex addIndex:BACH];
                              [notenindex addIndex:HAYDN];
                              // Defaults einsetzen
                              
                           }
                           
                           // Musik
                           if ([musikindex count]==0)
                           {
                              [musikindex addIndex:BACH];
                              [musikindex addIndex:HAYDN];
                              // Defaults einsetzen
                               
                           }
                           
                           // Epoche
                           if ([epochenindex count]==0)
                           {
                              //[epochenindex addIndex:KLASSIK];
                              [epochenindex addIndex:KLASSIK];
                              
                           }
                           
                           
                        }break;
                           
                     }// switch nummerindex
                  
                  //NSLog(@"nummerindex: %ld fotoindex fix: %@",nummerindex,[fotoindex description]);
                  
                  //Dic fuer 'nummer'
                  //                 NSMutableDictionary* tempNummerDic = [[NSMutableDictionary alloc]initWithCapacity:0];
                  
                  //        [tempNummerDic setObject:[FragenArray objectAtIndex:nummerindex] forKey:@"frage1"];
                  //NSLog(@"[FragenArray objectAtIndex:nummerindex objectForKey:frage: %@",[[FragenArray objectAtIndex:nummerindex]objectForKey:@"frage"]);
                  [tempNummerDic setObject:[[FragenArray objectAtIndex:nummerindex]objectForKey:@"frage"]forKey:@"frage"];
                  
                  [tempNummerDic setObject:[NSNumber numberWithInt:nummerindex] forKey:@"nummer"];
                  [tempNummerDic setObject:[NSNumber numberWithInt:klassenindex] forKey:@"klasse"];
                  [tempNummerDic setObject:fotoindex forKey:@"fotoindex"];
                  [tempNummerDic setObject:notenindex forKey:@"notenindex"];
                  [tempNummerDic setObject:musikindex forKey:@"musikindex"];
                  [tempNummerDic setObject:epochenindex forKey:@"epochenindex"];
                  //NSLog(@"\n*** nummerindex: %d tempNummerDic: %@\n*\n*",nummerindex,[tempNummerDic description]);
                  [tempNummerArray addObject:tempNummerDic];
                  
                  
                  //NSLog(@"nummer: %d tempNummerArray: %@",nummerindex,[tempNummerArray description]);
                  
               }break; // case 2
                  
            
            }// switch klassenindex
            
         } // for nummerindex
         
         [tempKlassenArray addObject: tempNummerArray];
         //NSLog(@"*** klassenindex: %d tempNummerDefaultArray: %@\n*\n*",klassenindex,[tempNummerDefaultArray description]);
         
         
      } // for klassenindex
      
      
      //NSLog(@"*** tempKlassenArray komplett: %@\n*\n*",[tempKlassenArray description]);
      
      
      
      [PList setObject:tempKlassenArray forKey:@"klassenarray"];
   
   //NSLog(@"readData end");
   
   return 0;
   
   
   
   
   
   
   
   // we need to get the plist data...
   NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"plist"];
   NSLog(@"plistPath: %@",plistPath);
   NSFileManager* nc = [NSFileManager defaultManager];
   //   NSMutableArray *dataArray = [[NSMutableArray alloc] initWithCapacity:0];
   if ([nc fileExistsAtPath:plistPath])
   {
      NSMutableDictionary* plist = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
      if ([plist count])
      {
         NSLog(@"PList schon vorhanden: %@",[plist description]);
//         [PList setDictionary: [NSMutableDictionary dictionaryWithContentsOfFile:plistPath]];
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

- (int)readPList
{
   NSLog(@"readPList start");
   NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];
   NSLog(@"readPList NSUserDefaults: %@",[[ud objectForKey:@"defaultarray"]description]);
   
   int erfolg = 0;
   { // start
      
      // IndexArray einrichten. Array fuer jede Klasse mit Array fuer jede Nummer
      NSMutableArray* tempKlassenArray = [[NSMutableArray alloc]initWithCapacity:0];
      
      if (ud && [ud arrayForKey:@"defaultarray"])
      {
         DefaultArray = [NSMutableArray arrayWithArray:[ud arrayForKey:@"defaultarray"]];
         NSLog(@"readPList DefaultArray da: %@",[DefaultArray description]);
      }
      
      int klassenindex=0;
      int nummerindex=0;
      for (klassenindex=0;klassenindex<[KlasseTab numberOfTabViewItems]; klassenindex++)
      {
         
         //[tempNummerDic setObject:FragenArray forKey:@"fragenarray"];
         NSMutableArray* tempNummerDefaultArray = [NSMutableArray array];
         if ([[ud arrayForKey:@"defaultarray"]count] && [[ud arrayForKey:@"defaultarray"]objectAtIndex:klassenindex])
         
         //if (DefaultArray && [DefaultArray count] && [DefaultArray objectAtIndex:klassenindex]) // array in ud vorh.
         {
            tempNummerDefaultArray = [NSArray arrayWithArray:[[ud arrayForKey:@"defaultarray"]objectAtIndex:klassenindex]];
            //erfolg = 1;
            NSLog(@"ud vorhanden klassenindex: %d ", klassenindex);
         }
         else // Array mit Dic fuer jeden nummerindex fuellen
         {
            NSLog(@"Dics einfuellen klassenindex: %d ",klassenindex);
            tempNummerDefaultArray = [[NSMutableArray alloc]initWithCapacity:0];
            for (int i=0;i<[NummerTab numberOfTabViewItems];i++)
            {
               NSMutableDictionary*tempNummerDefaultDic = [[NSMutableDictionary alloc]initWithCapacity:0];
               [tempNummerDefaultDic setObject:[NSNumber numberWithInt:i] forKey:@"nummer"];
               [tempNummerDefaultDic setObject:[NSNumber numberWithInt:klassenindex] forKey:@"klasse"];
               //NSLog(@"tempNummerDefaultArray i %d Dic: %@",nummerindex,[tempNummerDefaultDic description]);
               [tempNummerDefaultArray addObject:tempNummerDefaultDic];

            }
         }
         // tabs der nummer abfragen
         NSMutableArray* tempNummerArray = [[NSMutableArray alloc]initWithCapacity:0];
         
         for (nummerindex=0; nummerindex<[NummerTab numberOfTabViewItems]; nummerindex++)
         {
            //NSLog(@"klassenindex: %d nummerindex: %d",klassenindex,nummerindex);
            //Dic fuer 'nummer'
            NSMutableDictionary* tempNummerDic = [[NSMutableDictionary alloc]initWithCapacity:0];
            
            switch (klassenindex)
            {
               case 2:
               {
                  NSMutableIndexSet* epochenindex = [NSMutableIndexSet indexSet];
                  NSMutableIndexSet* notenindex = [NSMutableIndexSet indexSet];
                  NSMutableIndexSet* fotoindex = [NSMutableIndexSet indexSet];
                  NSMutableIndexSet* musikindex = [NSMutableIndexSet indexSet];
                  NSLog(@"nummerindex: %d tempNummerDefaultArray: %@",nummerindex,[tempNummerDefaultArray description]);
                  
                  if ([tempNummerDefaultArray count]>nummerindex && [tempNummerDefaultArray objectAtIndex:nummerindex]) // DefaultDic fuer nummerindex vorhanden
                  {
                     NSLog(@"B");
                     if ([[tempNummerDefaultArray objectAtIndex:nummerindex]objectForKey:@"epochenindex"])
                     {
                        epochenindex = [self indexSetVonArray:[[tempNummerDefaultArray objectAtIndex:nummerindex]objectForKey:@"epochenindex"]];
                     }
                     
                     if ([[tempNummerDefaultArray objectAtIndex:nummerindex]objectForKey:@"notenindex"])
                     {
                        notenindex = [self indexSetVonArray:[[tempNummerDefaultArray objectAtIndex:nummerindex]objectForKey:@"notenindex"]];
                     }

                     if ([[tempNummerDefaultArray objectAtIndex:nummerindex]objectForKey:@"fotoindex"])
                     {
                        fotoindex = [self indexSetVonArray:[[tempNummerDefaultArray objectAtIndex:nummerindex]objectForKey:@"fotoindex"]];
                        
                     }
                     
                     if ([[tempNummerDefaultArray objectAtIndex:nummerindex]objectForKey:@"musikindex"])
                     {
                        musikindex = [self indexSetVonArray:[[tempNummerDefaultArray objectAtIndex:nummerindex]objectForKey:@"musikindex"]];
                     }

                  }
                  
          //        else
                  {
                     
                     /*
                     NSLog(@"readPList kein tempNummerDefaultArray an nummerindex: %d",nummerindex);
                     
                     
                     if ([tempNummerDefaultArray count] && [tempNummerDefaultArray objectAtIndex:nummerindex])
                     {
                        NSLog(@"tempNummerDefaultArray hat object nummerindex: %d",nummerindex);
                     }
                     else
                     {
                        //NSMutableDictionary*tempNummerDefaultDic = [[NSMutableDictionary alloc]initWithCapacity:0];
                        //[tempNummerDefaultDic setObject:[NSNumber numberWithInt:nummerindex] forKey:@"nummer"];
                        NSLog(@"tempNummerDefaultArray hat kein object nummerindex: %d ",nummerindex);

                        //NSLog(@"tempNummerDefaultArray hat kein object nummerindex: %d Dic: %@",nummerindex,[tempNummerDefaultDic description]);
                        //[tempNummerDefaultArray addObject:tempNummerDefaultDic];
                     }
                   */
                     NSLog(@"C");
                     
                     switch (nummerindex)
                     {
                        case 0:
                        {
                           // Autoren waehlen
                           if ([fotoindex count]==0)
                           {
                              //[fotoindex addIndex:PAGANINI];
                              //[fotoindex addIndex:BACH];
                              [fotoindex addIndex:SCHUETZ];
                              NSArray* da = [self arrayVonIndexSet:fotoindex];
                              [[tempNummerDefaultArray objectAtIndex:nummerindex]setObject:da forKey:@"fotoindex"];
                              
                           }
                           
                           // Noten
                           if ([notenindex count]==0)
                           {
                              [notenindex addIndex:BACH];
                              //[notenindex addIndex:SCHUBERT];
                              //[notenindex addIndex:PAGANINI];
                              [notenindex addIndex:SCHUETZ];
                              NSArray* da = [self arrayVonIndexSet:notenindex];
                              [[tempNummerDefaultArray objectAtIndex:nummerindex]setObject:da forKey:@"notenindex"];
                              
                           }
                           
                           // Musik
                           if ([musikindex count]==0)
                           {
                              [musikindex addIndex:BACH];
                              //[musikindex addIndex:SCHUBERT];
                              //[musikindex addIndex:PAGANINI];
                              [musikindex addIndex:SCHUETZ];
                              NSArray* da = [self arrayVonIndexSet:musikindex];
                              [[tempNummerDefaultArray objectAtIndex:nummerindex]setObject:da forKey:@"musikindex"];
                              
                           }
                           
                           // Epoche
                           if ([epochenindex count]==0)
                           {
                              //[epochenindex addIndex:1];
                              [epochenindex addIndex:1];
                              NSArray* ea = [self arrayVonIndexSet:epochenindex];
                              [[tempNummerDefaultArray objectAtIndex:nummerindex]setObject:ea forKey:@"epochenindex"];
                           }
                        }break;
                           
                        case 1:
                        {
                           // Autoren waehlen
                           if ([fotoindex count]==0)
                           {
                              [fotoindex addIndex:SCHUBERT];
                              [fotoindex addIndex:BACH];
                              
                              // Defaults einsetzen
                              [[tempNummerDefaultArray objectAtIndex:nummerindex]setObject:[self arrayVonIndexSet:fotoindex] forKey:@"fotoindex"];
                           }
                           
                           
                           // Noten
                           if ([notenindex count]==0)
                           {
                              //[notenindex addIndex:BACH];
                              [notenindex addIndex:SCHUBERT];
                              // Defaults einsetzen
                              [[tempNummerDefaultArray objectAtIndex:nummerindex]setObject:[self arrayVonIndexSet:notenindex] forKey:@"notenindex"];
                              
                           }
                           
                           // Musik
                           if ([musikindex count]==0)
                           {
                              //[musikindex addIndex:BACH];
                              [musikindex addIndex:SCHUBERT];
                              // Defaults einsetzen
                              [[tempNummerDefaultArray objectAtIndex:nummerindex]setObject:[self arrayVonIndexSet:musikindex] forKey:@"musikindex"];
                              
                           }
                           
                           // Epoche
                           if ([epochenindex count]==0)
                           {
                              [epochenindex addIndex:1];
                              //[epochenindex addIndex:2];
                              NSArray* ea = [self arrayVonIndexSet:epochenindex];
                              [[tempNummerDefaultArray objectAtIndex:nummerindex]setObject:ea forKey:@"epochenindex"];
                              
                           }
                           
                        }break;
                           
                        case 2:
                        {
                           // Autoren waehlen
                           if ([fotoindex count]==0)
                           {
                              [fotoindex addIndex:MOZART];
                              [fotoindex addIndex:BACH];
                              // Defaults einsetzen
                              [[tempNummerDefaultArray objectAtIndex:nummerindex]setObject:[self arrayVonIndexSet:fotoindex] forKey:@"fotoindex"];
                              
                           }
                           
                           
                           // Noten
                           if ([notenindex count]==0)
                           {
                              [notenindex addIndex:BACH];
                              [notenindex addIndex:MOZART];
                              // Defaults einsetzen
                              [[tempNummerDefaultArray objectAtIndex:nummerindex]setObject:[self arrayVonIndexSet:notenindex] forKey:@"notenindex"];
                              
                           }
                           
                           // Musik
                           if ([musikindex count]==0)
                           {
                              [musikindex addIndex:BACH];
                              [musikindex addIndex:MOZART];
                              // Defaults einsetzen
                              [[tempNummerDefaultArray objectAtIndex:nummerindex]setObject:[self arrayVonIndexSet:musikindex] forKey:@"musikindex"];
                              
                           }
                           
                           // Epoche
                           if ([epochenindex count]==0)
                           {
                              //[epochenindex addIndex:1];
                              [epochenindex addIndex:2];
                              NSArray* ea = [self arrayVonIndexSet:epochenindex];
                              [[tempNummerDefaultArray objectAtIndex:nummerindex]setObject:ea forKey:@"epochenindex"];
                              
                           }
                           
                        }break;
                           
                        case 3:
                        {
                           // Autoren waehlen
                           if ([fotoindex count]==0)
                           {
                              [fotoindex addIndex:BACH];
                              [fotoindex addIndex:PAGANINI];
                              // Defaults einsetzen
                              [[tempNummerDefaultArray objectAtIndex:nummerindex]setObject:[self arrayVonIndexSet:fotoindex] forKey:@"fotoindex"];
                              
                           }
                           
                           // Noten
                           if ([notenindex count]==0)
                           {
                              [notenindex addIndex:BACH];
                              [notenindex addIndex:PAGANINI];
                              // Defaults einsetzen
                              [[tempNummerDefaultArray objectAtIndex:nummerindex]setObject:[self arrayVonIndexSet:notenindex] forKey:@"notenindex"];
                              
                           }
                           
                           // Musik
                           if ([musikindex count]==0)
                           {
                              [musikindex addIndex:BACH];
                              [musikindex addIndex:PAGANINI];
                              // Defaults einsetzen
                              [[tempNummerDefaultArray objectAtIndex:nummerindex]setObject:[self arrayVonIndexSet:musikindex] forKey:@"musikindex"];
                              
                           }
                           
                           // Epoche
                           if ([epochenindex count]==0)
                           {
                              //[epochenindex addIndex:1];
                              [epochenindex addIndex:3];
                              NSArray* ea = [self arrayVonIndexSet:epochenindex];
                              [[tempNummerDefaultArray objectAtIndex:nummerindex]setObject:ea forKey:@"epochenindex"];
                              
                           }
                           
                           
                           
                        }break;
                           
                           
                        case 4:
                        {
                           // Autoren waehlen
                           if ([fotoindex count]==0)
                           {
                              //[fotoindex addIndex:BACH];
                              [fotoindex addIndex:PAGANINI];
                              // Defaults einsetzen
                              [[tempNummerDefaultArray objectAtIndex:nummerindex]setObject:[self arrayVonIndexSet:fotoindex] forKey:@"fotoindex"];
                              
                           }
                           
                           // Noten
                           if ([notenindex count]==0)
                           {
                              //[notenindex addIndex:BACH];
                              [notenindex addIndex:PAGANINI];
                              // Defaults einsetzen
                              [[tempNummerDefaultArray objectAtIndex:nummerindex]setObject:[self arrayVonIndexSet:notenindex] forKey:@"notenindex"];
                              
                           }
                           
                           // Musik
                           if ([musikindex count]==0)
                           {
                              // [musikindex addIndex:BACH];
                              [musikindex addIndex:PAGANINI];
                              // Defaults einsetzen
                              [[tempNummerDefaultArray objectAtIndex:nummerindex]setObject:[self arrayVonIndexSet:musikindex] forKey:@"musikindex"];
                              
                           }
                           
                           // Epoche
                           if ([epochenindex count]==0)
                           {
                              [epochenindex addIndex:1];
                              [epochenindex addIndex:4];
                              NSArray* ea = [self arrayVonIndexSet:epochenindex];
                              [[tempNummerDefaultArray objectAtIndex:nummerindex]setObject:ea forKey:@"epochenindex"];
                              
                           }
                           
                           
                           
                        }break;
                           
                        case 5:
                        {
                           // Autoren waehlen
                           if ([fotoindex count]==0)
                           {
                              [fotoindex addIndex:BACH];
                              [fotoindex addIndex:PAGANINI];
                              // Defaults einsetzen
                              [[tempNummerDefaultArray objectAtIndex:nummerindex]setObject:[self arrayVonIndexSet:fotoindex] forKey:@"fotoindex"];
                              
                           }
                           
                           // Noten
                           if ([notenindex count]==0)
                           {
                              [notenindex addIndex:BACH];
                              [notenindex addIndex:PAGANINI];
                              // Defaults einsetzen
                              [[tempNummerDefaultArray objectAtIndex:nummerindex]setObject:[self arrayVonIndexSet:notenindex] forKey:@"notenindex"];
                              
                           }
                           
                           // Musik
                           if ([musikindex count]==0)
                           {
                              [musikindex addIndex:BACH];
                              [musikindex addIndex:PAGANINI];
                              // Defaults einsetzen
                              [[tempNummerDefaultArray objectAtIndex:nummerindex]setObject:[self arrayVonIndexSet:musikindex] forKey:@"musikindex"];
                              
                           }
                           
                           // Epoche
                           if ([epochenindex count]==0)
                           {
                              //[epochenindex addIndex:3];
                              [epochenindex addIndex:4];
                              NSArray* ea = [self arrayVonIndexSet:epochenindex];
                              [[tempNummerDefaultArray objectAtIndex:nummerindex]setObject:ea forKey:@"epochenindex"];
                              
                           }
                           
                           
                        }break;
                           
                     }
                  }
                  //NSLog(@"nummerindex: %ld fotoindex fix: %@",nummerindex,[fotoindex description]);
                                    
                  //Dic fuer 'nummer'
 //                 NSMutableDictionary* tempNummerDic = [[NSMutableDictionary alloc]initWithCapacity:0];
                  
          //        [tempNummerDic setObject:[FragenArray objectAtIndex:nummerindex] forKey:@"frage1"];
                  //NSLog(@"[FragenArray objectAtIndex:nummerindex objectForKey:frage: %@",[[FragenArray objectAtIndex:nummerindex]objectForKey:@"frage"]);
                  [tempNummerDic setObject:[[FragenArray objectAtIndex:nummerindex]objectForKey:@"frage"]forKey:@"frage"];
                  
                  [tempNummerDic setObject:[NSNumber numberWithInt:nummerindex] forKey:@"nummer"];
                  [tempNummerDic setObject:[NSNumber numberWithInt:klassenindex] forKey:@"klasse"];
                  [tempNummerDic setObject:fotoindex forKey:@"fotoindex"];
                  [tempNummerDic setObject:notenindex forKey:@"notenindex"];
                  [tempNummerDic setObject:musikindex forKey:@"musikindex"];
                  [tempNummerDic setObject:epochenindex forKey:@"epochenindex"];
                  NSLog(@"\n*** nummerindex: %d tempNummerDic: %@\n*\n*",nummerindex,[tempNummerDic description]);
                  [tempNummerArray addObject:tempNummerDic];
                  
                  
                  NSLog(@"nummer: %d tempNummerArray: %@",nummerindex,[tempNummerArray description]);

               }break; // case 2
                  
            }// switch klassenindex
            
         } // for nummerindex
         
         [tempKlassenArray addObject: tempNummerArray];
      //NSLog(@"*** klassenindex: %d tempNummerDefaultArray: %@\n*\n*",klassenindex,[tempNummerDefaultArray description]);
         
      NSLog(@"*** klassenindex: %d tempNummerDefaultArray: %@\n*\n*",klassenindex,[tempNummerDefaultArray description]);
      [DefaultArray addObject:tempNummerDefaultArray];
      
      } // for klassenindex
      
      
      //NSLog(@"*** tempKlassenArray komplett: %@\n*\n*",[tempKlassenArray description]);
      
      
      
      [PList setObject:tempKlassenArray forKey:@"klassenarray"];
   }// end
    NSLog(@"readPList end");
   
   NSString* ResourcenPfad=[[[NSBundle mainBundle]bundlePath]stringByAppendingPathComponent:@"Contents/Resources"];
   
   NSFileManager *Filemanager=[NSFileManager defaultManager];
   NSArray* tempFileArray=[Filemanager contentsOfDirectoryAtPath:ResourcenPfad error:NULL];
   ;
   //NSLog(@"\n  tempFileArray roh: \n%@",[tempFileArray description]);

   
   //http://stackoverflow.com/questions/3157356/converting-nsdictionary-object-to-nsdata-object-and-vice-versa
   NSMutableData *data = [[NSMutableData alloc]init];
   NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
   [archiver encodeObject:PList forKey: @"plist"];
   [archiver finishEncoding];
   
   
   
   return erfolg;
   
   
   
   
   
   
   // we need to get the plist data...
   NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"plist"];
   NSLog(@"plistPath: %@",plistPath);
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

- (IBAction)writeData:(id)sender
{
   NSString* ResourcenPfad=[[[NSBundle mainBundle]bundlePath]stringByAppendingPathComponent:@"Contents/Resources"];
   NSString* SettingsPfad = [ResourcenPfad stringByAppendingPathComponent:@"quizsettings"];
   
   NSFileManager *Filemanager=[NSFileManager defaultManager];
   NSArray* tempFileArray=[Filemanager contentsOfDirectoryAtPath:ResourcenPfad error:NULL];
   
   //NSLog(@"\n  SettingsPfad: \n%@",SettingsPfad);
   
//   NSLog(@"writeData PList: %@",[PList description]);
   NSLog(@"writeData frage: %@",[[[PList objectForKey:@"klassenarray"]valueForKey:@"frage"] description]);
   NSLog(@"writeData musikindex: %@",[[[PList objectForKey:@"klassenarray"]valueForKey:@"musikindex"] description]);
   NSLog(@"writeData fotoindex: %@",[[[PList objectForKey:@"klassenarray"]valueForKey:@"fotoindex"] description]);
   NSLog(@"writeData notenindex: %@",[[[PList objectForKey:@"klassenarray"]valueForKey:@"notenindex"] description]);
   NSLog(@"writeData epochenindex: %@",[[[PList objectForKey:@"klassenarray"]valueForKey:@"epochenindex"] description]);

   
   NSMutableData *data = [[NSMutableData alloc]init];
   NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
   [archiver encodeObject:PList forKey: @"plist"];
   [archiver finishEncoding];
   
   
   if ([Filemanager fileExistsAtPath:SettingsPfad isDirectory:NO])
   {
      NSLog(@"writeData file da");
      NSError* err;
      [data writeToFile:SettingsPfad options:NSDataWritingAtomic error: &err ];
      if (err)
      {
         NSAlert *theAlert = [NSAlert alertWithError:err];
         [theAlert runModal]; // Ignore return value.
         NSLog(@"data writeToFile err: %@",[err  description]);
         NSLog(@"err userInfo: %@",[[err userInfo] description]);
      }
      else
      {
         NSLog(@"data writeToFile OK");
      }
      
   }
   else
   {
      int erfolg = [Filemanager createFileAtPath:SettingsPfad contents:data attributes:NULL];
      NSLog(@"neues file erfolg: %d",erfolg);
   }
   

}

- (IBAction)resetData:(id)sender
{
   NSString* ResourcenPfad=[[[NSBundle mainBundle]bundlePath]stringByAppendingPathComponent:@"Contents/Resources"];
   NSString* SettingsPfad = [ResourcenPfad stringByAppendingPathComponent:@"quizsettings"];
   
   NSFileManager *Filemanager=[NSFileManager defaultManager];
   NSArray* tempFileArray=[Filemanager contentsOfDirectoryAtPath:ResourcenPfad error:NULL];
   
   //NSLog(@"\n  SettingsPfad: \n%@",SettingsPfad);
   
   //   NSLog(@"writeData PList: %@",[PList description]);
   NSLog(@"writeData frage: %@",[[[PList objectForKey:@"klassenarray"]valueForKey:@"frage"] description]);
   NSLog(@"writeData musikindex: %@",[[[PList objectForKey:@"klassenarray"]valueForKey:@"musikindex"] description]);
   NSLog(@"writeData fotoindex: %@",[[[PList objectForKey:@"klassenarray"]valueForKey:@"fotoindex"] description]);
   NSLog(@"writeData notenindex: %@",[[[PList objectForKey:@"klassenarray"]valueForKey:@"notenindex"] description]);
   NSLog(@"writeData epochenindex: %@",[[[PList objectForKey:@"klassenarray"]valueForKey:@"epochenindex"] description]);
   
   
   NSMutableData *data = [[NSMutableData alloc]init];
   NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
   [archiver encodeObject:[NSMutableDictionary dictionary] forKey: @"plist"];
   [archiver finishEncoding];
   
   
   if ([Filemanager fileExistsAtPath:SettingsPfad isDirectory:NO])
   {
      NSLog(@"resetData file da");
      NSError* err;
      [data writeToFile:SettingsPfad options:NSDataWritingAtomic error: &err ];
      if (err)
      {
         NSAlert *theAlert = [NSAlert alertWithError:err];
         [theAlert runModal]; // Ignore return value.
         NSLog(@"data writeToFile err: %@",[err  description]);
         NSLog(@"err userInfo: %@",[[err userInfo] description]);
      }
      
   }
   else
   {
      int erfolg = [Filemanager createFileAtPath:SettingsPfad contents:data attributes:NULL];
      NSLog(@"neues file erfolg: %d",erfolg);
   }
   
   

}

- (void)writePList:(NSDictionary*)plist
{
   // we need to get the plist data...
   NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"plist"];
   NSLog(@"plistPath: %@",plistPath);
    NSLog(@"plist: %@",[plist description]);
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
   //int erfolg = [plist writeToFile:plistPath atomically:YES];
   int erfolg = [[NSDictionary dictionaryWithObjectsAndKeys:@"aaa",@"a",@"bbb",@"b", nil ] writeToFile:plistPath atomically:YES];
   
   
   NSLog(@"erfolg: %d",erfolg);
}

//@"SettingDaten"
- (void)SettingDatenAktion:(NSNotification*)note
{
	//NSLog(@"SettingDatenAktion: note: %@",[[[note userInfo]objectForKey:@"indexarray" ]description]);
   
   NSLog(@"SettingDatenAktion frage: %@",[[[[note userInfo]objectForKey:@"indexarray" ] valueForKey:@"frage"] description]);
   NSLog(@"SettingDatenAktion musikindex: %@",[[[[note userInfo]objectForKey:@"indexarray" ] valueForKey:@"musikindex"] description]);
   NSLog(@"SettingDatenAktion fotoindex: %@",[[[[note userInfo]objectForKey:@"indexarray" ] valueForKey:@"fotoindex"] description]);
   NSLog(@"SettingDatenAktion notenindex: %@",[[[[note userInfo]objectForKey:@"indexarray" ] valueForKey:@"notenindex"] description]);
   NSLog(@"SettingDatenAktion epochenindex: %@",[[[[note userInfo]objectForKey:@"indexarray" ] valueForKey:@"epochenindex"] description]);

   
   int klasse = [[[note userInfo]objectForKey:@"klasse"]intValue];
   int nummer = [[[note userInfo]objectForKey:@"nummer"]intValue];
  
   [[PList objectForKey:@"klassenarray"] replaceObjectAtIndex:klasse withObject:[[note userInfo]objectForKey:@"indexarray"]];
//   [self setAuswahl];
   [self setAuswahlMitVorgabe:2];
   
   
  // IndexArray = [(NSMutableArray*)[[DatenDic objectForKey:@"plist"]objectForKey:@"klassenarray"]objectAtIndex:self.klasseWert];
   //[self writePList:PList];
  // [[NSUserDefaults standardUserDefaults]setObject:PList forKey:@"plist"];
//[[NSUserDefaults standardUserDefaults]setObject:DefaultArray forKey:@"defaultarray"];
//[[NSUserDefaults standardUserDefaults] synchronize];
   
   NSString* ResourcenPfad=[[[NSBundle mainBundle]bundlePath]stringByAppendingPathComponent:@"Contents/Resources"];
   
   NSString* SettingsPfad = [ResourcenPfad stringByAppendingPathComponent:@"quizsettings"];
   
   NSFileManager *Filemanager=[NSFileManager defaultManager];
    
   NSArray* tempFileArray=[Filemanager contentsOfDirectoryAtPath:ResourcenPfad error:NULL];
   ;
   //NSLog(@"\n  SettingsPfad: \n%@",SettingsPfad);

   
   NSMutableData *data = [[NSMutableData alloc]init];
   NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
   [archiver encodeObject:PList forKey: @"plist"];
   [archiver finishEncoding];
   
   
   if ([Filemanager fileExistsAtPath:SettingsPfad isDirectory:NO])
   {
      NSLog(@"SettingDatenAktion file da");
      NSError* err;
      [data writeToFile:SettingsPfad options:NSDataWritingAtomic error: &err ];
      if (err)
      {
         NSAlert *theAlert = [NSAlert alertWithError:err];
         [theAlert runModal]; // Ignore return value.
         NSLog(@"data writeToFile err: %@",[err  description]);
         NSLog(@"err userInfo: %@",[[err userInfo] description]);
      }

   }
   else
   {
      int erfolg = [Filemanager createFileAtPath:SettingsPfad contents:data attributes:NULL];
      NSLog(@"neues file erfolg: %d",erfolg);
   }
   
}

- (long)maxVonArray:(NSArray*)intarray
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
  // long x = arc4random();
   //NSLog(@"Highest number: %ld at index: %ld x: %ld", highestNumber, numberIndex,x);
   return highestNumber;
}

- (long)minVonArray:(NSArray*)intarray
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
   //NSLog(@"terminate");
   if ([[player movie]rate])
   {
      //NSLog(@"terminate stop");
      [[player movie]stop];
      
   }

   [NSApp terminate:self];
}

#pragma mark TabView
- (void)tabView:(NSTabView *)tabView willSelectTabViewItem:(NSTabViewItem*)tabViewItem
{
	//	NSLog(@"TestTabFeld aktuelles TabViewItem: %@",[[TestTabFeld selectedTabViewItem] label]);
		//NSLog(@"TestTabFeld willSelectTabViewItem: %@",[tabViewItem label]);
	
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
   
   // eventuell Button zuruecksetzen
   NSArray* viewarray = [[tabViewItem view] subviews];
   //NSLog(@"didSelectTabViewItem viewarray: %@",[viewarray description]);

   // tag-Bereich der Playtasten
   NSRange tabrange = NSMakeRange(1000, 10);
   NSIndexSet* tabindex = [NSIndexSet indexSetWithIndexesInRange:tabrange];
   for (int k=0;k<[viewarray count];k++)
   {
      //NSLog(@"didSelectTabViewItem k: %d tag: %ld",k,[[viewarray objectAtIndex:k]tag]);
      if ([tabindex containsIndex:[[viewarray objectAtIndex:k]tag]] )
      {
         int temptag=[[viewarray objectAtIndex:k]tag];
   //      [[[tabViewItem view] viewWithTag:temptag]setState:0];
         //NSLog(@"didSelectTabViewItem Playtaste da state: %ld",[[[tabViewItem view] viewWithTag:temptag]state]);
         NSImage* playicon = [NSImage imageNamed:@"playicon.png"];
         [[[tabViewItem view] viewWithTag:temptag]setImage:playicon];
      }
      
   }

   
   
   long aktuellenummer = [tabView indexOfTabViewItem:tabViewItem ];
   long aktuellercode = ([KlasseTab indexOfTabViewItem:[KlasseTab selectedTabViewItem]])*100 + aktuellenummer;

   long ergebnispos = [[MasterErgebnisArray valueForKey:@"code"]indexOfObject:[NSNumber numberWithInt: (int)aktuellercode]];
   //NSLog(@"didSelectTabViewItem item: %ld: ergebnispos: %ld",[tabView indexOfTabViewItem:tabViewItem] ,ergebnispos);
   if (ergebnispos < NSNotFound)
   {
      //NSLog(@"didSelectTabViewItem: %ld ErgebnisDic: %@",[tabView indexOfTabViewItem:tabViewItem ],[MasterErgebnisArray objectAtIndex:ergebnispos]);
      
      int wahl = -1;
      if ([[MasterErgebnisArray objectAtIndex:ergebnispos]objectForKey:@"wahl"])
      {
         wahl = [[[MasterErgebnisArray objectAtIndex:ergebnispos]objectForKey:@"wahl"]intValue];
      }
      //NSLog(@"didSelectTabViewItem: %d",wahl);
      if (wahl >= 0 && wahl < 8000)
      {
         int wahlpos = [[[MasterErgebnisArray objectAtIndex:ergebnispos]objectForKey:@"wahlpos"]intValue];
         //NSLog(@"didSelectTabViewItem: wahl: %d wahlpos: %d",wahl, wahlpos);
         [self setAuswahlMitVorgabe:wahlpos];
      }
      else // wurde mit resetErgebnisse geloescht
      {
         //NSLog(@"didSelectTabViewItem: vorgabe 2");
         [self setAuswahlMitVorgabe:2];
      }
   }
   else 
   {
      //NSLog(@"kein ErgebnisDic");
      [self setAuswahlMitVorgabe:2]; // weiss nicht
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

   return 0;
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
