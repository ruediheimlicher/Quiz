//
//  rSettingsWindowController.m
//  Quiz
//
//  Created by Ruedi Heimlicher on 13.August.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "rSettingsWindowController.h"

@interface rSettingsWindowController ()

@end

@implementation rSettingsWindowController

@synthesize nummerWert ;
@synthesize klasseWert ;

- (id)initWithWindow:(NSWindow *)window
{
   //NSLog(@"settings initWithWindow");
   self = [super initWithWindow:window];
   if (self) 
   {
 //     DatenDic = [[NSMutableDictionary alloc]initWithCapacity:0];
      return self;
   }
   return NULL;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    //NSLog(@"settings windowDidLoad");
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
   //IndexArray = [[NSMutableArray alloc]initWithCapacity:0] ;
   [IndexTabelle setDelegate:self];
   [IndexTabelle setDataSource:self];
   MusikPop=[[NSPopUpButtonCell alloc] init];
	//[MusikPop setImagePosition:NSImageRight];
	[MusikPop synchronizeTitleAndSelectedItem];
   [MusikPop setBordered:YES];
	NSFont* Popfont;
	Popfont=[NSFont fontWithName:@"Lucida Grande" size: 10];
   NSSize PopButtonSize;
	PopButtonSize.height=20;

	[MusikPop setFont:Popfont];
   [MusikPop setPullsDown:NO];
   SEL PopSelektor;
	PopSelektor=@selector(MusikSetzen:);
	//[MusikPop setAction:PopSelektor];


	NSFont* Tablefont;
	Tablefont=[NSFont fontWithName:@"Lucida Grande" size: 12];
	//[[IndexTabelle tableColumnWithIdentifier: @"musikindex"]setEditable:NO];
	
   int i=0;
   for (i=0; i<3; i++) 
   {
      NSString* musikkey = [NSString stringWithFormat:@"m%d",i];
      NSString* notenkey = [NSString stringWithFormat:@"n%d",i];
      NSString* fotokey = [NSString stringWithFormat:@"f%d",i];
      NSString* epochekey = [NSString stringWithFormat:@"e%d",i];
      
   //   [[IndexTabelle tableColumnWithIdentifier: musikkey] setDataCell: (NSCell*)MusikPop];
  //   [[IndexTabelle tableColumnWithIdentifier: notenkey] setDataCell: (NSCell*)MusikPop];
 //     [[IndexTabelle tableColumnWithIdentifier: fotokey] setDataCell: (NSCell*)MusikPop];
    	[[[IndexTabelle tableColumnWithIdentifier: musikkey]dataCell]setFont:Tablefont];
      [[[IndexTabelle tableColumnWithIdentifier: notenkey]dataCell]setFont:Tablefont];
      [[[IndexTabelle tableColumnWithIdentifier: fotokey]dataCell]setFont:Tablefont];
      [[[IndexTabelle tableColumnWithIdentifier: epochekey]dataCell]setFont:Tablefont];
   }
   [[[IndexTabelle tableColumnWithIdentifier: @"klasse"]dataCell]setFont:Tablefont];
   [[[IndexTabelle tableColumnWithIdentifier: @"nummer"]dataCell]setFont:Tablefont];

	[IndexTabelle setRowHeight: PopButtonSize.height];
	[[IndexTabelle tableColumnWithIdentifier: @"name"]setEditable:NO];

}

- (IBAction)MusikSetzen:(id)sender
{
   NSLog(@"AufnahmeSetzen: Zeile: %ld",[sender selectedRow]);
   //[self setLeserFuerZeile:[sender selectedRow]];
}

