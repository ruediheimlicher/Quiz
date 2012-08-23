//
//  AppDelegate.m
//  Quiz
//
//  Created by Ruedi Heimlicher on 05.August.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import <QTKit/QTKit.h>

@implementation AppDelegate

@synthesize window = _window;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize managedObjectContext = __managedObjectContext;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
   // Insert code here to initialize your application
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
   [[NSColor colorWithCalibratedWhite:1.0 alpha:0.3] set];
   NSRectFillUsingOperation(backgroundRect,NSCompositeSourceOver);

   [backgroundImage unlockFocus];
   
   // Set our background image as the window's background color.
   [[self window] setBackgroundColor:
    [NSColor colorWithPatternImage:backgroundImage]];
   
   // Release the image.
   //[backgroundImage release];
   NSView* d;
    NSImage *AuswahlImage = [NSImage imageNamed:@"Kirche_288.jpg"]; 
 //  [[KlasseTab view]setImage:AuswahlImage];
   
   AuswahlArray = [[NSMutableArray alloc]initWithCapacity:0];
   MusikArray = [[NSMutableArray alloc]initWithCapacity:0];
   MusiktitelArray = [[NSMutableArray alloc]initWithCapacity:0];
   NotenArray = [[NSMutableArray alloc]initWithCapacity:0];
   FotoArray = [[NSMutableArray alloc]initWithCapacity:0];
   FragenArray = [[NSMutableArray alloc]initWithCapacity:0];
   
   
   
   NSLog(@"bundlePath: %@",[[NSBundle mainBundle]bundlePath]);
   NSString* ResourcenPfad=[[[NSBundle mainBundle]bundlePath]stringByAppendingPathComponent:@"Contents/Resources"];
   NSFileManager *Filemanager=[NSFileManager defaultManager];
   NSString* FilePfad=[[[NSBundle mainBundle]bundlePath]stringByAppendingPathComponent:@"Contents"];

   NSArray* tempInhaltArray=[Filemanager contentsOfDirectoryAtPath:FilePfad error:NULL];
   ;
   NSLog(@"\n  files roh: \n%@",[tempInhaltArray description]);
   
   
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
   
   for(i=0;i<[tempFileArray count];i++)
   {
      NSString* tempPfad = [tempFileArray objectAtIndex:i];
      NSArray* tempPfadArray = [tempPfad componentsSeparatedByString:@"."];
      //NSLog(@"tempPfadArray raw: %@ count: %d",[tempPfadArray description],[tempPfadArray count]);
      NSMutableDictionary* tempDataDic = [[NSMutableDictionary alloc]initWithCapacity:0];

      NSString* tempName;
      if ([tempPfadArray count]>4)
      {
         NSArray* tempNamenArray = [tempPfadArray subarrayWithRange:NSMakeRange(3, [tempPfadArray count]-4)];
         tempName= [[tempPfadArray subarrayWithRange:NSMakeRange(3, [tempPfadArray count]-4)]componentsJoinedByString:@"."];
         NSLog(@"tempName: %@",[tempNamenArray componentsJoinedByString:@"."]);
         
         NSNumber* artnumber = [NSNumber numberWithInt:[[tempPfadArray objectAtIndex:0]intValue]];
         NSNumber* autornumber = [NSNumber numberWithInt:[[tempPfadArray objectAtIndex:1]intValue]];
         NSNumber* indexnumber = [NSNumber numberWithInt:[[tempPfadArray objectAtIndex:2]intValue]];
         
         
         [tempDataDic setObject:artnumber forKey:@"art"];
         [tempDataDic setObject:autornumber forKey:@"autor"];
         [tempDataDic setObject:indexnumber forKey:@"index"];

      }
      else 
      {
         tempName = [[tempPfadArray subarrayWithRange:NSMakeRange(0, [tempPfadArray count]-2)]componentsJoinedByString:@"."];;      
      }
      
      // Fragen lesen
      if ([tempPfad hasSuffix:@"txt"])
      {
         NSLog(@"Text da: tempPfad: %@",tempPfad);
         NSString* tempFragenPfad=[[NSBundle mainBundle] pathForResource:tempPfad ofType:NULL];
         NSLog(@"Text da: tempFragenPfad: %@",tempFragenPfad);
         
         NSString* tempFragenString=[NSString stringWithContentsOfFile:tempFragenPfad encoding: NSUTF8StringEncoding error:NULL];
         ;
         
         NSLog(@"  tempFragenString : \n%@",tempFragenString);
         NSArray* tempFragenArray = [tempFragenString componentsSeparatedByString:@"\n"];
         NSLog(@"  tempFragenArray : \n%@",tempFragenArray);
         int k=0;
         for (k=0;k<[tempFragenArray count];k++)
         {
            NSArray* tempZeilenArray = [[tempFragenArray objectAtIndex:k] componentsSeparatedByString:@"\t"];
            NSLog(@"  tempZeilenArray : \n%@ count: %lu",[tempZeilenArray description], [tempZeilenArray count]);
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
            NSLog(@"tempName sound: %@",tempName);
//            [tempDataDic setObject:[tempPfadArray objectAtIndex:1] forKey:@"autor"];
//            [tempDataDic setObject:[tempPfadArray objectAtIndex:2] forKey:@"index"];
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
            
            NSMutableDictionary* tempAuswahlDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:0],@"eins",[NSNumber numberWithInt:0],@"zwei",[NSNumber numberWithInt:0],@"drei", tempName,@"name",nil];
            [AuswahlArray addObject:tempAuswahlDic];

         }break;
            
         case 002: // Foto
         {
            //NSLog(@"tempPfadArray foto: %@ count: %d",[tempPfadArray description],[tempPfadArray count]);
            [tempDataDic setObject:tempPfad forKey:@"fotopfad"];
            tempName= [[tempPfadArray subarrayWithRange:NSMakeRange(3, [tempPfadArray count]-4)]componentsJoinedByString:@"."];
            [tempDataDic setObject:tempName forKey:@"name"];
 //           [tempDataDic setObject:[tempPfadArray objectAtIndex:1] forKey:@"autor"];

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
            
            tempName= [[tempPfadArray subarrayWithRange:NSMakeRange(3, [tempPfadArray count]-3)]componentsJoinedByString:@"."];
            //NSLog(@"tempPfadArray noten: %@ count: %d",[tempPfadArray description],[tempPfadArray count]);

            [tempDataDic setObject:tempName forKey:@"name"];
            NSImage* bild = [NSImage imageNamed:tempPfad];
            [tempDataDic setObject:bild forKey:@"bild"];
            [NotenArray addObject:tempDataDic];
           
         }break;
            
      }// switch
      
} // for i tempFileArray
   
   
   
   
   // "weiss nicht"-Zeile einfuegen
   NSMutableDictionary* tempAuswahlDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:1],@"eins",[NSNumber numberWithInt:1],@"zwei",[NSNumber numberWithInt:1],@"drei", @"weiss nicht",@"name",nil];
   
   [AuswahlArray addObject:tempAuswahlDic];
   NSLog(@"MusikArray: %@",[MusikArray description]);
   NSLog(@"FotoArray: %@",[FotoArray description]);
   NSLog(@"NotenArray: %@",[NotenArray description]);

   NSLog(@"AuswahlArray: %@",[AuswahlArray description]);
   NSLog(@"MusiktitelArray: %@",[MusiktitelArray description]);
   NSLog(@"FragenArray: %@",[FragenArray description]);

 //  [Auswahltabelle setDelegate:self];
 //  [Auswahltabelle setDataSource:self];
 //  [Auswahltabelle setBackgroundColor:[NSColor clearColor]];
   [KlasseTab selectTabViewItemAtIndex:0];
   [Klassefeld setStringValue:@""];
   [Nummerfeld setStringValue:@""];
   NSRect f = [AuswahlRadioFeld frame];
   NSLog(@"frame b: %2.2f h: %2.2f",f.size.width,f.size.height);
  // AuswahlRadio = [[rRadioMatrix alloc]initWithFrame:f mitKolonnen:3 mitZeilen:1];
  [AuswahlRadio setKolonnen:3];
   [AuswahlRadio setTitel:@"weiss nicht" inZeile:0 inKolonne:2];
   [AuswahlRadio setStatus:1 inZeile:0 inKolonne:2];
   [AuswahlRadio setNeedsDisplay:YES];
}

