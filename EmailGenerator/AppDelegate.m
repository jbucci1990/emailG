//
//  AppDelegate.m
//  EmailGenerator
//
//  Created by JJ Bucci on 2/3/15.
//  Copyright (c) 2015 JJ Bucci. All rights reserved.
//

#import "AppDelegate.h"
#import "UIUtils.h"
#import "DictionaryForTemplate.h"
#import "XPathUtils.h"
#import "HTTPEndpt.h"


@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    

    [self pullDayGames];
    [self setActiveRoster];


    
    self.managers = @{@"ARI":@"ARI Chip Hale",
                      @"ATL":@"ATL Fredi Gonzalez",
                      @"BAL":@"BAL Buck Showalter",
                      @"BOS":@"BOS John Farrell",
                      @"CWS":@"CWS Robin Ventura",
                      @"CHC":@"CHC Joe Maddon",
                      @"CLE":@"CLE Terry Francona",
                      @"CIN":@"CIN Bryan Price",
                      @"COL":@"COL Walter Weiss",
                      @"DET":@"DET Brad Ausmas",
                      @"HOU":@"HOU A.J. Hinch",
                      @"KC":@"KC Ned Yost",
                      @"LAD":@"LAD Don Mattingly",
                      @"LAA":@"LAA Mike Sciosica",
                      @"MIA":@"MIA Mike Redmond",
                      @"MIL":@"MIL Ron Roenicke",
                      @"MIN":@"MIN Paul Molitor",
                      @"NYM":@"NYM Terry Collins",
                      @"NYY":@"NYY Joe Giradi",
                      @"OAK":@"OAK Bob Melvin",
                      @"PHI":@"PHI Ryne Sandberg",
                      @"PIT":@"PIT Clint Hurdle",
                      @"SD":@"SD Bud Black",
                      @"SF":@"SF Bruce Bochy",
                      @"SEA":@"SEA Lloyd McClendon",
                      @"STL":@"STL Mike Matheny",
                      @"TB":@"TB Kevin Cash",
                      @"TEX":@"TEX Jeff Banister",
                      @"TOR":@"TOR John Gibbons",
                      @"WAS":@"WAS Matt Williams"};

    
    //Setting Button Arrays
    self.emptyArray = @[@"  "];
    self.typeOfChallenge = @[@"    ",
                                 @"Manager's Challenge",
                                 @"Umpire Review"];
    self.playType = @[@" ",
                          @"Force Play",
                          @"Tag Play",
                          @"Potential Home Run",
                          @"Potential Violation of Rule 7.13",
                          @"Hit By Pitch",
                          @"Catch/No Catch",
                          @"Fair/Foul"];
    self.playTagVariation = @[@"  ", @"Pick Off", @"Steal Attempt"];
    
   self.game = @[@" ",
                      @"WAS/LAD",
                      @"ATL/BAL"];
   self.inning = @[@" ",
                        @"T1", @"B1",
                        @"T2", @"B2",
                        @"T3", @"B3",
                        @"T4", @"B4",
                        @"T5", @"B5",
                        @"T6", @"B6",
                        @"T7", @"B7",
                        @"T8", @"B8",
                        @"T9", @"B9"];
    
    
    
    self.extraInnings = @[@"  ",
                          @"T10", @"B10",
                          @"T11", @"B11",
                          @"T12", @"B12",
                          @"T13", @"B13",
                          @"T14", @"B14",
                          @"T15", @"B15",
                          @"T16", @"B16",
                          @"T17", @"B17",
                          @"T18", @"B18",
                          @"T19", @"B19"];
   self.playLocation = @[@" ",
                              @"1B",
                              @"2B",
                              @"3B",
                              @"HP",
                              @"LF",
                              @"CF",
                              @"RF"];
  self.offenseDoesWhat = @[@" ",
                                 @"hits a groundball",
                                 @"hits a fly ball",
                                 @"attempts to steal"];
    
   self.defenseDoesWhat = @[@"   ",
                                 @"throws to",
                                 @"attempts to pick off",
                                 @"throws a pitch inside"];
    
   self.outcome = @[@"  ",
                         @"CONFIRMED",
                         @"STANDS",
                         @"OVERTURNED"];
   self.outsBefore = @[@"  ",
                            @"0",
                            @"1",
                            @"2"];
   self.outsAfter = @[@" ",
                           @"0",
                           @"1",
                           @"2",
                           @"3"];
    self.call = @[@"  ",
                      @"Safe",
                      @"Out"];
    self.callAfterCatch = @[@"  ", @"catch", @"no catch"];
    self.callAfterHomeRun = @[@"  ", @"home run", @"not a home run"];
    self.callAfterFairFoul = @[@"  ", @"fair", @"foul"];
    self.callAfterHitByPitch = @[@"  ", @"hit by pitch", @"not hit by pitch"];
    self.callAFterViolation = @[@"  ", @"Violation of Rule 7.13", @"No Violation of Rule 7.13"];
    self.runnersOnBefore = @[@"  ",
                                 @"No runners on",
                                 @"runner on 1B",
                                 @"runner on 2B",
                                 @"runner on 3B",
                                 @"runners on 1B and 2B",
                                 @"runners on 1B and 3B",
                                 @"runners on 2B and 3B",
                                 @"bases Loaded"];
    
    self.runnersOnAfter = @[@"  ",
                             @"No runners on",
                             @"runner on 1B",
                             @"runner on 2B",
                             @"runner on 3B",
                             @"runners on 1B and 2B",
                             @"runners on 1B and 3B",
                             @"runners on 2B and 3B",
                             @"bases Loaded",
                            @"end of inning"];

    
    self.washNationals = @[@"  ", @"1B - Ryan Zimmerman", @"2B - Danny Espinosa", @"3B - Anthony Rendon", @"SS - Ian Desmond", @"LF -Bryce Harper", @"CF - Denard Span", @"RF - Jayson Werth", @"C - Wilson Ramos", @"P - Max Scherzer"];
    
    self.laDodgers = @[@"  ", @"1B - Adrian Gonzalez", @"2B - Howie Kendrick", @"3B - Juan Uribe", @"SS - Jimmy Rollins", @"LF - Carl Crawford", @"CF - Joc Pederson", @"RF - Yasiel Puig",@"C - Yasmani Grandal", @"P - Clayton Kershaw"];
    
    self.atlBraves = @[@"  ", @"1B Freddie Freeman", @"2B Alberto Callaspo", @"3B Chris Johnson", @"SS Andrelton Simmons", @"LF Jonny Gomes", @"CF BJ Upton", @"RF Nick Markasis", @"C Christian Bethancourt", @"P Julio Teheran"];
    
    self.balOrioles = @[@"  ", @"1B Steve Pearce", @"2B Jonathan Schoop", @"3B Manny Machado", @"SS J.J. Hardy", @"LF Alejandro De Aza", @"CF Adam Jones", @"RF Travis Snider", @"C Caleb Joseph", @"P Chris Tillman", @"DH Delmon Young"];
    
    self.teams = @[@"  ", @"WAS", @"LAD"];
    self.teams2 = @[@"  ", @"ATL", @"BAL"];
    
    self.whoChallenging = @[@"  ", @" WAS Matt Williams", @"LAD Don Mattingly"];
    
    
    
    
    
   
    //Iniating all push buttons
    
    
    [UIUtils initPopUpButton:self.playTypeOptionsPopUpButton selections:self.playType defaultIndex:0];
    [UIUtils initPopUpButton:self.playVariation selections:self.emptyArray defaultIndex:0];
    
    [UIUtils initPopUpButton:self.challengeTypePopUpButton selections:self.typeOfChallenge defaultIndex:0];
    
    [self.challengeTypePopUpButton selectItemAtIndex:0];
    [UIUtils initPopUpButton:self.gameTypePopUpButton selections:self.gameDayArray defaultIndex:0];
    [self.challengeTypePopUpButton selectItemAtIndex:0];
    [UIUtils initPopUpButton:self.inningPopUpButton selections:self.inning defaultIndex:0];
    [self.inningPopUpButton selectItemAtIndex:0];
    [UIUtils initPopUpButton:self.outsBeforePopUpButton selections:self.outsBefore defaultIndex:0];
    [self.outsBeforePopUpButton selectItemAtIndex:0];
    [UIUtils initPopUpButton:self.runnersOnBeforePopUpButton selections:self.runnersOnBefore defaultIndex:0];
    [self.runnersOnBeforePopUpButton selectItemAtIndex:0];
    [UIUtils initPopUpButton:self.whoChallengedPopUpButton selections:self.emptyArray defaultIndex:0];
    [UIUtils initPopUpButton:self.homePlayerNamePopUpButton selections:self.emptyArray defaultIndex:0];
    [UIUtils initPopUpButton:self.homePlayerName2PopUpButton selections:self.emptyArray defaultIndex:0];
    [UIUtils initPopUpButton:self.awayPlayerNamePopUpButton selections:self.emptyArray defaultIndex:0];
    [UIUtils initPopUpButton:self.awayPlayerName2PopUpButton selections:self.emptyArray defaultIndex:0];

    
    [UIUtils initPopUpButton:self.offenseTeamPopUpButton selections:self.emptyArray defaultIndex:0];
    [UIUtils initPopUpButton:self.defenseTeamPopUpButton selections:self.emptyArray defaultIndex:0];
    
    [UIUtils initPopUpButton:self.offenseDoesWhatPopUpButton selections:self.offenseDoesWhat defaultIndex:0];
    [UIUtils initPopUpButton:self.defenseDoesWhatPopUpButton selections:self.defenseDoesWhat defaultIndex:0];
    [UIUtils initPopUpButton:self.callOnFieldPopUpButton selections:self.call defaultIndex:0];
    [UIUtils initPopUpButton:self.playLocationPopUpButton selections:self.playLocation defaultIndex:0];
    [UIUtils initPopUpButton:self.callAfterReviewPopUpButton selections:self.call defaultIndex:0];
    [UIUtils initPopUpButton:self.outcomePopUpButton selections:self.outcome defaultIndex:0];
    [UIUtils initPopUpButton:self.outsAfterPopUpButton selections:self.outsAfter defaultIndex:0];
    [UIUtils initPopUpButton:self.runnersOnAfterPopUpButton selections:self.runnersOnAfter defaultIndex:0];
    [UIUtils initPopUpButton:self.offenseDoesWhat2PopUpButton selections:self.offenseDoesWhat defaultIndex:0];
    [UIUtils initPopUpButton:self.defenseDoesWhat2PopUpButton selections:self.defenseDoesWhat defaultIndex:0];
    

    
    
    // Insert code here to initialize your application
    // Bringing in the first Template
    NSString *resourcesBasePath = [[NSBundle mainBundle] resourcePath];