- (void)updateDaten
{
   NSLog(@"*\n\n*updateDaten");
   //NSLog(@"updateDaten IndexArray  %@",[IndexArray description]);
   int nummerindex=0;
   
   for (nummerindex=0; nummerindex<[IndexArray count]; nummerindex++) 
   {
    //  NSLog(@"IndexArray  %@",[[[IndexArray objectAtIndex:nummerindex ]objectForKey:@"musikindex"]description]);
      //NSLog(@"updateDaten IndexArray index: %d Data: %@",nummerindex,[[IndexArray objectAtIndex:nummerindex ] description]);
      
       // set fuer Update
      
      // Musik
      NSMutableIndexSet* tempMusikSet = [NSMutableIndexSet indexSet];
      int indexpos=0;
      
      for (indexpos=0; indexpos<3; indexpos++) 
      {
         // musik
         NSString* tempkey = [NSString stringWithFormat:@"m%d",indexpos];
         int tempindex = [[[IndexArray objectAtIndex:nummerindex ]objectForKey:tempkey]intValue];
         if (tempindex >= 0)
         {
            [tempMusikSet addIndex:[[[[DatenDic objectForKey:@"musikarray"] objectAtIndex:tempindex]objectForKey:@"autor"]intValue]];
         }
      } // for indexpos
     // NSLog(@"IndexArray vor  %@",[[[IndexArray objectAtIndex:nummerindex ]objectForKey:@"musikindex"]description]);
     
      [[IndexArray objectAtIndex:nummerindex ]setObject:tempMusikSet forKey:@"musikindex"];
      
      //NSLog(@"IndexArray nach  %@",[[[IndexArray objectAtIndex:nummerindex ]objectForKey:@"musikindex"]description]);
      //NSLog(@"ind %d tempSet musik neu: %@",nummerindex,[tempMusikSet description]);
      
      //Fotos
      
      NSMutableIndexSet* tempFotoSet = [NSMutableIndexSet indexSet];
      NSMutableIndexSet* oldFotoSet = [[IndexArray objectAtIndex:nummerindex ]objectForKey:@"fotoindex"];
      //NSLog(@"ind %d oldFotoSet: %@ \n data: %@",nummerindex,[oldFotoSet description],[[IndexArray objectAtIndex:nummerindex ]description]);
      for (indexpos=0; indexpos<3; indexpos++) 
      {
         NSString* tempkey = [NSString stringWithFormat:@"f%d",indexpos];
         int tempindex = [[[IndexArray objectAtIndex:nummerindex ]objectForKey:tempkey]intValue];
         //NSLog(@"indexpos: %d tempindex: %d tempkey: %@ ",indexpos,tempindex,tempkey);

         //NSLog(@"indexpos: %d tempindex: %d",indexpos,tempindex);
         if (tempindex >= 0)
         {
            [tempFotoSet addIndex:[[[[DatenDic objectForKey:@"fotoarray"] objectAtIndex:tempindex]objectForKey:@"autor"]intValue]];
         }
      } // for indexpos
      [[IndexArray objectAtIndex:nummerindex ]setObject:tempFotoSet forKey:@"fotoindex"];
      
      //[[IndexArray objectAtIndex:nummerindex ]setObject:oldFotoSet forKey:@"fotoindex"];
      
      //NSLog(@"ind %d tempSet foto: %@",nummerindex,[tempFotoSet description]);

      //Noten
      
      NSMutableIndexSet* tempNotenSet = [NSMutableIndexSet indexSet];
      for (indexpos=0; indexpos<3; indexpos++) 
      {
         NSString* tempkey = [NSString stringWithFormat:@"n%d",indexpos];
         int tempindex = [[[IndexArray objectAtIndex:nummerindex ]objectForKey:tempkey]intValue];
         if (tempindex >= 0)
         {
            [tempNotenSet addIndex:[[[[DatenDic objectForKey:@"notenarray"] objectAtIndex:tempindex]objectForKey:@"autor"]intValue]];
         }
      } // for indexpos
      [[IndexArray objectAtIndex:nummerindex ]setObject:tempNotenSet forKey:@"notenindex"];
      //NSLog(@"ind %d tempSet noten: %@",nummerindex,[tempNotenSet description]);

      //Epoche
      //[tempSet removeAllIndexes];
      NSMutableIndexSet* tempEpochenSet = [NSMutableIndexSet indexSet];
     
      for (indexpos=0; indexpos<3; indexpos++) 
      {
         NSString* tempkey = [NSString stringWithFormat:@"e%d",indexpos];
         int tempindex = [[[IndexArray objectAtIndex:nummerindex ]objectForKey:tempkey]intValue];
         if (tempindex >= 0)
         {
            [tempEpochenSet addIndex:[[[[DatenDic objectForKey:@"epochenarray"] objectAtIndex:tempindex]objectForKey:@"autor"]intValue]];
         }
      } // for indexpos
      [[IndexArray objectAtIndex:nummerindex ]setObject:tempEpochenSet forKey:@"epochenindex"];
      //NSLog(@"ind %d tempSet epochen: %@",nummerindex,[tempEpochenSet description]);
      
      
   
   } // for nummerindex
   
}