- (IBAction)reportPlaytaste:(id)sender
{
   if ([[player movie]rate])
   {
      [[player movie]stop];
   }
   
   int i=0;
   for (i=0;i<3;i++)
   {
      if ((i+1000)==[sender tag])
      {
         if ([sender state])
         {
            NSImage* pauseicon = [NSImage imageNamed:@"pauseicon.png"];
           // [[[sender superview] viewWithTag:i+1000]setImage:pauseicon];

            [sender setImage:pauseicon];
           // NSLog(@"AA%@",[[MusikArray objectAtIndex:[sender tag]-1000]description]);
            QTMovie* tempSound = [[MusikArray objectAtIndex:[sender tag]-1000]objectForKey:@"sound"];
            //[tempSound play];
            //[[[MusikArray objectAtIndex:[sender tag]-1000]objectForKey:@"sound"]play ];
            [player setMovie: tempSound]; 
            
            [[player movie] play];
         }
         else 
         {
            //[sender setTitle:@">"];
            NSImage* playicon = [NSImage imageNamed:@"playicon.png"];
            [sender setImage:playicon];

         }
         
      }
      else if ([[sender superview] viewWithTag:i+1000])
      {
         NSLog(@"object da: tag: %d",i);
         [[[sender superview] viewWithTag:i+1000]setState:0];
         //[[[sender superview] viewWithTag:i+1000]setTitle:@">"];
         NSImage* playicon = [NSImage imageNamed:@"playicon.png"];
         [[[sender superview] viewWithTag:i+1000]setImage:playicon];

      }
   }
  
   {
      
      //[sender setTitle:@"||"];

   }
   //NSLog(@"reportPlaytaste tag: %ld",[sender tag]);
   
   
}

