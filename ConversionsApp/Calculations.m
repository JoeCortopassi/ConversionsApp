//
//  Calculations.m
//  ConversionsApp
//
//  Created by Joe Cortopassi on 1/16/13.
//  Copyright (c) 2013 Joe Cortopassi. All rights reserved.
//

#import "Calculations.h"

@interface Calculations ()
@property (nonatomic, readonly) NSDictionary *lengthTypes;
@property (nonatomic, readonly) NSArray *lengthOrder;
@property (nonatomic, readonly) NSDictionary *weightTypes;
@property (nonatomic, readonly) NSArray *weightOrder;
@property (nonatomic, readonly) NSDictionary *volumeTypes;
@property (nonatomic, readonly) NSArray *volumeOrder;
@end


@implementation Calculations

@synthesize lengthOrder, lengthTypes, weightOrder, weightTypes, volumeOrder, volumeTypes;

/*************************************
        Calculation Methods
 *************************************/
- (NSArray *) measurementTypesForCategory:(NSString *)category
{
    NSArray *measurementTypes;
    
    if ([category caseInsensitiveCompare:@"length"] == NSOrderedSame)
    {
        measurementTypes = self.lengthOrder;
    }
    else if ([category caseInsensitiveCompare:@"weight"] == NSOrderedSame)
    {
        measurementTypes = self.weightOrder;
    }
    else if ([category caseInsensitiveCompare:@"volume"] == NSOrderedSame)
    {
        measurementTypes = self.volumeOrder;
    }
    else
    {
        measurementTypes = nil;
    }
    
    return measurementTypes;
}


- (CGFloat) convert:(CGFloat)input fromMeasurementType:(NSString *)inputType toMeasurementType:(NSString *)outputType
{
    return input * 2;
}





/*************************************
 Getters for Category Arrays
 *************************************/
- (NSDictionary *)lengthTypes
{
    return    @{@"Inches"       : [NSNumber numberWithFloat:0.0],
                @"Feet"         : [NSNumber numberWithFloat:0.0],
                @"Yards"        : [NSNumber numberWithFloat:0.0],
                @"Miles"        : [NSNumber numberWithFloat:0.0],
                @"Centimeters"  : [NSNumber numberWithFloat:0.0],
                @"Meters"       : [NSNumber numberWithFloat:0.0],
                @"Kilometers"   : [NSNumber numberWithFloat:0.0]};
}


- (NSArray *)lengthOrder
{
    return    @[@"Inches",
    @"Feet",
    @"Yards",
    @"Miles",
    @"Centimeters",
    @"Meters",
    @"Kilometers"];
}


- (NSDictionary *) weightTypes
{
    return    @{@"Grams"        : [NSNumber numberWithFloat:0.0],
                @"Ounces"       : [NSNumber numberWithFloat:0.0],
                @"Pounds"       : [NSNumber numberWithFloat:0.0],
                @"Kilograms"    : [NSNumber numberWithFloat:0.0],
                @"Tons"         : [NSNumber numberWithFloat:0.0],
                @"Metric Tons"  : [NSNumber numberWithFloat:0.0]};
}


- (NSArray *) weightOrder
{
    return    @[@"Grams",
                @"Ounces",
                @"Pounds",
                @"Kilograms",
                @"Tons",
                @"Metric Tons"];
}


- (NSDictionary *) volumeTypes
{
    return    @{@"Ounces"   : [NSNumber numberWithFloat:0.0],
                @"Liters"   : [NSNumber numberWithFloat:0.0],
                @"Pints"    : [NSNumber numberWithFloat:0.0],
                @"Gallons"  : [NSNumber numberWithFloat:0.0]};
}


- (NSArray *) volumeOrder
{
    return    @[@"Ounces",
                @"Liters",
                @"Pints",
                @"Gallons"];
}

@end