//
    NSMutableString *emailTemplateString = [NSString stringWithContentsOfFile:[resourcesBasePath stringByAppendingString:@"/emailTemplate.txt"]];
    NSMutableString *emailSubjectString = [NSString stringWithContentsOfFile:[resourcesBasePath stringByAppendingString:@"/EmailSubject.txt"]];
//    NSMutableString *emailTemplateString = [[NSMutableString alloc]initWithString:@"Welcome to the App"];
    
    //Setting up the Method for replacing strings in Templates

    self.dictionaryForTemplate = [DictionaryForTemplate new];
    self.dictionaryForTemplate.emailSubjectText = emailSubjectString;
    self.dictionaryForTemplate.templateText = emailTemplateString;

    self.currentStateDict = [NSMutableDictionary new];
    
    
//    
//    if ([self.callOnFieldPopUpButton selectedItem] == [self.callAfterReviewPopUpButton selectedItem] ) {
//        NSLog(@"Working as inteneded");
//        
//        [self.outcomePopUpButton setAutoenablesItems:NO];
//        [[self.outcomePopUpButton itemAtIndex:2] setEnabled:(NO)];
//    }

    
    
    // Creating the currentState Dict Defaults
    
    
//    NSString *str = @"TESTING";
//    
//    NSMutableAttributedString *attrstr = [[NSMutableAttributedString alloc] initWithString:str];
//    NSDictionary *attributess = @{
//                                 NSForegroundColorAttributeName : [NSColor blueColor],
//                                 NSFontAttributeName : [NSFont fontWithName:@"HelveticaNeue-Bold" size:20.f]
//                                 };
//    [attrstr setAttributes:attributess range:NSMakeRange(0, str.length)];
//
//    
    
    
    [self setDefaultLines];
    
    
    NSDictionary *attributes = @{
                                 NSForegroundColorAttributeName : [NSColor blueColor],
                                 NSFontAttributeName : [NSFont fontWithName:@"HelveticaNeue-Bold" size:20.f]
                                 };
    
    

  
    
   }

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

/// Defining Button Tags

