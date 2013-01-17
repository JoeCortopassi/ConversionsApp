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
@property (nonatomic, readonly) NSDictionary *timeTypes;
@property (nonatomic, readonly) NSArray *timeOrder;
@end


@implementation Calculations

@synthesize category, standardUnitOfMeasure;
@synthesize lengthOrder, lengthTypes, weightOrder, weightTypes, volumeOrder, volumeTypes, timeOrder, timeTypes;


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
    else if ([self.category caseInsensitiveCompare:@"time"] == NSOrderedSame)
    {
        measurementTypes = self.timeOrder;
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
    else if ([self.category caseInsensitiveCompare:@"time"] == NSOrderedSame)
    {
        measurementTypes = self.timeTypes;
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
                @"Meters"       : [NSNumber numberWithFloat:1.0],   // standard
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
    return    @{@"Milligrams"   : [NSNumber numberWithFloat:1000000.0],
                @"Grams"        : [NSNumber numberWithFloat:1000.0],
                @"Ounces"       : [NSNumber numberWithFloat:35.274],
                @"Pounds"       : [NSNumber numberWithFloat:2.20462],
                @"Kilograms"    : [NSNumber numberWithFloat:1.0], // standard
                @"Tons"         : [NSNumber numberWithFloat:0.00110231],
                @"Metric Tons"  : [NSNumber numberWithFloat:0.001]};
}


- (NSArray *) weightOrder
{
    return    @[@"Milligrams",
                @"Grams", // standard
                @"Ounces",
                @"Pounds",
                @"Kilograms",
                @"Tons",
                @"Metric Tons"];
}


- (NSDictionary *) volumeTypes
{
    return    @{@"Teaspoons"    : [NSNumber numberWithFloat:202.884],
                @"Tablespoons"  : [NSNumber numberWithFloat:67.628],
                @"Cups"         : [NSNumber numberWithFloat:4.22675],
                @"Pints"        : [NSNumber numberWithFloat:2.11338],
                @"Quarts"       : [NSNumber numberWithFloat:1.05669],
                @"Liters"       : [NSNumber numberWithFloat:1.0],  // standard
                @"Gallons (US)" : [NSNumber numberWithFloat:0.264172],
                @"Gallons (UK)" : [NSNumber numberWithFloat:0.219969]};
}


- (NSArray *) volumeOrder
{
    return    @[@"Teaspoons",
                @"Tablespoons",
                @"Cups",
                @"Liters",
                @"Quarts",
                @"Pints",
                @"Gallons (US)",
                @"Gallons (UK)"];
}


- (NSDictionary *) timeTypes
{
    return    @{@"Seconds"  : [NSNumber numberWithFloat:3600.0],
                @"Minutes"  : [NSNumber numberWithFloat:60.0],
                @"Hours"    : [NSNumber numberWithFloat:1.0],   // standard
                @"Days"     : [NSNumber numberWithFloat:(1/24.0)],
                @"Weeks"    : [NSNumber numberWithFloat:(1/168.0)],
                @"Months"   : [NSNumber numberWithFloat:(1/(24.0*30.5))],
                @"Years"    : [NSNumber numberWithFloat:(1/(24.0*365.25))]};
}


- (NSArray *) timeOrder
{
    return    @[@"Seconds",
                @"Minutes",
                @"Hours",
                @"Days",
                @"Weeks",
                @"Months",
                @"Years"];
}

@end