- (int)setAuswahl
{
   int erfolg=0;  
   NSLog(@"setAuswahl");
   NSTabViewItem* KlasseItem = [KlasseTab selectedTabViewItem];
   int klassewahl = [Klassewahl  selectedRow];
   int klasse = [KlasseTab  indexOfTabViewItem:KlasseItem];
   
   int nummer=0;
   if (klasse)
   {
      NSTabViewItem* NummerItem = [NummerTab selectedTabViewItem];
      nummer = [NummerTab  indexOfTabViewItem:NummerItem];

    switch (nummer)  
      {
         case 0:
         {
            
            //NSTableView* tempTable = [[NummerItem view]viewWithTag:(4000+nummer)];
            //[tempTable setDataSource:self];
            [(NSTableView*)[[NummerItem view]viewWithTag:4000+nummer]setDataSource:self];
            
            [[[NummerItem view]viewWithTag:4000+nummer]setDelegate:self];
            
            NSLog(@"AuswahlArray vor: %@",[AuswahlArray description]);
            
            NSAttributedString *attributedString = [[NSAttributedString alloc]
                                                    initWithString: @"weiss nicht" attributes: [NSDictionary
                                                                                                dictionaryWithObjectsAndKeys: [NSColor alternateSelectedControlTextColor], NSForegroundColorAttributeName,
                                                                                                nil]];
            
            [[[[NummerItem view]viewWithTag:8000+nummer]cell] setAttributedTitle: attributedString];

            
            while([AuswahlArray  count]>1)
            {
               [AuswahlArray removeObjectAtIndex:0];
            }
            
            
            
            AuswahlArray = [[NSMutableArray alloc]initWithCapacity: 0];
            
            [Auswahltabelle reloadData];
            
            NSLog(@"AuswahlArray nach: %@",[AuswahlArray description]);
            
            NSLog(@"setAuswahl Klassewahl: %d Klassetab: %d nummer: %d",klassewahl,klasse,nummer);
            
            NSMutableArray* tempKlasseFragenArray = [[NSMutableArray alloc]initWithCapacity:0];
            
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
            NSLog(@"tempFrage: %@",tempFrage);
            
            [[[NummerItem view]viewWithTag:(klasse*1000)+nummer]setStringValue:tempFrage];
            
            // Autoren waehlen
            NSMutableIndexSet* autorindex = [NSMutableIndexSet indexSet];
            [autorindex addIndex:3];
            //[autorindex addIndex:1];
            int autorbildindex=0;
            
            for (i=0;i<[FotoArray count];i++)
            {
               if ([[[FotoArray objectAtIndex:i]objectForKey:@"art"]intValue] == 2 
                   && [autorindex containsIndex:[[[FotoArray objectAtIndex:i]objectForKey:@"autor"]intValue]] )
               {
                  NSLog(@"Foto da: name: %@",[[FotoArray objectAtIndex:i]objectForKey:@"name"]);
                  [autorindex removeIndex:[[[FotoArray objectAtIndex:i]objectForKey:@"autor"]intValue] ];
                  NSImage* bild = [[FotoArray objectAtIndex:i]objectForKey:@"bild"];
                  [[[NummerItem view]viewWithTag:(6000+nummer+autorbildindex)]setImage:
                   [[FotoArray objectAtIndex:i]objectForKey:@"bild"]];
                  
                  NSMutableDictionary* tempFotoDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:0],@"eins",[NSNumber numberWithInt:0],@"zwei",[NSNumber numberWithInt:0],@"drei",[[FotoArray objectAtIndex:i]objectForKey:@"name"],@"name", nil];
                 
                  [AuswahlArray insertObject:tempFotoDic atIndex:0];
                   
                  [Bildlegende setStringValue:[[FotoArray objectAtIndex:i]objectForKey:@"name"]];
                  autorbildindex++;

               }
               
            }//for
            
            NSLog(@"AuswahlArray neu: %@",[AuswahlArray description]);
            NSMutableDictionary* tempAuswahlDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:1],@"eins",[NSNumber numberWithInt:1],@"zwei",[NSNumber numberWithInt:1],@"drei", @"weiss nicht",@"name",nil];
            [AuswahlArray addObject:tempAuswahlDic];
            
            //Radio setzen
            //[[[NummerItem view]viewWithTag:8000

            [Auswahltabelle reloadData];
            
            
            // Auswahl bestimmen
            
            // Noten auswaehlen
            NSMutableIndexSet* notenindex = [NSMutableIndexSet indexSet];
            
            [notenindex addIndex:1];
            [notenindex addIndex:3];
            
            NSMutableArray* tempNotenArray = [[NSMutableArray alloc]initWithCapacity:0];
            int notenbildindex=0;
            
            for (i=0;i<[NotenArray count];i++)
            {
               if ([[[NotenArray objectAtIndex:i]objectForKey:@"art"]intValue] == 3 
                   && [notenindex containsIndex:[[[NotenArray objectAtIndex:i]objectForKey:@"autor"]intValue]] )
               {
                  if ([[NummerItem view]viewWithTag:(5000+100*nummer+notenbildindex)]) // Bild vorhanden
                  {
                     [[[NummerItem view]viewWithTag:(5000+100*nummer+notenbildindex)]setImage:
                      [[NotenArray objectAtIndex:i]objectForKey:@"bild"]];
                     [notenindex removeIndex:[[[NotenArray objectAtIndex:i]objectForKey:@"autor"]intValue]];
                     notenbildindex++;
                  }
                  //int tempIndex = [[NotenArray objectAtIndex:i]intValue];
                  [tempNotenArray addObject:[NotenArray objectAtIndex:i]];
                  
               }
               
            }
            NSLog(@"tempNotenArray: %@",[tempNotenArray description]);

            // Musik auswaehlen
            NSMutableIndexSet* musikindex = [NSMutableIndexSet indexSet];
            
            [musikindex addIndex:1];
            [musikindex addIndex:3];
            int soundindex=0;
            
            for (i=0;i<[MusikArray count];i++)
            {
               if ([[[MusikArray objectAtIndex:i]objectForKey:@"art"]intValue] == 1 
                   && [musikindex containsIndex:[[[NotenArray objectAtIndex:i]objectForKey:@"autor"]intValue]] )
               {
                  
                  NSLog(@"Musik da: name: %@",[[MusikArray objectAtIndex:i]objectForKey:@"name"]);
                  if ([[NummerItem view]viewWithTag:(1000+soundindex)]) // Taste vorhanden
                  {
                     [[[NummerItem view]viewWithTag:(1000+soundindex)]setTag:
                      1000+i];
                     [musikindex removeIndex:[[[NotenArray objectAtIndex:i]objectForKey:@"autor"]intValue]];
                     soundindex++;
                    // NSMutableDictionary* tempAuswahlDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:0],@"eins",[NSNumber numberWithInt:0],@"zwei",[NSNumber numberWithInt:0],@"drei", [[MusikArray objectAtIndex:i]objectForKey:@"autor"],@"name",nil];
                     //[AuswahlArray addObject:tempAuswahlDic];
                     [Auswahltabelle reloadData];
                    
                  
                  } 

               }
            }
                  
            
         
         }break; // case 0
            
         case 1:
         {
            // Autoren waehlen
            NSMutableIndexSet* autorindex = [NSMutableIndexSet indexSet];
            [autorindex addIndex:2];
            [autorindex addIndex:1];

            // Noten auswaehlen
            NSMutableIndexSet* notenindex = [NSMutableIndexSet indexSet];
            //[notenindex addIndex:1];
            [notenindex addIndex:2];

            // Musik auswaehlen
            NSMutableIndexSet* musikindex = [NSMutableIndexSet indexSet];
            
            //[musikindex addIndex:1];
            [musikindex addIndex:2];

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
            NSLog(@"tempFrage: %@",tempFrage);
            
            [[[NummerItem view]viewWithTag:(klasse*1000)]setStringValue:tempFrage];
            
            
            //Bilder der Autoren suchen
            int autorbildindex=0;
            
            for (i=0;i<[FotoArray count];i++)
            {
               if ([[[FotoArray objectAtIndex:i]objectForKey:@"art"]intValue] == 2 
                   && [autorindex containsIndex:[[[FotoArray objectAtIndex:i]objectForKey:@"autor"]intValue]] )
               {
                  NSLog(@"Foto da autorbildindex: %d : name: %@",autorbildindex,[[FotoArray objectAtIndex:i]objectForKey:@"name"]);
                  [autorindex removeIndex:[[[FotoArray objectAtIndex:i]objectForKey:@"autor"]intValue] ];
                  NSImage* bild = [[FotoArray objectAtIndex:i]objectForKey:@"bild"];
                  [[[NummerItem view]viewWithTag:(6000+autorbildindex)]setImage:
                   [[FotoArray objectAtIndex:i]objectForKey:@"bild"]];
                  
                  //NSMutableDictionary* tempFotoDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:0],@"eins",[NSNumber numberWithInt:0],@"zwei",[NSNumber numberWithInt:0],@"drei",[[FotoArray objectAtIndex:i]objectForKey:@"name"],@"name", nil];
                  
                  // [AuswahlArray insertObject:tempFotoDic atIndex:0];
                  [[[NummerItem view]viewWithTag:(9000+autorbildindex)]setStringValue:[[FotoArray objectAtIndex:i]objectForKey:@"name"]];
                  
                  
                  //[Bildlegende setStringValue:[[FotoArray objectAtIndex:i]objectForKey:@"name"]];
                  autorbildindex++;
                  
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
                  
                  NSLog(@"Musik da: name: %@",[[MusikArray objectAtIndex:i]objectForKey:@"name"]);
                  if ([[NummerItem view]viewWithTag:(1000+soundindex)]) // Taste vorhanden
                  {
                     [[[NummerItem view]viewWithTag:(1000+soundindex)]setTag:
                      1000+i];
                     [musikindex removeIndex:[[[NotenArray objectAtIndex:i]objectForKey:@"autor"]intValue]];
                     soundindex++;
                     // NSMutableDictionary* tempAuswahlDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:0],@"eins",[NSNumber numberWithInt:0],@"zwei",[NSNumber numberWithInt:0],@"drei", [[MusikArray objectAtIndex:i]objectForKey:@"autor"],@"name",nil];
                     //[AuswahlArray addObject:tempAuswahlDic];
                     //[Auswahltabelle reloadData];
                     
                     
                  } 
                  
               }
            }

            
            
         }break; // case 1
            
         case 2: 
         {
            // Autoren waehlen
            NSMutableIndexSet* autorindex = [NSMutableIndexSet indexSet];
            [autorindex addIndex:2];
            [autorindex addIndex:1];
            
            // Noten auswaehlen
            NSMutableIndexSet* notenindex = [NSMutableIndexSet indexSet];
            [notenindex addIndex:1];
            [notenindex addIndex:3];
            
            // Musik auswaehlen
            NSMutableIndexSet* musikindex = [NSMutableIndexSet indexSet];
            [musikindex addIndex:1];
            [musikindex addIndex:3];
            
            // Epoche auswaehlen
            NSMutableIndexSet* epocheindex = [NSMutableIndexSet indexSet];
            //[epocheindex addIndex:1];
            [epocheindex addIndex:2];
            
            
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
            NSLog(@"tempFrage: %@",tempFrage);
            [[[NummerItem view]viewWithTag:(klasse*1000)]setStringValue:tempFrage];
            
            
            // Musik auswaehlen
            int soundindex=0;
            
            for (i=0;i<[MusikArray count];i++)
            {
               if ([[[MusikArray objectAtIndex:i]objectForKey:@"art"]intValue] == 1 
                   && [musikindex containsIndex:[[[NotenArray objectAtIndex:i]objectForKey:@"autor"]intValue]] )
               {
                  
                  NSLog(@"Musik da: name: %@",[[MusikArray objectAtIndex:i]objectForKey:@"name"]);
                  if ([[NummerItem view]viewWithTag:(1000+soundindex)]) // Taste vorhanden
                  {
                     [[[NummerItem view]viewWithTag:(1000+soundindex)]setTag:
                      1000+i];
                     [musikindex removeIndex:[[[NotenArray objectAtIndex:i]objectForKey:@"autor"]intValue]];
                     soundindex++;
                     // NSMutableDictionary* tempAuswahlDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:0],@"eins",[NSNumber numberWithInt:0],@"zwei",[NSNumber numberWithInt:0],@"drei", [[MusikArray objectAtIndex:i]objectForKey:@"autor"],@"name",nil];
                     //[AuswahlArray addObject:tempAuswahlDic];
                     //[Auswahltabelle reloadData];
                     
                     
                  } 
                  
               }
            }
            
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
            
            
         }break; // case 2
            
            
      } // switch nummer
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
            //NSLog(@"master klasse: %d nummer: %d",klasse, nummer);
           // int index = [tempKlasseFragenArray indexOfObject:[NSNumber numberWithInt:klasse]];
           // NSLog(@"master klasse: %d nummer: %d index: %d Frage: %@",klasse, nummer,index,[[FragenArray objectAtIndex:index]objectForKey:@"frage"]); 
            
           // [[[NummerItem view]viewWithTag:(klasse*1000)+nummer]setStringValue:[[FragenArray objectAtIndex:index+nummer]objectForKey:@"frage"]];
            
            
         }break;
            
         case 3: // expert
         {
            NSLog(@"expert nummer: %d",nummer);
         }break;
            
      }// switch klasse
      NSLog(@"setAuswahl end");
      return erfolg;
   }
   return 0;   
}

