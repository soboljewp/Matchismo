//
//  SetCard.h
//  Matchismo
//
//  Created by Patrick Dawson on 01.07.14.
//  Copyright (c) 2014 de.mtx.cs193p.patrick. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (nonatomic) NSUInteger number;
@property (nonatomic,strong) NSString* symbol;
@property (nonatomic, strong) NSString* color;
@property (nonatomic, strong) NSString* shading;

+(int) maxNumber;
+(NSArray *)validSymbols;
+(NSArray *)validColors;
+(NSArray *)validShadings;

@end
