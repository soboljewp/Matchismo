//
//  SetCard.m
//  Matchismo
//
//  Created by Patrick Dawson on 01.07.14.
//  Copyright (c) 2014 de.mtx.cs193p.patrick. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

+(int) maxNumber
{
    return 3;
}

+(NSArray *)validSymbols
{
    return @[@"Triangle", @"Circle", @"Square"];
}

+(NSArray *)validColors
{
    return @[@"Red", @"Green", @"Purple"];
}

+(NSArray *)validShadings
{
    return @[@"Solid", @"Striped", @"Open"];
}



@end