#define PLAYTYPE_TAG 10
#define PLAYVARIATION_TAG 11
#define CHALLENGETYPE_TAG 12
#define GAME_TAG 13
#define INNING_TAG 14
#define OUTSBEFORE_TAG 15
#define RUNNERSBEFORE_TAG 16
#define OFFENSIVETEAM_TAG 17
#define OFFENSIVEPLAYER_TAG 18
#define OFFENSEDOESWHAT_TAG 19
#define OFFENSIVEPLAYER2_TAG 20
#define OFFENSEDOESWHAT2_TAG 21
#define DEFENSIVETEAM_TAG 22
#define DEFENSIVEPLAYER_TAG 23
#define DEFENSEDOESWHAT_TAG 24
#define DEFENSIVEPLAYER2_TAG 25
#define DEFENSEDOESWHAT2_TAG 26
#define WHOCHALLENGED_TAG 27
#define CALLONFIELD_TAG 28
#define PLAYLOCATION_TAG 29
#define CALLAFTER_TAG 30
#define OUTCOME_TAG 31
#define OUTSAFTER_TAG 32
#define RUNNERSAFTER_TAG -1
#define RESET_TAG 60
#define EXTRAINNINGS_TAG 61
#define COPYBUTTON_TAG 62

-(IBAction)popUpClicked:(id)sender
{
    int tag = [sender tag];
    int selectedItem = [(NSPopUpButton*)sender indexOfSelectedItem];

    if (selectedItem == -1)
        return;

    self.selectedString = [(NSPopUpButton*)sender titleOfSelectedItem];


    
    
        if (tag == PLAYVARIATION_TAG)
    {
        if ([self.selectedString isEqualTo:@"Pick Off"]) {
            [self enableAll];


            NSString *resourcesBasePath = [[NSBundle mainBundle] resourcePath];

            NSMutableString *emailTemplateString = [NSString stringWithContentsOfFile:[resourcesBasePath stringByAppendingString:@"/PickOffAttempt.txt"]];
            self.dictionaryForTemplate.templateText = emailTemplateString;
            [self.offenseDoesWhatPopUpButton setEnabled:(NO)];
            [self.defenseDoesWhatPopUpButton setEnabled:(NO)];
            [self.defenseDoesWhat2PopUpButton setEnabled:(NO)];
            [self.awayPlayerName2PopUpButton setEnabled:(NO)];
            [self.homePlayerName2PopUpButton setEnabled:(NO)];
            [self.offenseDoesWhat2PopUpButton setEnabled:(NO)];
            




}
        if ([self.selectedString isEqualTo:@"Steal Attempt"]) {
            [self enableAll];

            NSString *resourcesBasePath = [[NSBundle mainBundle] resourcePath];
            
            NSMutableString *emailTemplateString = [NSString stringWithContentsOfFile:[resourcesBasePath stringByAppendingString:@"/StealAttempt.txt"]];
            self.dictionaryForTemplate.templateText = emailTemplateString;
            [self.defenseDoesWhat2PopUpButton setEnabled:(NO)];
            [self.defenseDoesWhatPopUpButton setEnabled:(NO)];
            [self.awayPlayerName2PopUpButton setEnabled:(NO)];
            [self.offenseDoesWhatPopUpButton setEnabled:(NO)];
            [self.homePlayerName2PopUpButton setEnabled:(NO)];
            [self.offenseDoesWhat2PopUpButton setEnabled:(NO)];


//            NSArray *stealArray = @[[self.offenseDoesWhat objectAtIndex:3]];
//            [UIUtils initPopUpButton:self.offenseDoesWhatPopUpButton selections:stealArray defaultIndex:0];
//            
            
        }

        
        



    }
    
    if (tag == PLAYTYPE_TAG)
    {
        if ([self.selectedString isEqualTo:@"Force Play"]) {
            [self enableAll];
            NSString *resourcesBasePath = [[NSBundle mainBundle] resourcePath];
            
            NSMutableString *emailTemplateString = [NSString stringWithContentsOfFile:[resourcesBasePath stringByAppendingString:@"/emailTemplate.txt"]];
            self.dictionaryForTemplate.templateText = emailTemplateString;
            [self.challengeTypePopUpButton setEnabled:(YES)];
            [UIUtils initPopUpButton:self.callAfterReviewPopUpButton selections:self.call defaultIndex:0];
            [UIUtils initPopUpButton:self.callOnFieldPopUpButton selections:self.call defaultIndex:0];
            [self.homePlayerName2PopUpButton setEnabled:(NO)];
            [self.offenseDoesWhat2PopUpButton setEnabled:(NO)];



            [self.playVariation setEnabled:(NO)];
        }
        
        if ([self.selectedString isEqualTo:@"Tag Play"]) {
            [self enableAll];

            NSString *resourcesBasePath = [[NSBundle mainBundle] resourcePath];
            
            NSMutableString *emailTemplateString = [NSString stringWithContentsOfFile:[resourcesBasePath stringByAppendingString:@"/PleasePickVariation.txt"]];
            self.dictionaryForTemplate.templateText = emailTemplateString;
            [self.playVariation setEnabled:(YES)];

            [UIUtils initPopUpButton:self.playVariation selections:self.playTagVariation defaultIndex:0];
            [UIUtils initPopUpButton:self.callAfterReviewPopUpButton selections:self.call defaultIndex:0];
            [UIUtils initPopUpButton:self.callOnFieldPopUpButton selections:self.call defaultIndex:0];
            [self.homePlayerName2PopUpButton setEnabled:(NO)];
            [self.offenseDoesWhat2PopUpButton setEnabled:(NO)];




        }
        
        if ([self.selectedString isEqualTo:@"Potential Home Run"]) {
            [self enableAll];

            NSString *resourcesBasePath = [[NSBundle mainBundle] resourcePath];
            
            NSMutableString *emailTemplateString = [NSString stringWithContentsOfFile:[resourcesBasePath stringByAppendingString:@"/PotentialHomeRun.txt"]];
            self.dictionaryForTemplate.templateText = emailTemplateString;
            [self.challengeTypePopUpButton setEnabled:(NO)];
            [self.playVariation setEnabled:(NO)];
            [self.defenseTeamPopUpButton setEnabled:NO];
            [self.defenseDoesWhatPopUpButton setEnabled:NO];
            [self.defenseDoesWhat2PopUpButton setEnabled:NO];
            [self.awayPlayerNamePopUpButton setEnabled:NO];
            [self.awayPlayerName2PopUpButton setEnabled:NO];
            [self.whoChallengedPopUpButton setEnabled:NO];
            [self.homePlayerName2PopUpButton setEnabled:(NO)];
            [self.offenseDoesWhat2PopUpButton setEnabled:(NO)];


            [UIUtils initPopUpButton:self.callAfterReviewPopUpButton selections:self.callAfterHomeRun defaultIndex:0];
            [UIUtils initPopUpButton:self.callOnFieldPopUpButton selections:self.callAfterHomeRun defaultIndex:0];
//            NSArray *forHomeRun = [[NSArray alloc]initWithObjects:[self.offenseDoesWhat objectAtIndex:1]];            [UIUtils initPopUpButton:self.offenseDoesWhatPopUpButton selections:forHomeRun defaultIndex:0];
//
//
        }
        

        
        if ([self.selectedString isEqualTo:@"Potential Violation of Rule 7.13"]) {
            [self enableAll];

            NSString *resourcesBasePath = [[NSBundle mainBundle] resourcePath];
            
            NSMutableString *emailTemplateString = [NSString stringWithContentsOfFile:[resourcesBasePath stringByAppendingString:@"/Potential713.txt"]];
            self.dictionaryForTemplate.templateText = emailTemplateString;
            [self.playVariation setEnabled:(NO)];
            [UIUtils initPopUpButton:self.callAfterReviewPopUpButton selections:self.callAFterViolation defaultIndex:0];
            [UIUtils initPopUpButton:self.callOnFieldPopUpButton selections:self.callAFterViolation defaultIndex:0];
            



           
            



            [self.playVariation setEnabled:(NO)];
            


        }
        
        if ([self.selectedString isEqualTo:@"Hit By Pitch"]) {
            [self enableAll];
            NSString *resourcesBasePath = [[NSBundle mainBundle] resourcePath];
            
            NSMutableString *emailTemplateString = [NSString stringWithContentsOfFile:[resourcesBasePath stringByAppendingString:@"/HitByPitch.txt"]];
            self.dictionaryForTemplate.templateText = emailTemplateString;
            [self.challengeTypePopUpButton setEnabled:(YES)];
            [UIUtils initPopUpButton:self.callAfterReviewPopUpButton selections:self.callAfterHitByPitch defaultIndex:0];
            [UIUtils initPopUpButton:self.callOnFieldPopUpButton selections:self.callAfterHitByPitch defaultIndex:0];
            [self.homePlayerName2PopUpButton setEnabled:(NO)];
            [self.offenseDoesWhat2PopUpButton setEnabled:(NO)];
            [self.awayPlayerName2PopUpButton setEnabled:NO];
            [self.defenseDoesWhat2PopUpButton setEnabled:NO];
            [self.defenseDoesWhatPopUpButton setEnabled:NO];
            [self.offenseDoesWhatPopUpButton setEnabled:NO];



            
            
            
            [self.playVariation setEnabled:(NO)];
            
            
//            [self.inningPopUpButton setAutoenablesItems:NO];
//            [[self.inningPopUpButton itemAtIndex:1] setEnabled:(NO)];
        }

        if ([self.selectedString isEqualTo:@"Fair/Foul"]) {
            [self enableAll];

            NSString *resourcesBasePath = [[NSBundle mainBundle] resourcePath];
            
            NSMutableString *emailTemplateString = [NSString stringWithContentsOfFile:[resourcesBasePath stringByAppendingString:@"/FairFoul.txt"]];
            self.dictionaryForTemplate.templateText = emailTemplateString;
            [self.challengeTypePopUpButton setEnabled:(YES)];

            [self.playVariation setEnabled:(NO)];
            [UIUtils initPopUpButton:self.callAfterReviewPopUpButton selections:self.callAfterFairFoul defaultIndex:0];
            [UIUtils initPopUpButton:self.callOnFieldPopUpButton selections:self.callAfterFairFoul defaultIndex:0];
            [self.homePlayerName2PopUpButton setEnabled:(NO)];
            [self.offenseDoesWhat2PopUpButton setEnabled:(NO)];



        }

        if ([self.selectedString isEqualTo:@"Catch/No Catch"]) {
            [self enableAll];

            NSString *resourcesBasePath = [[NSBundle mainBundle] resourcePath];
            
            NSMutableString *emailTemplateString = [NSString stringWithContentsOfFile:[resourcesBasePath stringByAppendingString:@"/CatchNoCatch.txt"]];
            self.dictionaryForTemplate.templateText = emailTemplateString;
            [self.challengeTypePopUpButton setEnabled:(YES)];

            [self.playVariation setEnabled:(NO)];
            [UIUtils initPopUpButton:self.callAfterReviewPopUpButton selections:self.callAfterCatch defaultIndex:0];
            [UIUtils initPopUpButton:self.callOnFieldPopUpButton selections:self.callAfterCatch defaultIndex:0];
            [self.homePlayerName2PopUpButton setEnabled:(NO)];
            [self.offenseDoesWhat2PopUpButton setEnabled:(NO)];



        }

        


        
        
        [self.currentStateDict setValue:self.selectedString forKey:@"playtype"];
        NSLog([self.currentStateDict valueForKey:@"playtype"]);
        
    }

    if (tag == CHALLENGETYPE_TAG)
    {
        if ([self.selectedString  isEqual: @"Manager's Challenge"]) {
            NSLog(@"Change the manager");
            [self.whoChallengedPopUpButton setEnabled:YES];
            
            }
        if ([self.selectedString  isEqual: @"Umpire Review"]) {
            
           

            [UIUtils initPopUpButton:self.whoChallengedPopUpButton selections:self.emptyArray defaultIndex:0];

            [self.whoChallengedPopUpButton setEnabled:NO
             ];
            }
        [self.currentStateDict setObject:self.selectedString forKey:@"challengetype"];
        
        NSLog([self.currentStateDict valueForKey:@"challengetype"]);

    }
    if (tag == GAME_TAG)
    {
        
        [self SetTeamChoice];


        
            [UIUtils initPopUpButton:self.homePlayerNamePopUpButton selections:self.emptyArray defaultIndex:0];
            [UIUtils initPopUpButton:self.awayPlayerNamePopUpButton selections:self.emptyArray defaultIndex:0];
            [UIUtils initPopUpButton:self.awayPlayerName2PopUpButton selections:self.emptyArray defaultIndex:0];
            [self.currentStateDict setObject:@"___________" forKey:@"offensiveplayer"];
            [self.currentStateDict setObject:@"___________" forKey:@"defensiveplayer"];
            [self.currentStateDict setObject:@"___________" forKey:@"defensiveplayer2"];


            

            
    
            
      



            
            
            
    

        [self.currentStateDict setObject:self.selectedString forKey:@"game"];
        NSLog([self.currentStateDict valueForKey:@"game"]);


    }
    if (tag == INNING_TAG)
    {
        [self.currentStateDict setObject:self.selectedString forKey:@"inning"];
        
        NSLog([self.currentStateDict valueForKey:@"inning"]);

        
    }
    if (tag == OUTSBEFORE_TAG)
    {
        [self.currentStateDict setObject:self.selectedString forKey:@"outsbefore"];
        NSLog([self.currentStateDict valueForKey:@"outsbefore"]);
        NSMutableArray *oneOutBefore = [[NSMutableArray alloc]initWithArray:self.outsAfter];
        [oneOutBefore removeObjectAtIndex:1];
        NSMutableArray *twoOutBefore = [[NSMutableArray alloc]initWithArray:self.outsAfter];
        [twoOutBefore removeObjectAtIndex:(1)];
        [twoOutBefore removeObjectAtIndex:(1)];

        
        
        
        if ([self.selectedString isEqualToString:@"0"]) {
            [UIUtils initPopUpButton:self.outsAfterPopUpButton selections:self.outsAfter defaultIndex:0];
        }
        if ([self.selectedString isEqualToString:@"1"]) {
            [UIUtils initPopUpButton:self.outsAfterPopUpButton selections:oneOutBefore defaultIndex:0];
        }
        if ([self.selectedString isEqualToString:@"2"]) {
            [UIUtils initPopUpButton:self.outsAfterPopUpButton selections:twoOutBefore defaultIndex:0];
        }

        
    }
    if (tag == RUNNERSBEFORE_TAG)
    {
        [self.currentStateDict setObject:self.selectedString forKey:@"runnersbefore"];
        NSLog([self.currentStateDict valueForKey:@"runnersbefore"]);

        
    }
    if (tag == OFFENSIVETEAM_TAG)
    {
        
   for (NSString *key in self.completeTeamRosters)
   {
    NSArray *value = [self.completeTeamRosters objectForKey:key];
       if ([key isEqualTo:self.selectedString]) {
           [UIUtils initPopUpButton:self.homePlayerNamePopUpButton selections:value defaultIndex:0];
           [UIUtils initPopUpButton:self.homePlayerName2PopUpButton selections:value defaultIndex:0];

           
       }
   }
       
//    if ([self.selectedString isEqualTo: @"WAS"]) {
//        NSLog(@"SELECTED WASHINGTON");
//        [UIUtils initPopUpButton:self.homePlayerNamePopUpButton selections:self.washNationals defaultIndex:0];
//        [UIUtils initPopUpButton:self.homePlayerName2PopUpButton selections:self.washNationals defaultIndex:0];
//
//
//    }
//        if ([self.selectedString isEqualTo: @"LAD"]) {
//            [UIUtils initPopUpButton:self.homePlayerNamePopUpButton selections:self.laDodgers defaultIndex:0];
//            [UIUtils initPopUpButton:self.homePlayerName2PopUpButton selections:self.laDodgers defaultIndex:0];
//
//
//        }
//        
//        if ([self.selectedString isEqualTo: @"ATL"]) {
//            NSLog(@"SELECTED WASHINGTON");
//            [UIUtils initPopUpButton:self.homePlayerNamePopUpButton selections:self.atlBraves defaultIndex:0];
//            [UIUtils initPopUpButton:self.homePlayerName2PopUpButton selections:self.atlBraves defaultIndex:0];
//            
//            
//        }
//        if ([self.selectedString isEqualTo: @"BAL"]) {
//            NSLog(@"SELECTED WASHINGTON");
//            [UIUtils initPopUpButton:self.homePlayerNamePopUpButton selections:self.balOrioles defaultIndex:0];
//            [UIUtils initPopUpButton:self.homePlayerName2PopUpButton selections:self.balOrioles defaultIndex:0];
//            
//            
//        }


        if (selectedItem == 0) {
            [UIUtils initPopUpButton:self.homePlayerNamePopUpButton selections:self.emptyArray defaultIndex:0];
            [UIUtils initPopUpButton:self.homePlayerName2PopUpButton selections:self.emptyArray defaultIndex:0];


        }
        [self.currentStateDict setObject:self.selectedString forKey:@"offenseteam"];
        NSLog([self.currentStateDict valueForKey:@"offenseteam"]);


    }
    if (tag == OFFENSIVEPLAYER_TAG)
    {
        [self.currentStateDict setObject:self.selectedString forKey:@"offensiveplayer"];
        NSLog([self.currentStateDict valueForKey:@"offenseplayer"]);

        
    }
    if (tag == OFFENSEDOESWHAT_TAG)
    {
        [self.currentStateDict setObject:self.selectedString forKey:@"offensedoeswhat"];
        NSLog([self.currentStateDict valueForKey:@"offensedoeswhat"]);

        
    }
    if (tag == OFFENSIVEPLAYER2_TAG)
    {
        [self.currentStateDict setObject:self.selectedString forKey:@"offensiveplayer2"];
        NSLog([self.currentStateDict valueForKey:@"offensiveplayer2"]);

        
    }
    if (tag == OFFENSEDOESWHAT2_TAG)
    {
        [self.currentStateDict setObject:self.selectedString forKey:@"offensedoeswhat2"];
        NSLog([self.currentStateDict valueForKey:@"offensedoeswhat2"]);

        
    }


     if (tag == DEFENSIVETEAM_TAG)
     {
         for (NSString *key in self.completeTeamRosters)
         {
             NSArray *value = [self.completeTeamRosters objectForKey:key];
             if ([key isEqualTo:self.selectedString]) {
                 [UIUtils initPopUpButton:self.awayPlayerNamePopUpButton selections:value defaultIndex:0];
                 [UIUtils initPopUpButton:self.awayPlayerName2PopUpButton selections:value defaultIndex:0];
                 
                 
             }
         }
//         if ([self.selectedString isEqualTo: @"WAS"]) {
//             NSLog(@"SELECTED WASHINGTON");
//             [UIUtils initPopUpButton:self.awayPlayerNamePopUpButton selections:self.washNationals defaultIndex:0];
//             [UIUtils initPopUpButton:self.awayPlayerName2PopUpButton selections:self.washNationals defaultIndex:0];
//             
//         }
//         if ([self.selectedString isEqualTo: @"LAD"]) {
//             [UIUtils initPopUpButton:self.awayPlayerNamePopUpButton selections:self.laDodgers defaultIndex:0];
//             [UIUtils initPopUpButton:self.awayPlayerName2PopUpButton selections:self.laDodgers defaultIndex:0];
//
//             
//         }
//         if ([self.selectedString isEqualTo: @"ATL"]) {
//             [UIUtils initPopUpButton:self.awayPlayerNamePopUpButton selections:self.atlBraves defaultIndex:0];
//             [UIUtils initPopUpButton:self.awayPlayerName2PopUpButton selections:self.atlBraves defaultIndex:0];
//             
//             
//         }
//         
//         if ([self.selectedString isEqualTo: @"BAL"]) {
//             [UIUtils initPopUpButton:self.awayPlayerNamePopUpButton selections:self.balOrioles defaultIndex:0];
//             [UIUtils initPopUpButton:self.awayPlayerName2PopUpButton selections:self.balOrioles defaultIndex:0];
//             
         
//         }


         if (selectedItem == 0) {
             [UIUtils initPopUpButton:self.awayPlayerNamePopUpButton selections:self.emptyArray defaultIndex:0];
             [UIUtils initPopUpButton:self.awayPlayerName2PopUpButton selections:self.emptyArray defaultIndex:0];

             
         }
         [self.currentStateDict setObject:self.selectedString forKey:@"defenseteam"];
         NSLog([self.currentStateDict valueForKey:@"defensiveteam"]);

   
     }
    if (tag == DEFENSIVEPLAYER_TAG)
    {
        [self.currentStateDict setObject:self.selectedString forKey:@"defensiveplayer"];
        NSLog([self.currentStateDict valueForKey:@"defensiveplayer"]);
    }
    

    
    if (tag == DEFENSEDOESWHAT_TAG)
    {
        [self.currentStateDict setObject:self.selectedString forKey:@"defensedoeswhat"];
        NSLog([self.currentStateDict valueForKey:@"defensedoeswhat"]);

        
    }
    if (tag == DEFENSIVEPLAYER2_TAG)
        {
        [self.currentStateDict setObject:self.selectedString forKey:@"defensiveplayer2"];
        NSLog([self.currentStateDict valueForKey:@"defensiveplayer2"]);

            
        }
    if (tag == DEFENSEDOESWHAT2_TAG)
        {
        [self.currentStateDict setObject:self.selectedString forKey:@"defensedoeswhat2"];
        NSLog([self.currentStateDict valueForKey:@"defensedoeswhat2"]);

            
        }
    if (tag == WHOCHALLENGED_TAG)
        {
        [self.currentStateDict setObject:self.selectedString forKey:@"whochallenged"];
        NSLog([self.currentStateDict valueForKey:@"whochalleneged"]);

            
        }
    if (tag == CALLONFIELD_TAG)
        {
        [self.currentStateDict setObject:self.selectedString forKey:@"callonfield"];
        NSLog([self.currentStateDict valueForKey:@"callonfield"]);
            [self compareCalls];


            
        }
    if (tag == PLAYLOCATION_TAG)
        {
        [self.currentStateDict setObject:self.selectedString forKey:@"playlocation"];
        NSLog([self.currentStateDict valueForKey:@"playlocation"]);

            
        }
    if (tag == CALLAFTER_TAG)
        {
        [self.currentStateDict setObject:self.selectedString forKey:@"callafter"];
        NSLog([self.currentStateDict valueForKey:@"callafter"]);
            [self compareCalls];


            
        }
    if (tag == OUTCOME_TAG)
        {
        [self.currentStateDict setObject:self.selectedString forKey:@"outcome"];
        NSLog([self.currentStateDict valueForKey:@"outcome"]);


            
        }
    if (tag == OUTSAFTER_TAG)
        {
        [self.currentStateDict setObject:self.selectedString forKey:@"outsafter"];
        NSLog([self.currentStateDict valueForKey:@"outsafter"]);

            
        }
    if (tag == RUNNERSAFTER_TAG)
        {
            [self.currentStateDict setObject:self.selectedString forKey:@"runnersafter"];
            NSLog([self.currentStateDict valueForKey:@"runnerssafter"]);
        }

    
    
    
    
 

    [self updateOutput];


    

   }

