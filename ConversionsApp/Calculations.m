//
//  Calculations.m
//  ConversionsApp
//
//  Created by Joe Cortopassi on 1/16/13.
//  Copyright (c) 2013 Joe Cortopassi. All rights reserved.
//

#import "Calculations.h"

@interface Calculations ()
@property (nonatomic, readonly) NSString *standardUnitOfMeasure;

@property (nonatomic, readonly) NSDictionary *lengthTypes;
@property (nonatomic, readonly) NSArray *lengthOrder;
@property (nonatomic, readonly) NSDictionary *weightTypes;
@property (nonatomic, readonly) NSArray *weightOrder;
@property (nonatomic, readonly) NSDictionary *volumeTypes;
@property (nonatomic, readonly) NSArray *volumeOrder;
@end


@implementation Calculations

@synthesize category, standardUnitOfMeasure;
@synthesize lengthOrder, lengthTypes, weightOrder, weightTypes, volumeOrder, volumeTypes;


- (id) init
{
    if (self = [super init])
    {
        
    }
    
    return  self;
}


- (NSString *) standardUnitOfMeasure
{
    NSString *standard;
    
    if ([self.category caseInsensitiveCompare:@"length"])
    {
        standard = @"Meters";
    }
    
    return standard;
}



/*************************************
        Calculation Methods
 *************************************/
- (NSArray *) measurementTypes
{
    NSArray *measurementTypes;
    
    if ([self.category caseInsensitiveCompare:@"length"] == NSOrderedSame)
    {
        measurementTypes = self.lengthOrder;
    }
    else if ([self.category caseInsensitiveCompare:@"weight"] == NSOrderedSame)
    {
        measurementTypes = self.weightOrder;
    }
    else if ([self.category caseInsensitiveCompare:@"volume"] == NSOrderedSame)
    {
        measurementTypes = self.volumeOrder;
    }
    else
    {
        measurementTypes = nil;
    }
    
    return measurementTypes;
}


- (CGFloat) getStandardConversionUnitsForMeasurementType:(NSString *)type
{
    
    NSDictionary *measurementTypes;
    
    if ([self.category caseInsensitiveCompare:@"length"] == NSOrderedSame)
    {
        measurementTypes = self.lengthTypes;
    }
    else if ([self.category caseInsensitiveCompare:@"weight"] == NSOrderedSame)
    {
        measurementTypes = self.weightTypes;
    }
    else if ([self.category caseInsensitiveCompare:@"volume"] == NSOrderedSame)
    {
        measurementTypes = self.volumeTypes;
    }
    else
    {
        measurementTypes = nil;
    }
    
    return [(NSNumber *)[measurementTypes objectForKey:type] floatValue];

}


- (CGFloat) convert:(CGFloat)input fromMeasurementType:(NSString *)inputType toMeasurementType:(NSString *)outputType
{
    CGFloat inputInStandardUnits;
    CGFloat outputInStandardUnits;
    
    inputInStandardUnits = input / [self getStandardConversionUnitsForMeasurementType:inputType];
    outputInStandardUnits = inputInStandardUnits * [self getStandardConversionUnitsForMeasurementType:outputType];

    outputInStandardUnits = round(outputInStandardUnits * 100) / 100.0;
    
    return outputInStandardUnits;
}





/*************************************
 Getters for Category Arrays
 *************************************/
- (NSDictionary *)lengthTypes
{
    return    @{@"Inches"       : [NSNumber numberWithFloat:39.3701],
                @"Feet"         : [NSNumber numberWithFloat:3.28084],
                @"Yards"        : [NSNumber numberWithFloat:1.09361],
                @"Miles"        : [NSNumber numberWithFloat:0.000621371],
                @"Centimeters"  : [NSNumber numberWithFloat:100.0],
                @"Meters"       : [NSNumber numberWithFloat:1.0],
                @"Kilometers"   : [NSNumber numberWithFloat:0.001]};
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
