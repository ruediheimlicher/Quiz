//
//  rErgebnisWindowController.m
//  Quiz
//
//  Created by Ruedi Heimlicher on 13.August.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "rErgebnisWindowController.h"
/*
@interface rErgebnisWindowController ()

@end
*/
@implementation rErgebnisWindowController

@synthesize nummerWert ;
@synthesize klasseWert ;

- (id)initWithWindow:(NSWindow *)window
{
   /*
    Fuer Files Owner in IB: Class einstellen
    */
   //NSLog(@"Ergebnis initWithWindow");
   self = [super initWithWindow:window];
   if (self) 
   {
      //NSLog(@"settings init ok: Fenster: %@",[window title]);
      // Initialization code here.
      
      DatenDic = [[NSMutableDictionary alloc]initWithCapacity:0];
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
  // [IndexTabelle setDelegate:self];
   //[IndexTabelle setDataSource:self];
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
	
   /*
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
*/
   // Create a prototype cell
   NSButtonCell*   prototypeButtonCell = [[NSButtonCell alloc] init];
   
   [prototypeButtonCell setButtonType:NSRadioButton];
   [prototypeButtonCell setEditable:NO];
   NSImage* bild = [NSImage imageNamed:@"okicon.png"];
   NSImage* altbild = [NSImage imageNamed:@"pauseicon.png"];
   [prototypeButtonCell setImage:bild];
   [prototypeButtonCell setAlternateImage:altbild];
   [prototypeButtonCell setImageScaling:NSImageScaleProportionallyDown];
  // [prototypeButtonCell setImageScaling:NSImageScaleNone];
   //[prototypeButtonCell setAction:@selector(reportRadiotaste:)];
   [prototypeButtonCell setImagePosition:NSImageOnly];
  
   
   
   //[[MasterErgebnistabelle tableColumnWithIdentifier:@"richtig"]setDataCell:prototypeButtonCell];
   NSImage* okbild = [NSImage imageNamed:@"okicon.png"];
   NSImage* pausealtbild = [NSImage imageNamed:@"pauseicon.png"];
 
   NSImageCell*   prototypeImageCell = [[NSImageCell alloc] initImageCell:okbild];
   //[prototypeImageCell setEditable:NO];
  // [prototypeImageCell setImage:okbild];
   [[MasterErgebnistabelle tableColumnWithIdentifier:@"richtig"]setDataCell:prototypeImageCell];
//   [MasterErgebnistabelle setIntercellSpacing:NSMakeSize(4.0f, 16.0f)];
   [MasterErgebnistabelle setDelegate:self];
   [MasterErgebnistabelle setDataSource:self];
   [MasterErgebnistabelle reloadData];
}



- (void)setDaten:(NSMutableDictionary*)datendic
{
   DatenDic = (NSMutableDictionary*)datendic;
   //NSLog(@"setDaten Datendic: %@",[[DatenDic objectForKey:@"masterergebnisarray"] description]);
   NSLog(@"setDaten Datendic: %@",[DatenDic description]);
   
   if ([DatenDic objectForKey:@"klasse"])
   {
      [Klassefeld setIntValue:[[DatenDic objectForKey:@"klasse"]intValue]];
      
      self.klasseWert = [[DatenDic objectForKey:@"klasse"]intValue];
      switch (self.klasseWert) 
      {
         case 1:
         {
            [Leveltextfeld setStringValue:@"Standard"];
         } break;
         case 2:
         {
            [Leveltextfeld setStringValue:@"Master"];
         } break;
         case 3:
         {
            [Leveltextfeld setStringValue:@"Expert"];
         } break;
            
         default:
         {
            [Leveltextfeld setStringValue:@"-"];
         } break;
            
            
            
      }

   }
    
   if ([DatenDic objectForKey:@"nummer"])
   {
      // [Nummerfeld setIntValue:[[DatenDic objectForKey:@"nummer"]intValue]];
      self.nummerWert = [[DatenDic objectForKey:@"nummer"]intValue];
   }
    
   if ([datendic objectForKey:@"masterergebnisarray"])
   {
      MasterErgebnisArray = [[NSMutableArray alloc]initWithArray:[datendic objectForKey:@"masterergebnisarray"]];
      
   }
   else 
   {
      
      return;
   }
   
   //NSLog(@" **  MasterErgebnisArray vor: %@",[MasterErgebnisArray description]);
   
   // FragenArray
   //NSLog(@"***");
   //NSLog(@"Settings setDaten %@",[IndexArray valueForKey:@"frage"]);
   //NSLog(@"***");
   
   int gesamt=0;
   if ([MasterErgebnisArray count])
   {
      for (int i=0;i<[MasterErgebnisArray count]; i++)
      {
         int richtig = [[[MasterErgebnisArray objectAtIndex:i]objectForKey:@"richtig"]intValue];
         //NSLog(@"Settings setDaten i: %d richtig: %d",i,richtig);
         if (richtig > 0)
         {
            //NSLog(@"Settings setDaten i: %d richtig zaehlt",i);
            gesamt += richtig;
         }
      }
   [Gesamtergebnisfeld setIntValue:gesamt];
   }
      
       
      
      
   
    [MasterErgebnistabelle reloadData];
   
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
 //  NSLog(@"reportClose IndexArray Musik m0: %@",[[IndexArray valueForKey:@"m0"]description]);
 //  NSLog(@"reportClose IndexArray Noten n0: %@",[[IndexArray valueForKey:@"n0"]description]);
 //  NSLog(@"reportClose IndexArray Fotos f0: %@",[[IndexArray valueForKey:@"f0"]description]);
 //  NSLog(@"reportClose IndexArray Epoche e0: %@",[[IndexArray valueForKey:@"e0"]description]);
   
   //NSLog(@"reportClose IndexArray vor up: %@",[IndexArray description]);
   
   // Daten aktualisieren
   //[self updateDaten];
   //NSLog(@"reportClose IndexArray nach up: %@",[IndexArray description]);
	
   NSNotificationCenter * nc;
   
	nc=[NSNotificationCenter defaultCenter];
   NSMutableDictionary* tempInfoDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       MasterErgebnisArray ,@"indexarray", 
                                       [NSNumber numberWithInt:self.klasseWert],@"klasse",
                                       [NSNumber numberWithInt:self.nummerWert],@"nummer",
                                       nil];
   
   
//	[nc postNotificationName:@"ErgebnisDaten" object:self userInfo:tempInfoDic];
   
   [[self window]orderOut:NULL];
   
}