-(void)updateOutput   // UPDATES TEMPLATE AFTER EACH BUTTON CLICK
{
    NSMutableAttributedString *emailString = [self.dictionaryForTemplate makeEmail:self.currentStateDict];
    NSString *subjectString = [self.dictionaryForTemplate makeSubject:self.currentStateDict];
    [self.emailTextView.textStorage setAttributedString: emailString];
    [self.subjectTextField setStringValue:subjectString];
}



-(void)enableAll   // ENABLES ALL BUTTON TO ACTIVE
{
    [self.playVariation setEnabled:(YES)];
    [self.playTypeOptionsPopUpButton setEnabled:(YES)];
    [self.challengeTypePopUpButton setEnabled:(YES)];
    [self.gameTypePopUpButton setEnabled:(YES)];
    [self.inningPopUpButton setEnabled:(YES)];
    [self.outsBeforePopUpButton setEnabled:(YES)];
    [self.runnersOnBeforePopUpButton setEnabled:(YES)];
    [self.whoChallengedPopUpButton setEnabled:(YES)];
    [self.homePlayerNamePopUpButton setEnabled:(YES)];
    [self.homePlayerName2PopUpButton setEnabled:(YES)];
    [self.awayPlayerNamePopUpButton setEnabled:(YES)];
    [self.awayPlayerName2PopUpButton setEnabled:(YES)];
    [self.offenseTeamPopUpButton setEnabled:(YES)];
    [self.defenseTeamPopUpButton setEnabled:(YES)];
    [self.defenseDoesWhatPopUpButton setEnabled:(YES)];
    [self.callOnFieldPopUpButton setEnabled:(YES)];
    [self.playLocationPopUpButton setEnabled:(YES)];
    [self.callAfterReviewPopUpButton setEnabled:(YES)];
    [self.outcomePopUpButton setEnabled:(YES)];
    [self.outsAfterPopUpButton setEnabled:(YES)];
    [self.runnersOnAfterPopUpButton setEnabled:(YES)];
    [self.offenseDoesWhatPopUpButton setEnabled:(YES)];
    [self.offenseDoesWhat2PopUpButton setEnabled:(YES)];
    [self.defenseDoesWhat2PopUpButton setEnabled:(YES)];
    [self.homePlayerName2PopUpButton setEnabled:(YES)];
    [self.offenseDoesWhat2PopUpButton setEnabled:(YES)];



}