- (IBAction)reportNeutaste:(id)sender
{
   NSLog(@"reportNeutaste");
   if ([[player movie]rate])
   {
      [[player movie]stop];
   }
   int erfolg = [self setAuswahl];
 //  NSImage* bild = [NSImage imageNamed:@"002.001.001.Joh.Seb.Bach.jpg"];
 //  [Bild0 setImage:bild];
 //  [Bild1 setImage:[NSImage imageNamed:@"002.002.001.W.A.Mozart.jpg"]];
 //  [Bild2 setImage:[NSImage imageNamed:@"002.003.001.N.Paganini.jpg"]];

   NSLog(@"reportNeutaste end");
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
   NSLog(@"reportKlassewahl Klasse: %ld",[sender selectedRow]);
   [KlasseTab selectTabViewItemAtIndex:[sender selectedRow]+1];
   //[[[[KlasseTab selectedTabViewItem] view]viewWithTag:3000]selectTabViewItemAtIndex:0];
   [NummerTab selectTabViewItemAtIndex:0];
   [Klassefeld setStringValue:[NSString stringWithFormat:@"Level: %ld",[sender selectedRow]+1]];
   [Nummerfeld setStringValue:[NSString stringWithFormat:@"Nummer: %ld",1]];

   [self setAuswahl];
}