- (IBAction)reportKlassestepper:(id)sender
{
   [MasterErgebnistabelle reloadData];
   switch ([sender intValue]) 
   {
      case 1:
      {
         [Leveltextfeld setStringValue:@"Standard"];
      } break;
      case 2:
      {
         [Leveltextfeld setStringValue:@"Master"];
      } break;
      case 3:
      {
         [Leveltextfeld setStringValue:@"Expert"];
      } break;

      default:
      {
         [Leveltextfeld setStringValue:@"-"];
      } break;

      
         
   }
}

#pragma mark TableView
- (NSArray*)rowData
{
   return rowData;
};

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
         if ([[[MasterErgebnisArray objectAtIndex:rowIndex]objectForKey:@"klasse"]intValue] == [Klassefeld intValue])
         {
            if ([[aTableColumn identifier]isEqual:@"richtig"])
            {
               //NSLog(@"objectValueForTableColumn rowIndex: %ld ident: %@ richtig: %d",rowIndex,[aTableColumn identifier],[[[MasterErgebnisArray objectAtIndex:rowIndex]objectForKey:@"richtig"]intValue]);
               if ([[[MasterErgebnisArray objectAtIndex:rowIndex]objectForKey:@"richtig"]intValue]>0)
               {
                  //NSLog(@"ok");
                  return [NSImage imageNamed:@"checkicon.png"];
               }
               else
               {
                  
                  //return [NSImage imageNamed:@"deleteicon.png"];
                  
                  if ([[MasterErgebnisArray objectAtIndex:rowIndex]objectForKey:@"wahl"]) // schon gewaehlt
                  {
                     long kol= [aTableView numberOfColumns]-1;
                     
                     
                     if ([[[MasterErgebnisArray objectAtIndex:rowIndex]objectForKey:@"wahlpos"]intValue] == kol)
                     {
                        return [NSImage imageNamed:NULL]; // Bild loeschen
                     } // if wahlpos
                     
                     if ([[[MasterErgebnisArray objectAtIndex:rowIndex]objectForKey:@"richtig"]intValue]==0) // falsch gewaehlt
                     {
                        return [NSImage imageNamed:@"deleteicon.png"];
                     }
                     
                     int wahl = [[[MasterErgebnisArray objectAtIndex:rowIndex]objectForKey:@"wahl"]intValue];
                     if (wahl >= 0 && wahl < 10)
                     {
                        
                        return [NSImage imageNamed:@"deleteicon.png"];
                     }
                     else
                     {
                        return [NSImage imageNamed:NULL]; // Bild loeschen
                     }
                     
                  }
                  
                  return [NSImage imageNamed:NULL];
               }
               
            }
            else // andere Kolonnen
            {
               return [[MasterErgebnisArray objectAtIndex:rowIndex]objectForKey:[aTableColumn identifier]];
            }
            
         }
         return NULL;
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
   //NSLog(@"setObjectValueForTableColumn ident: %@ row: %ld objectValue: %d",[aTableColumn identifier],rowIndex,[anObject intValue]);
   
   NSMutableDictionary* einDic;
   if (rowIndex<[MasterErgebnisArray count])
	{
		einDic=[MasterErgebnisArray objectAtIndex:rowIndex];
      NSString* ident = [aTableColumn identifier];
		[einDic setObject:anObject forKey:ident];
     // NSArray* keyArray = [einDic allKeys];

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