-(void)setDefaultLines    // SETS LINES BACK TO DEFAULT
{
    [self.currentStateDict setObject:@"________" forKey:@"playtype"];
    //    [self.currentStateDict setObject: attrstr forKey:@"challengetype"];
    [self.currentStateDict setObject:@"__________" forKey:@"challengetype"];
    [self.currentStateDict setObject:@"_________" forKey:@"game"];
    [self.currentStateDict setObject:@"___________" forKey:@"inning"];
    [self.currentStateDict setObject:@"___" forKey:@"outsbefore"];
    [self.currentStateDict setObject:@"___" forKey:@"runnersbefore"];
    [self.currentStateDict setObject:@"____" forKey:@"offenseteam"];
    [self.currentStateDict setObject:@"____________" forKey:@"offensedoeswhat"];
    [self.currentStateDict setObject:@"___________" forKey:@"offensiveplayer"];
    [self.currentStateDict setObject:@"____________" forKey:@"offensedoeswhat2"];
    [self.currentStateDict setObject:@"___________" forKey:@"offensiveplayer2"];
    [self.currentStateDict setObject:@"______" forKey:@"defenseteam"];
    [self.currentStateDict setObject:@"___________" forKey:@"defensiveplayer"];
    [self.currentStateDict setObject:@"_____________" forKey:@"defensedoeswhat"];
    
    [self.currentStateDict setObject:@"___________" forKey:@"defensiveplayer2"];
    [self.currentStateDict setObject:@"________________" forKey:@"defensedoeswhat2"];
    [self.currentStateDict setObject:@"_____" forKey:@"playlocation"];
    [self.currentStateDict setObject:@"_____" forKey:@"callonfield"];
    [self.currentStateDict setObject:@"_____________" forKey:@"whochallenged"];
    [self.currentStateDict setObject:@"_____" forKey:@"callafter"];
    [self.currentStateDict setObject:@"_________" forKey:@"outcome"];
    [self.currentStateDict setObject:@"____" forKey:@"outsafter"];
    [self.currentStateDict setObject:@"____" forKey:@"runnersafter"];

}

