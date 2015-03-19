//
//  AppDelegate.h
//  EmailGenerator
//
//  Created by JJ Bucci on 2/3/15.
//  Copyright (c) 2015 JJ Bucci. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class DictionaryForTemplate;
@class HTTPEndpt;


@interface AppDelegate : NSObject <NSApplicationDelegate>
@property (weak) IBOutlet NSPopUpButton *playTypeOptionsPopUpButton;
@property (weak) IBOutlet NSPopUpButton *playVariation;

@property (weak) IBOutlet NSPopUpButton *challengeTypePopUpButton;
@property (weak) IBOutlet NSPopUpButton *gameTypePopUpButton;
@property (weak) IBOutlet NSPopUpButton *inningPopUpButton;
@property (weak) IBOutlet NSPopUpButton *outsBeforePopUpButton;
@property (weak) IBOutlet NSPopUpButton *runnersOnBeforePopUpButton;
@property (weak) IBOutlet NSPopUpButton *offenseTeamPopUpButton;
@property (weak) IBOutlet NSPopUpButton *defenseTeamPopUpButton;

@property (weak) IBOutlet NSPopUpButton *offenseDoesWhatPopUpButton;
@property (weak) IBOutlet NSPopUpButton *defenseDoesWhatPopUpButton;
@property (weak) IBOutlet NSPopUpButton *whoChallengedPopUpButton;

@property (weak) IBOutlet NSPopUpButton *callOnFieldPopUpButton;
@property (weak) IBOutlet NSPopUpButton *playLocationPopUpButton;
@property (weak) IBOutlet NSPopUpButton *callAfterReviewPopUpButton;
@property (weak) IBOutlet NSPopUpButton *outcomePopUpButton;
@property (weak) IBOutlet NSPopUpButton *outsAfterPopUpButton;
@property (weak) IBOutlet NSPopUpButton *runnersOnAfterPopUpButton;
@property (weak) IBOutlet NSPopUpButton *homePlayerNamePopUpButton;
@property (weak) IBOutlet NSPopUpButton *homePlayerName2PopUpButton;

@property (weak) IBOutlet NSPopUpButton *awayPlayerNamePopUpButton;
@property (weak) IBOutlet NSPopUpButton *awayPlayerName2PopUpButton;
@property (weak) IBOutlet NSPopUpButton *offenseDoesWhat2PopUpButton;
@property (weak) IBOutlet NSPopUpButton *defenseDoesWhat2PopUpButton;

@property (unsafe_unretained) IBOutlet NSTextView *emailTextView;
@property (weak) IBOutlet NSTextField *subjectTextField;


@property (weak) IBOutlet NSButton *extraInningCheckbox;



@property (retain) DictionaryForTemplate *dictionaryForTemplate;

@property (retain) NSMutableDictionary *currentStateDict;

@property (retain) NSArray *emptyArray;
@property (retain) NSArray *playTagVariation;
@property (retain) NSArray *callAfterCatch;
@property (retain) NSArray *callAfterHomeRun;
@property (retain) NSArray *callAfterFairFoul;
@property (retain) NSArray *callAfterHitByPitch;
@property (retain) NSArray *call;
@property (retain) NSArray *callAFterViolation;
@property (retain) NSArray *teams;
@property (retain) NSArray *teams2;

@property (retain) NSArray *typeOfChallenge;
@property (retain) NSArray *whoChallenging;
@property (retain) NSArray *playType;
@property (retain) NSArray *game;
@property (retain) NSArray *inning;
@property (retain) NSArray *extraInnings;
@property (retain) NSArray *playLocation;
@property (retain) NSArray *offenseDoesWhat;
@property (retain) NSArray *defenseDoesWhat;
@property (retain) NSArray *outcome;
@property (retain) NSArray *outsBefore;

@property (retain) NSArray *outsAfter;
@property (retain) NSArray *runnersOnBefore;
@property (retain) NSArray *runnersOnAfter;



@property (retain) NSMutableArray *gameDayArray;
@property (retain) HTTPEndpt *httpEndpt;

@property (strong) NSString *testString;
@property (strong) NSString *selectedTeam;
@property (retain) NSArray *teamChoice;
@property (strong) NSString *selectedString;
@property (retain) NSMutableDictionary *completeTeamRosters;
















@property (retain) NSArray *teamID;
@property (retain) NSDictionary *managers;
@property (retain) NSArray *washNationals;
@property (retain) NSArray *laDodgers;
@property (retain) NSArray *atlBraves;
@property (retain) NSArray *balOrioles;

@property (weak) IBOutlet NSButton *resetButton;
- (IBAction)clickButton:(id)sender;




@end