- (IBAction)reportRadiowahl:(id)sender
{
   NSLog(@"reportRadiowahl wahl: %ld",[sender selectedColumn]);
   }


- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView
{
   return [AuswahlArray count];
}

- (IBAction)reportNexttaste:(id)sender
{
   NSLog(@"reportNexttaste ");
   if ([[player movie]rate])
   {
      [[player movie]stop];
   }

   [NummerTab selectNextTabViewItem:NULL];
   [Nummerfeld setStringValue:[NSString stringWithFormat:@"Nummer: %ld",[NummerTab indexOfTabViewItem:[NummerTab selectedTabViewItem]]+1]];

   [self setAuswahl];
}

- (IBAction)reportPrevtaste:(id)sender
{   
   if ([[player movie]rate])
   {
      [[player movie]stop];
   }
   
   [NummerTab selectPreviousTabViewItem:NULL];
   [Nummerfeld setStringValue:[NSString stringWithFormat:@"Nummer: %ld",[NummerTab indexOfTabViewItem:[NummerTab selectedTabViewItem]]+1]];

   [self setAuswahl];
}

- (IBAction)reportFirsttaste:(id)sender
{
   if ([[player movie]rate])
   {
      [[player movie]stop];
   }
      [NummerTab selectTabViewItemAtIndex:0];

}