-(void)compareCalls


{
    
    NSLog(@"compareCalls initiated");
    if ([[self.currentStateDict objectForKey:@"callonfield" ] isEqualToString:([self.currentStateDict objectForKey:@"callafter"])]) {
        NSArray *temporaryOutome = [[NSArray alloc]initWithArray:self.outcome];
        temporaryOutome = [temporaryOutome subarrayWithRange:NSMakeRange(0,3)];
        
        [UIUtils initPopUpButton:self.outcomePopUpButton selections:temporaryOutome defaultIndex:0];
    }
    else
    {
      NSMutableArray  *temporaryOutcome2 = [[NSMutableArray alloc]initWithArray:self.outcome];
        [temporaryOutcome2 removeObjectAtIndex:1];
        [temporaryOutcome2 removeObjectAtIndex:1];
        [UIUtils initPopUpButton:self.outcomePopUpButton selections:temporaryOutcome2 defaultIndex:0];

    }
    
    
}

-(void) setActiveRoster

{
    self.teamID = @[@"108",
                    @"109",
                    @"110",
                    @"111",
                    @"112",
                    @"113",
                    @"114",
                    @"115",
                    @"116",
                    @"117",
                    @"118",
                    @"119",
                    @"120",
                    @"121",
                    @"133",
                    @"134",
                    @"135",
                    @"136",
                    @"137",
                    @"138",
                    @"139",
                    @"140",
                    @"141",
                    @"142",
                    @"143",
                    @"144",
                    @"145",
                    @"146",
                    @"147",
                    @"158"];

    NSLog(@"setActiveRoster being called");
    self.completeTeamRosters = [[NSMutableDictionary alloc]init];
    NSString *key = [[NSString alloc]init];
    NSArray *teamRosterArray = [[NSArray alloc]init];
    NSString *position = [[NSString alloc]init];
//
//        for (int i = 100; i < 200; i++) {
    for (NSString *teamID in self.teamID) {
//    NSString *teamID = [NSString stringWithFormat:@"%d", i];
            NSString *rosterURL = @"/lookup/named.roster_active_mlb.bam?team_id=teamid";
            rosterURL = [rosterURL stringByReplacingOccurrencesOfString:@"teamid" withString:teamID];
    
             NSString *teamsXMLString = [self.httpEndpt GET:rosterURL];
            NSXMLDocument *xmlDoc = makeXMLDocument(teamsXMLString);
    
//            NSLog(@"%@",xmlDoc);
            
            NSArray *rows = getNodeArrayFromXPath(@"/roster_active_mlb/queryResults/row", xmlDoc);
            NSMutableArray *teamRoster = [[NSMutableArray alloc]init];
            
            
            for (NSXMLNode *rowNode in rows)
            {
                NSString *playerName = getStringFromXPath(@"@name_display_first_last", rowNode);
                key = getStringFromXPath(@"@file_code", rowNode);
                position = getStringFromXPath(@"@position_txt", rowNode);
                NSString *playPosName = [NSString stringWithFormat:@"%@ - %@", position, playerName];
                key = [key uppercaseString];
               
                [teamRoster addObject:playPosName];

            }
            if ([key isEqualTo:@"ANA"])
            {
                key = @"LAA";
            }
            if ([key isEqualTo:@"LA"])
            {
                key = @"LAD";
            }

             NSLog(@"%@ -- %@", key, teamID);
            [teamRoster insertObject:@"" atIndex:0];
            teamRosterArray = [teamRoster copy];

            [self.completeTeamRosters setObject:teamRosterArray forKey:key];

            
            
    
    
        }
}



