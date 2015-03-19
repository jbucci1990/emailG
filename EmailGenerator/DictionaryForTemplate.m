//
//  DictionaryForTemplate.m
//  EmailGenerator
//
//  Created by JJ Bucci on 2/6/15.
//  Copyright (c) 2015 JJ Bucci. All rights reserved.
//

#import "DictionaryForTemplate.h"
#import "AppDelegate.h"

@implementation DictionaryForTemplate

-(NSMutableAttributedString*) makeEmail:(NSDictionary*)infoDict
{
    
    NSString *emailText = [self.templateText copy];
    NSMutableAttributedString *convertTemplate = [[NSMutableAttributedString alloc]initWithString:emailText];

    
    
    
    
    NSMutableDictionary *lookADict = [[NSMutableDictionary alloc]init];
    
    
    
    [lookADict setObject:@"$PLAYTYPE" forKey:@"playtype"];
    [lookADict setObject:@"$CHALLENGETYPE" forKey:@"challengetype"];
    [lookADict setObject:@"$GAME" forKey:@"game"];
    [lookADict setObject:@"$INNING" forKey:@"inning"];
    [lookADict setObject:@"$OUTSBEFORE" forKey:@"outsbefore"];
    [lookADict setObject:@"$RUNNERSBEFORE" forKey:@"runnersbefore"];
    [lookADict setObject:@"$OFFENSETEAM" forKey:@"offenseteam"];
    [lookADict setObject:@"$OFFENSIVEPLAYER" forKey:@"offensiveplayer"];
    [lookADict setObject:@"$OFFENSEDOESWHAT" forKey:@"offensedoeswhat"];
    [lookADict setObject:@"$2OFFENSIVEPLAYER" forKey:@"offensiveplayer2"];
    [lookADict setObject:@"$2OFFENSEDOESWHAT" forKey:@"offensedoeswhat2"];
    [lookADict setObject:@"$DEFENSETEAM" forKey:@"defenseteam"];
    [lookADict setObject:@"$DEFENSIVEPLAYER" forKey:@"defensiveplayer"];
    
    [lookADict setObject:@"$DEFENSEDOESWHAT" forKey:@"defensedoeswhat"];
    [lookADict setObject:@"$2DEFENSIVEPLAYER" forKey:@"defensiveplayer2"];
    [lookADict setObject:@"$DEFENSEDOESWHAT2" forKey:@"defensedoeswhat2"];
    [lookADict setObject:@"$WHOCHALLENGED" forKey:@"whochallenged"];
    [lookADict setObject:@"$CALLONFIELD" forKey:@"callonfield"];
    [lookADict setObject:@"$PLAYLOCATION" forKey:@"playlocation"];
    [lookADict setObject:@"$CALLAFTER" forKey:@"callafter"];
    [lookADict setObject:@"$OUTCOME" forKey:@"outcome"];
    [lookADict setObject:@"$OUTSAFTER" forKey:@"outsafter"];
    [lookADict setObject:@"$RUNNERSAFTER" forKey:@"runnersafter"];
//
////
    NSMutableDictionary *coloredDict = [[NSMutableDictionary alloc]init];
//
    for (NSString *key in infoDict) {
        
        
        NSDictionary *attributes = @{
                                     NSForegroundColorAttributeName :  [NSColor colorWithDeviceRed:0 green:.6 blue:0 alpha:1]
                                     ,
                                     NSFontAttributeName : [NSFont fontWithName:@"Helvetica-Bold" size:12.f]

                                     };
        NSDictionary *attributes2 = @{
                                      NSForegroundColorAttributeName : [NSColor redColor],
                                      };

//
        NSString *value = [infoDict objectForKey:key];
        
        NSMutableAttributedString *colored = [[NSMutableAttributedString alloc] initWithString:value];
        if ([colored.string rangeOfString:@"_"].location == NSNotFound) {

        
        [colored setAttributes:attributes range:NSMakeRange(0, value.length)];
   
            [coloredDict setObject:colored forKey:key];}
        else {
            [colored setAttributes:attributes2 range:NSMakeRange(0, value.length)];
            
            [coloredDict setObject:colored forKey:key];}

            
        
    }
//         
//         }
//
//
    for (NSString *key in lookADict)
    {
        NSString *value = [lookADict objectForKey:key];

        if ([convertTemplate.string rangeOfString:value].location == NSNotFound) {
            NSLog(@" %@ not found in template", value);}
        else {
//        NSUInteger length = [convertTemplate length];

        NSRange range = [convertTemplate.string rangeOfString:value];
            while(range.location != NSNotFound)
            {
                [convertTemplate replaceCharactersInRange:range withAttributedString: [coloredDict objectForKey:key]];
                range = [convertTemplate.string rangeOfString:value];
                                         }

        
            
        }}
    
    
    
    
    
    
    

    return convertTemplate;
}



-(NSString*) makeSubject:(NSDictionary *)infoDict{
    NSString *emailSubject = [NSString alloc];
    emailSubject = @"Replay Review Alert - $CHALLENGETYPE - $GAME- $INNING - $PLAYTYPE at $PLAYLOCATION ruled $CALLONFIELD ($OUTCOME)";
    
    emailSubject = [emailSubject stringByReplacingOccurrencesOfString:@"$CHALLENGETYPE" withString:[infoDict objectForKey:@"challengetype" ]];
    emailSubject = [emailSubject stringByReplacingOccurrencesOfString:@"$GAME" withString:[infoDict objectForKey:@"game" ]];
    emailSubject = [emailSubject stringByReplacingOccurrencesOfString:@"$INNING" withString:[infoDict objectForKey:@"inning" ]];
    emailSubject = [emailSubject stringByReplacingOccurrencesOfString:@"$PLAYTYPE" withString:[infoDict objectForKey:@"playtype" ]];
    
    emailSubject = [emailSubject stringByReplacingOccurrencesOfString:@"$PLAYLOCATION" withString:[infoDict objectForKey:@"playlocation" ]];
    
    
    emailSubject = [emailSubject stringByReplacingOccurrencesOfString:@"$CALLONFIELD" withString:[infoDict objectForKey:@"callonfield" ]];
    
    emailSubject = [emailSubject stringByReplacingOccurrencesOfString:@"$OUTCOME" withString:[infoDict objectForKey:@"outcome" ]];
    
    
    
    
    return emailSubject;
}





@end