- (void)setDaten:(NSMutableDictionary*)datendic
{
   NSLog(@"setDaten start");
   DatenDic = (NSMutableDictionary*)datendic;
   //NSLog(@"setDaten Datendic: %@",[[DatenDic objectForKey:@"klassenarray"] description]);
  // NSLog(@"***\nsetDaten Datendic: %@",[DatenDic description]);
   if ([DatenDic objectForKey:@"klasse"])
   {
     // [Klassefeld setStringValue:[DatenDic objectForKey:@"klasse"]];
      self.klasseWert = [[DatenDic objectForKey:@"klasse"]intValue];
   }
   if ([DatenDic objectForKey:@"nummer"])
   {
      // [Nummerfeld setIntValue:[[DatenDic objectForKey:@"nummer"]intValue]];
      self.nummerWert = [[DatenDic objectForKey:@"nummer"]intValue];
      
   }

   
   NSLog(@"Settings setDaten klasse: %@",[[[DatenDic objectForKey:@"klassenarray"]valueForKey:@"klasse"] description]);
   
   NSLog(@"Settings setDaten frage: %@",[[[DatenDic objectForKey:@"klassenarray"]valueForKey:@"frage"] description]);
   
   NSLog(@"Settings setDaten musikindex: %@",[[[DatenDic objectForKey:@"klassenarray"]valueForKey:@"musikindex"] description]);
   NSLog(@"Settings setDaten fotoindex: %@",[[[DatenDic objectForKey:@"klassenarray"]valueForKey:@"fotoindex"] description]);
   NSLog(@"Settings setDaten notenindex: %@",[[[DatenDic objectForKey:@"klassenarray"]valueForKey:@"notenindex"] description]);
   NSLog(@"Settings setDaten epochenindex: %@",[[[DatenDic objectForKey:@"klassenarray"]valueForKey:@"epochenindex"] description]);

   /*
   if ([DatenDic objectForKey:@"plist"])
   {
      
      //KlassenArray = (NSMutableArray*)[[DatenDic objectForKey:@"plist"]objectForKey:@"klassenarray"];
      IndexArray = [(NSMutableArray*)[[DatenDic objectForKey:@"plist"]objectForKey:@"klassenarray"]objectAtIndex:self.klasseWert];
      
      
      //NSLog(@"setDaten IndexArray  %@",[IndexArray description]);
      //NSLog(@"setDaten Test klassenarray: %@",[IndexArray description]);
      
      [IndexTabelle reloadData];
      
      NSLog(@"setDaten IndexArray  %@",[[[IndexArray objectAtIndex:0 ]objectForKey:@"musikindex"]description]);

   }
    */
   
   if ([datendic objectForKey:@"klassenarray"])
   {
      IndexArray = [[NSMutableArray alloc]initWithArray:[[datendic objectForKey:@"klassenarray"]objectAtIndex:self.klasseWert]];
      
     // [IndexArray setArray:[[DatenDic objectForKey:@"klassenarray"]objectAtIndex:self.klasseWert]];
   }
   else 
   {
      return;
   }
   //return;
   //NSLog(@"IndexArray vor: %@",[IndexArray description]);
   
   // FragenArray
   //NSLog(@"***");
   //NSLog(@"Settings setDaten %@",[IndexArray valueForKey:@"frage"]);
   //NSLog(@"***");
   
   NSMutableArray*    FragenArray = [[NSMutableArray alloc]initWithCapacity:0];
   //NSLog(@"setDaten FragenArray raw Data: %@",[[DatenDic objectForKey:@"fragenarray"] description]);
   
   for (int i=0;i<[[DatenDic objectForKey:@"fragenarray"] count];i++)
   {
      //NSLog(@"i: %d self.klasseWert: %d klasse: %d Data: %@",i,self.klasseWert,[[[[DatenDic objectForKey:@"fragenarray"] objectAtIndex:i]objectForKey:@"klasse"]intValue],[[[DatenDic objectForKey:@"fragenarray"] objectAtIndex:i]objectForKey:@"frage"] );
      if ([[[[DatenDic objectForKey:@"fragenarray"] objectAtIndex:i]objectForKey:@"klasse"]intValue] == self.klasseWert)
      {
         [FragenArray addObject:[[[DatenDic objectForKey:@"fragenarray"]objectAtIndex:i]objectForKey:@"frage"]];
      }
   }
   //NSLog(@"setDaten FragenArray filter klasse: %d: FragenArray: %@",self.klasseWert,[FragenArray description]);

   //NSArray*    FragenArray = [IndexArray valueForKey:@"frage"];
   //NSLog(@"setDaten FragenArray %@",[FragenArray description]);
   //      NSLog(@"FragenArray autor%@",[[FragenArray valueForKey:@"autor"] description]);

   // MusikArray
   NSArray*    MusikArray = [DatenDic objectForKey:@"musikarray"];
   //     NSLog(@"setDaten MusikArray %@",[MusikArray description]);
   //      NSLog(@"MusikArray autor%@",[[MusikArray valueForKey:@"autor"] description]);
    
   
   // NotenArray
   NSArray*    NotenArray = [DatenDic objectForKey:@"notenarray"];
   //      NSLog(@"NotenArray %@",[NotenArray description]);
  //       NSLog(@"NotenArray name %@",[[NotenArray valueForKey:@"autor"] description]);
  
   
   // FotoArray
   NSArray*    FotoArray = [DatenDic objectForKey:@"fotoarray"];
    //     NSLog(@"setDaten FotoArray %@",[FotoArray description]);
   //      NSLog(@"FotoArray name %@",[[FotoArray valueForKey:@"name"] description]);
   
   // EpochenArray
   NSArray*    EpochenArray = [DatenDic objectForKey:@"epochenarray"];
   //NSLog(@"setDaten EpochenArray %@",[EpochenArray description]);
   //NSLog(@"EpochenArray name %@",[[EpochenArray valueForKey:@"name"] description]);
   
  
   
   int k=0;
   for (k=0; k<[IndexArray count]; k++) // 
   {
      
      
      // Indexsets der Musik, Noten, fotos
      NSMutableDictionary* tempIndexDic = [IndexArray objectAtIndex:k];
      
      //NSString* frage = [[FragenArray objectAtIndex:k]objectForKey:@"frage"];
      //NSString* frage = [FragenArray objectAtIndex:k];
      
      if ([FragenArray objectAtIndex:k])
      {
         if ([[FragenArray objectAtIndex:k]length])
         {
         [tempIndexDic setObject:[FragenArray objectAtIndex:k] forKey:@"frage"];
         }
         else
         {
            [tempIndexDic setObject:@"-" forKey:@"frage"];
         }
      }
      
      //NSLog(@"***\nfrage: %@",frage);
      // Musik
      NSIndexSet* tempMusikSet = [[IndexArray objectAtIndex:k] objectForKey:@"musikindex"];
      //      NSLog(@"***\n");
      
      //NSLog(@"tempMusikSet k: %d  %@",k,[tempMusikSet description ]);
      int musikindex=[tempMusikSet firstIndex];
      int pos=0;
      while(musikindex != NSNotFound  && pos < 3) // nur 3 Pops in TableView
      {
         int auswahl = [[MusikArray valueForKey:@"autor"] indexOfObject:[NSNumber numberWithInt:musikindex]];
         
         NSString* key = [NSString stringWithFormat:@"m%d",pos];
         // auswahl in tempIndexDic schreiben mit key
         
         [tempIndexDic setObject:[NSNumber numberWithInt:auswahl] forKey:key];
         //[tempIndexDic setObject:[[MusikArray objectAtIndex:auswahl]objectForKey:@"autor"] forKey:key];
         
         //NSLog(@"pos: %d musikindexindex: %d auswahl: %d key: %@",pos,musikindex,auswahl,key);
         
         //NSLog(@"MusikArray objectAtIndex:auswahl %@",[MusikArray objectAtIndex:auswahl]);
         musikindex=[tempMusikSet indexGreaterThanIndex: musikindex];
         pos++;
      }
      
      
      // Noten
      NSIndexSet* tempNotenSet = [[IndexArray objectAtIndex:k] objectForKey:@"notenindex"];
      //NSLog(@"tempSet k: %d  %@",k,[tempSet description ]);
      int notenindex=[tempNotenSet firstIndex];
      pos=0;
      while(notenindex != NSNotFound  && pos < 3) // nur 3 Pops in TableView
      {
         int auswahl = [[NotenArray valueForKey:@"autor"] indexOfObject:[NSNumber numberWithInt:notenindex]];
         NSString* key = [NSString stringWithFormat:@"n%d",pos];
         // auswahl in tempIndexDic schreiben mit key
         [tempIndexDic setObject:[NSNumber numberWithInt:auswahl] forKey:key];
         //NSLog(@"pos: %d index: %d auswahl: %d key: %@",pos,notenindex,auswahl,key);
         
         //NSLog(@" %@",[MusikArray objectAtIndex:notenindex]);
         notenindex=[tempNotenSet indexGreaterThanIndex: notenindex];
         pos++;
      }
      
      
      // Fotos
      NSIndexSet* tempFotoSet = [[IndexArray objectAtIndex:k] objectForKey:@"fotoindex"];
      //NSLog(@"tempFotoSet k: %d  %@",k,[tempFotoSet description ]);
      int fotoindex=[tempFotoSet firstIndex];
      pos=0;
      while(fotoindex != NSNotFound && pos < 3) // nur 3 Pops in TableView
      {
         int auswahl = [[FotoArray valueForKey:@"autor"] indexOfObject:[NSNumber numberWithInt:fotoindex]]; // ergibt -1 wenn notfound, nicht NSNotFound> wert wird bei updateDaten nicht verwendet
         NSString* key = [NSString stringWithFormat:@"f%d",pos];
         // auswahl in tempIndexDic schreiben mit key
         [tempIndexDic setObject:[NSNumber numberWithInt:auswahl] forKey:key];
         //NSLog(@"pos: %d index: %d auswahl: %d key: %@",pos,fotoindex,auswahl,key);
         
         //NSLog(@" %@",[FotoArray objectAtIndex:notenindex]);
         fotoindex=[tempFotoSet indexGreaterThanIndex: fotoindex];
         pos++;
      }
      
      // epochen
      NSIndexSet* tempEpochenSet = [[IndexArray objectAtIndex:k] objectForKey:@"epochenindex"];
      //NSLog(@"tempEpochenSet k: %d  %@",k,[tempEpochenSet description ]);
      int epochenindex=[tempEpochenSet firstIndex];
      pos=0;
      while(epochenindex != NSNotFound &&  pos < 3) // nur 3 Pops in TableView
      {
         int auswahl = [[EpochenArray valueForKey:@"autor"] indexOfObject:[NSNumber numberWithInt:epochenindex]];
         NSString* key = [NSString stringWithFormat:@"e%d",pos];
         // auswahl in tempIndexDic schreiben mit key
         [tempIndexDic setObject:[NSNumber numberWithInt:auswahl] forKey:key];
         //NSLog(@"epochen pos: %d epochenindex: %d auswahl: %d key: %@",pos,epochenindex,auswahl,key);
         
         epochenindex=[tempEpochenSet indexGreaterThanIndex: epochenindex];
         pos++;
      }
      //NSLog(@"setDaten tempIndexDic:  %@",[tempIndexDic description ]);
      
   }
      
      int i=0;
      //Popups in TableView laden
      for (i=0;i<3; i++) 
      {
         NSString* musikkey = [NSString stringWithFormat:@"m%d",i];
         [[[IndexTabelle tableColumnWithIdentifier:musikkey]dataCell]removeAllItems];
         [[[IndexTabelle tableColumnWithIdentifier:musikkey]dataCell]addItemsWithTitles:[[DatenDic objectForKey:@"musikarray"]valueForKey:@"name"]];

         NSString* notenkey = [NSString stringWithFormat:@"n%d",i];
         [[[IndexTabelle tableColumnWithIdentifier:notenkey]dataCell]removeAllItems];
         [[[IndexTabelle tableColumnWithIdentifier:notenkey]dataCell]addItemsWithTitles:[[DatenDic objectForKey:@"notenarray"]valueForKey:@"name"]];
         
         NSString* fotokey = [NSString stringWithFormat:@"f%d",i];
         [[[IndexTabelle tableColumnWithIdentifier:fotokey]dataCell]removeAllItems];
         [[[IndexTabelle tableColumnWithIdentifier:fotokey]dataCell]addItemsWithTitles:[[DatenDic objectForKey:@"fotoarray"]valueForKey:@"name"]];

         NSString* epochekey = [NSString stringWithFormat:@"e%d",i];
         [[[IndexTabelle tableColumnWithIdentifier:epochekey]dataCell]removeAllItems];
         [[[IndexTabelle tableColumnWithIdentifier:epochekey]dataCell]addItemsWithTitles:[[DatenDic objectForKey:@"epochenarray"]valueForKey:@"name"]];
         
      }
      
       
      
      
      //[[[IndexTabelle tableColumnWithIdentifier:@"musikindex"]dataCellForRow:1]addItemsWithTitles:[[DatenDic objectForKey:@"notenkarray"]valueForKey:@"name"]];
      
   
   
   //NSLog(@"IndexArray nach: %@",[IndexArray description]);          
   
   if ([DatenDic objectForKey:@"musikarray"])
   {
      [[[[self window]contentView]viewWithTag:1000]removeAllItems];
      [[[[self window]contentView]viewWithTag:1000]addItemsWithTitles:[[DatenDic objectForKey:@"musikarray"]valueForKey:@"name"]];
      
   }
 
   if ([DatenDic objectForKey:@"fotoarray"])
   {
      [[[[self window]contentView]viewWithTag:2000]removeAllItems];
      [[[[self window]contentView]viewWithTag:2000]addItemsWithTitles:[[DatenDic objectForKey:@"fotoarray"]valueForKey:@"name"]];
      
   }
   if ([DatenDic objectForKey:@"notenarray"])
   {
      [[[[self window]contentView]viewWithTag:3000]removeAllItems];
      [[[[self window]contentView]viewWithTag:3000]addItemsWithTitles:[[DatenDic objectForKey:@"notenarray"]valueForKey:@"name"]];
      
   }
   
   if ([DatenDic objectForKey:@"epochenarray"])
   {
      [[[[self window]contentView]viewWithTag:4000]removeAllItems];
      [[[[self window]contentView]viewWithTag:4000]addItemsWithTitles:[[DatenDic objectForKey:@"epochenarray"]valueForKey:@"name"]];
      
   }
   if ([DatenDic objectForKey:@"autorarray"])
   {
      [[[[self window]contentView]viewWithTag:5000]removeAllItems];
      [[[[self window]contentView]viewWithTag:5000]addItemsWithTitles:[[DatenDic objectForKey:@"autorarray"]valueForKey:@"name"]];
   }
   [IndexTabelle reloadData];
   
   [[self window]makeFirstResponder: NULL];
   
   
    //NSLog(@"setDaten IndexArray f0: %@",[[IndexArray valueForKey:@"f0"]description]);
   // [self writePList:NULL];
}
- (NSDictionary*)datendic
{
   return DatenDic;
}