-(void) pullDayGames

{
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [DateFormatter stringFromDate:[NSDate date]];
    NSLog(@"This is the date today: %@",dateString);
    
    self.gameDayArray = [[NSMutableArray alloc]init];
    [self.gameDayArray addObject:@""];
    self.httpEndpt = [[HTTPEndpt alloc] initWithBaseURL:@"http://www.mlb.com/lookup"];
    
    NSString *scheduleURL = @"/named.schedule_vw.bam?season=2015&game_date='today_date'&sport_code='mlb'&sport_code='win'";
    scheduleURL = [scheduleURL stringByReplacingOccurrencesOfString:@"today_date" withString:dateString];
    
    
     NSString *teamsXMLString = [self.httpEndpt GET:scheduleURL];
    
    
    NSXMLDocument *xmlDoc = makeXMLDocument(teamsXMLString);
    
    NSArray *rows = getNodeArrayFromXPath(@"/schedule_vw/queryResults/row", xmlDoc);
    
    for (NSXMLNode *rowNode in rows)
    {
      
        
        NSString *awayTeam = getStringFromXPath(@"@away_team_file_code", rowNode);
        if ([awayTeam isEqualToString:@"ana"]) {
            awayTeam = @"LAA";
        }
        if ([awayTeam isEqualToString:@"la"]) {
            awayTeam = @"LAD";
        }
        NSString *homeTeam = getStringFromXPath(@"@home_team_file_code", rowNode);
        if ([homeTeam isEqualToString:@"ana"]) {
            homeTeam = @"LAA";
        }
        if ([homeTeam isEqualToString:@"la"]) {
            homeTeam = @"LAD";
        }

        

        
//        NSLog(@"%@/%@", awayTeam, homeTeam);
       self.testString = [[NSString stringWithFormat:@"%@/%@",awayTeam, homeTeam] uppercaseString];
        
      
        [self.gameDayArray addObject:self.testString];
        
        
    }




    
}