- (IBAction)reportHometaste:(id)sender
{
   if ([[player movie]rate])
   {
      [[player movie]stop];
   }

   [KlasseTab selectTabViewItemAtIndex:0];
   [NummerTab selectTabViewItemAtIndex:0];

}



- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
   //NSLog(@"objectValueForTableColumn rowIndex: %d",rowIndex);
   
   if (rowIndex < [AuswahlArray count])
   {
      return [[AuswahlArray objectAtIndex:rowIndex]objectForKey:[aTableColumn identifier]];
   }
return NULL;

}

- (void)tableView:(NSTableView *)aTableView 
   setObjectValue:(id)anObject 
   forTableColumn:(NSTableColumn *)aTableColumn 
              row:(long)rowIndex
{
   //NSLog(@"setObjectValueForTableColumn anObject: %d",[anObject intValue]);
   
   NSMutableDictionary* einDic;
   if (rowIndex<[AuswahlArray count])
	{
		einDic=[AuswahlArray objectAtIndex:rowIndex];
      int status = [anObject intValue];
      NSString* ident = [aTableColumn identifier];
		[einDic setObject:anObject forKey:ident];
      NSArray* keyArray = [einDic allKeys];
      if (status) // eins wird gesetzt, alle andern fuer den identifier zuruecksetzen
      {
         int i =0;
         int k=0;
         for (i=0;i<[AuswahlArray count];i++)
         {
            if (!(i==rowIndex))
            {
               [[AuswahlArray objectAtIndex:i] setObject:[NSNumber numberWithInt:0] forKey:ident];
            }
            //else 
            {
               // bei nur einer Auswahl die anderen Boxen zuruecksetzen
               /*
               for (k=0;k<[keyArray count];k++)
               {
                  if (i<[AuswahlArray count]-1) // noch nicht unterste Zeile
                  {
                     if (![[keyArray objectAtIndex:k] isEqualToString:ident]) 
                     {
                        [[AuswahlArray objectAtIndex:i] setObject:[NSNumber numberWithInt:0] forKey:[keyArray objectAtIndex:k]];
                     }
                  }
                  else 
                  {
                     //[[AuswahlArray objectAtIndex:i] setObject:[NSNumber numberWithInt:0] forKey:[keyArray objectAtIndex:k]];
                  }
               }
                */
            }
            
         }
     // 
  //       [[AuswahlArray lastObject] setObject:[NSNumber numberWithInt:0] forKey:ident];
      
      }
     // [[AuswahlArray lastObject] setObject:[NSNumber numberWithInt:status] forKey:ident];
      
      [aTableView reloadData];
	}
    
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