- (IBAction)reportClose:(id)sender
{
   NSLog(@"Settings reportClose frage: %@",[[IndexArray valueForKey:@"frage"] description]);
   NSLog(@"Settings reportClose musikindex: %@",[[IndexArray valueForKey:@"musikindex"] description]);
   NSLog(@"Settings reportClose fotoindex: %@",[[IndexArray valueForKey:@"fotoindex"] description]);
   NSLog(@"Settings reportClose notenindex: %@",[[IndexArray valueForKey:@"notenindex"] description]);
   NSLog(@"Settings reportClose epochenindex: %@",[[IndexArray valueForKey:@"epochenindex"] description]);

 //  NSLog(@"reportClose IndexArray Musik m0: %@",[[IndexArray valueForKey:@"m0"]description]);
 //  NSLog(@"reportClose IndexArray Noten n0: %@",[[IndexArray valueForKey:@"n0"]description]);
 //  NSLog(@"reportClose IndexArray Fotos f0: %@",[[IndexArray valueForKey:@"f0"]description]);
 //  NSLog(@"reportClose IndexArray Epoche e0: %@",[[IndexArray valueForKey:@"e0"]description]);
   
   //NSLog(@"reportClose IndexArray vor up: %@",[IndexArray description]);
   
   // Daten aktualisieren
   [self updateDaten];
   //NSLog(@"reportClose IndexArray nach up: %@",[IndexArray description]);
   
   NSLog(@"reportClose IndexArray nach up");
   NSLog(@"Settings reportClose frage: %@",[[IndexArray valueForKey:@"frage"] description]);
   NSLog(@"Settings reportClose musikindex: %@",[[IndexArray valueForKey:@"musikindex"] description]);
   NSLog(@"Settings reportClose fotoindex: %@",[[IndexArray valueForKey:@"fotoindex"] description]);
   NSLog(@"Settings reportClose notenindex: %@",[[IndexArray valueForKey:@"notenindex"] description]);
   NSLog(@"Settings reportClose epochenindex: %@",[[IndexArray valueForKey:@"epochenindex"] description]);
  
   
	NSNotificationCenter * nc;
	nc=[NSNotificationCenter defaultCenter];
   NSMutableDictionary* tempInfoDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       IndexArray ,@"indexarray", 
                                       [NSNumber numberWithInt:self.klasseWert],@"klasse",
                                       [NSNumber numberWithInt:self.nummerWert],@"nummer",
                                       nil];
   
   
	[nc postNotificationName:@"SettingsDaten" object:self userInfo:tempInfoDic];
   
   [[self window]orderOut:NULL];
   
}