-(void) SetTeamChoice

{
    
    

    
    
    
    self.selectedTeam = self.selectedString;
    self.teamChoice = [self.selectedTeam componentsSeparatedByString:@"/"];
//    NSLog(@"the array is: %@", self.teamChoice);
    NSMutableArray *mutableTeamChoice = [[NSMutableArray alloc]initWithArray:self.teamChoice];
    [mutableTeamChoice insertObject:@"" atIndex:0];
    [UIUtils initPopUpButton:self.offenseTeamPopUpButton selections:mutableTeamChoice defaultIndex:0];
    [UIUtils initPopUpButton:self.defenseTeamPopUpButton selections:mutableTeamChoice defaultIndex:0];
    
    NSMutableArray *mutableManagerChoice = [[NSMutableArray alloc]init];
    [mutableManagerChoice insertObject:@"" atIndex:0];
    
    for (NSString *item in self.teamChoice)
    {
        if (self.managers[item])
        
        {
            [mutableManagerChoice insertObject:[self.managers objectForKey:item] atIndex:1];

    }
        else
        {
            NSLog(@"not working");
        }
    }
    [UIUtils initPopUpButton:self.whoChallengedPopUpButton selections:mutableManagerChoice defaultIndex:0];
    
}


//-(void) allDone
//
//{
//    if ([[self.currentStateDict objectForKey:@"outcome"]  isEqual: @"Stands"]) {
//        NSLog(@"change color");
//        [self.allDoneColorWell setColor: [NSColor colorWithDeviceRed:0 green:.6 blue:0 alpha:1]];
//    }
//    else
//    {
//        NSLog(@"OH WHY ISNT THIS WORKING");
//        
//    }
//
//}
- (IBAction)clickButton:(id)sender {
    
    int tag = [sender tag];
  
    
    
    if (tag == RESET_TAG)   /// RESETS ALL FIELDS
    {
        [self enableAll];

//        NSLog(@"YA I DID IT");
        
        [UIUtils initPopUpButton:self.playTypeOptionsPopUpButton selections:self.playType defaultIndex:0];
        [UIUtils initPopUpButton:self.playVariation selections:self.emptyArray defaultIndex:0];
        
        [UIUtils initPopUpButton:self.challengeTypePopUpButton selections:self.typeOfChallenge defaultIndex:0];
        
        [self.challengeTypePopUpButton selectItemAtIndex:0];
        [UIUtils initPopUpButton:self.gameTypePopUpButton selections:self.gameDayArray defaultIndex:0];
        [self.challengeTypePopUpButton selectItemAtIndex:0];
        [UIUtils initPopUpButton:self.inningPopUpButton selections:self.inning defaultIndex:0];
        [self.inningPopUpButton selectItemAtIndex:0];
        [UIUtils initPopUpButton:self.outsBeforePopUpButton selections:self.outsBefore defaultIndex:0];
        [self.outsBeforePopUpButton selectItemAtIndex:0];
        [UIUtils initPopUpButton:self.runnersOnBeforePopUpButton selections:self.runnersOnBefore defaultIndex:0];
        [self.runnersOnBeforePopUpButton selectItemAtIndex:0];
        [UIUtils initPopUpButton:self.whoChallengedPopUpButton selections:self.emptyArray defaultIndex:0];
        [UIUtils initPopUpButton:self.homePlayerNamePopUpButton selections:self.emptyArray defaultIndex:0];
        [UIUtils initPopUpButton:self.homePlayerName2PopUpButton selections:self.emptyArray defaultIndex:0];
        [UIUtils initPopUpButton:self.awayPlayerNamePopUpButton selections:self.emptyArray defaultIndex:0];
        [UIUtils initPopUpButton:self.awayPlayerName2PopUpButton selections:self.emptyArray defaultIndex:0];
        
        
        [UIUtils initPopUpButton:self.offenseTeamPopUpButton selections:self.emptyArray defaultIndex:0];
        [UIUtils initPopUpButton:self.defenseTeamPopUpButton selections:self.emptyArray defaultIndex:0];
        
        [UIUtils initPopUpButton:self.offenseDoesWhatPopUpButton selections:self.offenseDoesWhat defaultIndex:0];
        [UIUtils initPopUpButton:self.defenseDoesWhatPopUpButton selections:self.defenseDoesWhat defaultIndex:0];
        [UIUtils initPopUpButton:self.callOnFieldPopUpButton selections:self.call defaultIndex:0];
        [UIUtils initPopUpButton:self.playLocationPopUpButton selections:self.playLocation defaultIndex:0];
        [UIUtils initPopUpButton:self.callAfterReviewPopUpButton selections:self.call defaultIndex:0];
        [UIUtils initPopUpButton:self.outcomePopUpButton selections:self.outcome defaultIndex:0];
        [UIUtils initPopUpButton:self.outsAfterPopUpButton selections:self.outsAfter defaultIndex:0];
        [UIUtils initPopUpButton:self.runnersOnAfterPopUpButton selections:self.runnersOnBefore defaultIndex:0];
        [UIUtils initPopUpButton:self.offenseDoesWhat2PopUpButton selections:self.offenseDoesWhat defaultIndex:0];
        [UIUtils initPopUpButton:self.defenseDoesWhat2PopUpButton selections:self.defenseDoesWhat defaultIndex:0];
        
        [self.emailTextView setString:@""];
        [self.subjectTextField setStringValue:@""];
        [self setDefaultLines];
        [self.extraInningCheckbox setState:0];


        

}
    if (tag == EXTRAINNINGS_TAG)   // SWITCHES INNING DROPDOWN TO EXTRA INNINGS
    {
        if ([self.extraInningCheckbox state] == NSOnState) {
        [UIUtils initPopUpButton:self.inningPopUpButton selections:self.extraInnings defaultIndex:0];
        }
        else{
            
            [UIUtils initPopUpButton:self.inningPopUpButton selections:self.inning defaultIndex:0];
        }
        
    }
    
     if (tag == COPYBUTTON_TAG)   // COPYS THE TEXT IN EMAILTEXTVIEW TO OSX CLIPBOARD
     {
         [[NSPasteboard generalPasteboard] clearContents];
         [[NSPasteboard generalPasteboard] setString: self.emailTextView.string  forType:NSStringPboardType];
         
     }
    
}
@end
