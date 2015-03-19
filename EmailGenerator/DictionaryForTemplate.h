//
//  DictionaryForTemplate.h
//  EmailGenerator
//
//  Created by JJ Bucci on 2/6/15.
//  Copyright (c) 2015 JJ Bucci. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DictionaryForTemplate : NSObject
-(NSMutableAttributedString*) makeEmail:(NSDictionary*)infoDict;
-(NSString*) makeSubject:(NSDictionary*)infoDict;


@property (retain) NSString *templateText;
@property (retain) NSString *emailSubjectText;

@end