#pragma mark TableView
- (NSArray*)rowData
{
   return rowData;
};


- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView
{
   return [IndexArray count];
}



- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
   //NSLog(@"objectValueForTableColumn rowIndex: %ld count: %d",rowIndex ,[IndexArray count] );
   
   if (rowIndex < [IndexArray count])
   {
      
      if ([IndexArray objectAtIndex:rowIndex]&& [aTableColumn identifier])
      {
         //NSLog(@"ident: %@ objectValue %@",[aTableColumn identifier],[[IndexArray objectAtIndex:rowIndex]description]);
         
         if ([IndexArray objectAtIndex:rowIndex] ) //&& [[IndexArray objectAtIndex:rowIndex]count])        
         {
            //NSLog(@"ok");
            return [[IndexArray objectAtIndex:rowIndex]objectForKey:[aTableColumn identifier]];
            
            if ([[aTableColumn identifier] isEqualToString:@"frage"])
            {
               return [[IndexArray objectAtIndex:rowIndex]objectForKey:@"frage"];
            }
            if ([[aTableColumn identifier] isEqualToString:@"m0"])
            {
               return [[IndexArray objectAtIndex: rowIndex] objectForKey: [aTableColumn identifier]];
            }
            if ([[aTableColumn identifier] isEqualToString:@"m1"])
            {
               return [[IndexArray objectAtIndex: rowIndex] objectForKey: [aTableColumn identifier]];
            }
            if ([[aTableColumn identifier] isEqualToString:@"m2"])
            {
               return [[IndexArray objectAtIndex: rowIndex] objectForKey: [aTableColumn identifier]];
            }

            
         return [[IndexArray objectAtIndex: rowIndex] objectForKey: [aTableColumn identifier]];
         
         }
         
         
         
         //[[IndexArray objectAtIndex:rowIndex]
         //return @"data";
         /*
          if ([[IndexArray objectAtIndex:rowIndex]objectForKey:[aTableColumn identifier]])
          {
          return [[IndexArray objectAtIndex:rowIndex]objectForKey:[aTableColumn identifier]];
          }
          */
      }
      else {
         //return @"leer";
      }
   }
   return NULL;
   
}

- (void)tableView:(NSTableView *)aTableView 
   setObjectValue:(id)anObject 
   forTableColumn:(NSTableColumn *)aTableColumn 
              row:(long)rowIndex
{
   //return;
   NSLog(@"setObjectValueForTableColumn ident: %@ row: %ld objectValue: %d",[aTableColumn identifier],rowIndex,[anObject intValue]);
   
   NSMutableDictionary* einDic;
   if (rowIndex<[IndexArray count])
	{
		einDic=[IndexArray objectAtIndex:rowIndex];
      int index = [anObject intValue];
      NSString* ident = [aTableColumn identifier];
		[einDic setObject:anObject forKey:ident];
      NSArray* keyArray = [einDic allKeys];

      [einDic setObject:anObject forKey:[aTableColumn identifier]];
      
      
      [aTableView reloadData];
	}
   
   
}

/*

- (void)tableView:(NSTableView *)tableView willDisplayCell:(id)cell forTableColumn:(NSTableColumn *)tableColumn row:(int)row
{
	//NSLog(@"AdminDS willDisplayCell Zeile: %d, numberOfSelectedRows:%d", row ,[tableView numberOfSelectedRows]);
	
   if ([[tableColumn identifier] isEqualToString:@"aufnahmen"])
	{
		[cell removeAllItems];
		//[cell setImagePosition:NSImageRight];
		if ([[IndexArray objectAtIndex:row]count]) //Der Leser hat Aufnahmen
		{
			NSImage* MarkOnImg=[NSImage imageNamed:@"MarkOnImg.tif"];
			NSImage* MarkOffImg=[NSImage imageNamed:@"MarkOffImg.tif"];
			//[MarkOnImg setBackgroundColor:[NSColor clearColor]];
			//NSLog(@"MarkArrayvon Zeile %d : %@",row,[[MarkArray objectAtIndex:row] description]);
			NSEnumerator* AufnahmenEnumerator=[[IndexArray objectAtIndex:row] objectEnumerator];
			id eineAufnahme;
			int index=0;
			while(eineAufnahme=[AufnahmenEnumerator nextObject])//Aufnahmen für Menu
         {
            [cell addItemWithTitle:eineAufnahme];
            int menuIndex=[cell indexOfItemWithTitle:eineAufnahme];
            //NSLog(@"eineAufnahme: %@ index: %d  menuIndex: %d",eineAufnahme,index,menuIndex);
            
            
            if ([[MarkArray objectAtIndex:row]count])
            {
               // NSLog(@"MarkArray count: %d",[[MarkArray objectAtIndex:row] count]);
               if(index<[[MarkArray objectAtIndex:row]count])
               {
                  BOOL tempState=[[[MarkArray objectAtIndex:row]objectAtIndex:index]boolValue];
                  //NSLog(@"tempState:%d",tempState);
                  if (tempState)
						{
                     [[cell itemAtIndex:index]setImage:MarkOnImg];
						}
                  else
						{
                     [[cell itemAtIndex:index]setImage:MarkOffImg];
						}
               }
            }
            //else
            {
               //[[cell itemAtIndex:0]setImage:NULL];
            }
            
            index++;
         }
			//NSLog(@"willDisplayCell: AuswahlArray:%@",[AuswahlArray description]);
         
			int hit=[[IndexArray objectAtIndex:row]intValue];
			//NSLog(@"willDisplayCell: hit:%d",hit);
			[cell selectItemAtIndex:hit];
			//NSColor * MarkFarbe=[NSColor orangeColor];
			//[cell setTextColor:MarkFarbe];
			//[cell setImagePosition:NSImageLeft];
			//NSImage* StartPlayImg=[NSImage imageNamed:@"StartPlayImg.tif"];
			//[cell setImage:StartPlayImg];
			//[cell setBackgroundColor:[NSColor redColor]];
			[cell setEnabled:YES];
			//[MarkCheckbox setEnabled:YES];
		}
		else
		{
			[cell addItemWithTitle:@"leer"];
			[cell setEnabled:NO];
			//[MarkCheckbox setEnabled:NO];
			
		}
   }
	if ([[tableColumn identifier] isEqualToString:@"namen"])
   {
		//NSLog(@"willDisplayCell: row: %d Dic: %@ ",row, [[rowData objectAtIndex:row]description]);
      
		//NSLog(@"willDisplayCell: row: %d Namen: %@ session: %d",row, [[rowData objectAtIndex:row]objectForKey:@"namen"],[[[rowData objectAtIndex:row] objectForKey:@"insession"]boolValue]);
		if ([[[rowData objectAtIndex:row] objectForKey:@"insession"]boolValue])//Namen ist in SessionArray
		{
         [cell setTextColor:[NSColor greenColor]];
		}
		else
		{
         [cell setTextColor:[NSColor blackColor]];
		}
      
		if ([[IndexArray objectAtIndex:row]count])
      {
         
      }
		else
      {
			[cell setSelectable:NO];
         
      }
   }
   
	if ([[tableColumn identifier] isEqualToString:@"anz"])
	{
		//[cell setIntValue:[[AufnahmeFiles objectAtIndex:row]count]];
		//if ([[AufnahmeFiles objectAtIndex:row]count])
		{
			//[cell setEnabled:YES];
			
			//if ([tableView isRowSelected :row])
			{
				//[cell setEnabled:YES];
				//[cell setTransparent:NO];
				//[cell setTitle:@">"];
				//[cell setKeyEquivalent:@"\r"];
			}
			//else
			{
				//[cell setTransparent:YES];
				//[cell setTitle:@""];
				//[cell setEnabled:NO];
				//[cell setKeyEquivalent:@""];
			}
		}
		//else
		{
         //	[cell setTitle:@""];
			//[cell setKeyEquivalent:@""];
         //	[cell setEnabled:NO];
         //	[cell setTransparent:YES];
		}
	}
   
   //NSString* s=[[AufnahmeFiles objectAtIndex:row] description];
   //NSString* nach=[[cell itemTitles]description];
   //NSLog(@"      willDisplayCell cell nach: %@",nach);
   
   //NSLog(@"willDisplayCell Liste: %@",s);
	
}
*/
/*
- (BOOL)tableView:(NSTableView *)tableView shouldSelectRow:(NSInteger)row
{
	
	//NSLog(@"**AdminDS tableView  shouldSelectRow: %d  [tableView clickedRow]:%d" ,row,[tableView clickedRow]);
	
	int selektierteZeile=[tableView selectedRow];//vorher selektierte Zeile
	
	NSString* tempLastLesernamen=[NSString string];//leer wenn zeilennummer=-1 beim ersten Klick
	
	NSMutableDictionary* AdminZeilenDic=[[NSMutableDictionary alloc]initWithCapacity:0];
	[AdminZeilenDic setObject:@"AdminView" forKey:@"Quelle"];
	NSNumber* 	ZeilenNummer=[NSNumber numberWithInt:selektierteZeile];
	[AdminZeilenDic setObject:ZeilenNummer forKey:@"AdminLastZeilenNummer"];
   
	//[AdminZeilenDic setObject:[NSNumber numberWithInt:row] forKey:@"AdminNextZeilenNummer"];
	//[AdminZeilenDic setObject:[[rowData objectAtIndex:row]objectForKey:@"namen"] forKey:@"nextLeser"];
   
	if (selektierteZeile>=0)//schon eine Zeile selektiert
	{
		//NSLog(@"rowData last Zeile: %d  Daten: %@",selektierteZeile, [[rowData objectAtIndex:selektierteZeile]description]);
		tempLastLesernamen= [[rowData objectAtIndex:selektierteZeile]objectForKey:@"name"];
		//[AdminZeilenDic setObject:[[rowData objectAtIndex:selektierteZeile]objectForKey:@"name"] forKey:@"LasttName"];
		
	}//eine Zeile selektiert, eventuell Kommentar sichern
	
	//NSLog(@"rowData next Zeile: %d  Daten: %@",row, [[rowData objectAtIndex:row]description]);
	
	//NSLog(@"[AuswahlArray: %@",[[AuswahlArray objectAtIndex:row]description]);
	NSNotificationCenter * nc;
	nc=[NSNotificationCenter defaultCenter];
	[nc postNotificationName:@"AdminselektierteZeile" object:AdminZeilenDic];
	//NSLog(@"AdmintableView  shouldSelectRow ende: %d",row);
	//[[[tableView tableColumnWithIdentifier:@"aufnahmen"]dataCellForRow:row]action];
	
	return YES;
}
*/


@end
