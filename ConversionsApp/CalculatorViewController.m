//
//  CalculatorViewController.m
//  ConversionsApp
//
//  Created by Joe Cortopassi on 1/15/13.
//  Copyright (c) 2013 Joe Cortopassi. All rights reserved.
//

#import "CalculatorViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Calculations.h"

@interface CalculatorViewController ()

@end

@implementation CalculatorViewController

@synthesize bounds, category, calculator, selectedInput;
@synthesize leftInputLabel, leftInputOverlay, rightInputLabel, rightInputOverlay;
@synthesize leftPickerView, rightPickerView;
@synthesize oneButton, twoButton, threeButton, fourButton, fiveButton, sixButton, sevenButton, eightButton, nineButton, zeroButton, periodButton, clearButton;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.sevenButton    = [UIButton buttonWithType:UIButtonTypeCustom];
        self.eightButton    = [UIButton buttonWithType:UIButtonTypeCustom];
        self.nineButton     = [UIButton buttonWithType:UIButtonTypeCustom];
        self.fourButton     = [UIButton buttonWithType:UIButtonTypeCustom];
        self.fiveButton     = [UIButton buttonWithType:UIButtonTypeCustom];
        self.sixButton      = [UIButton buttonWithType:UIButtonTypeCustom];
        self.oneButton      = [UIButton buttonWithType:UIButtonTypeCustom];
        self.twoButton      = [UIButton buttonWithType:UIButtonTypeCustom];
        self.threeButton    = [UIButton buttonWithType:UIButtonTypeCustom];
        self.zeroButton     = [UIButton buttonWithType:UIButtonTypeCustom];
        self.periodButton   = [UIButton buttonWithType:UIButtonTypeCustom];
        self.clearButton    = [UIButton buttonWithType:UIButtonTypeCustom];
        
        self.calculator = [[Calculations alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.bounds = [[UIScreen mainScreen] bounds];
    
    [self setUpInputBoxes];
    [self setupMeasurementTypePickers];
    [self setupButtons];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) setUpInputBoxes
{
    CGSize labelDimensions      = CGSizeMake(self.bounds.size.width/2 - 6, 40);
    CGRect leftInputFrame       = CGRectMake(3, 0, labelDimensions.width, labelDimensions.height);
    CGRect rightInputFrame      = CGRectMake((self.bounds.size.width/2)+3, 0, labelDimensions.width, labelDimensions.height);
    UIColor *backgroundColor    = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.2];
    UIColor *textColor          = [UIColor whiteColor];
    UIFont *font                = [UIFont fontWithName:@"Verdana-Bold" size:20];
    
    
    // Left side
    self.leftInputLabel = [[UILabel alloc] init];
    self.leftInputLabel.frame = leftInputFrame;
    self.leftInputLabel.backgroundColor = backgroundColor;
    self.leftInputLabel.textColor = textColor;
    self.leftInputLabel.font = font;
    self.leftInputLabel.textAlignment = NSTextAlignmentCenter;
    
    self.leftInputOverlay = [[UIButton alloc] init];
    self.leftInputOverlay.frame = leftInputFrame;
    self.leftInputOverlay.backgroundColor = [UIColor clearColor];
    [self.leftInputOverlay addTarget:self action:@selector(inputTouched:) forControlEvents:UIControlEventTouchUpInside];
    self.leftInputOverlay.tag = inputLeft;
    
    
    // Right side
    self.rightInputLabel = [[UILabel alloc] init];
    self.rightInputLabel.frame = rightInputFrame;
    self.rightInputLabel.backgroundColor = backgroundColor;
    self.rightInputLabel.textColor = textColor;
    self.rightInputLabel.font = font;
    self.rightInputLabel.textAlignment = NSTextAlignmentCenter;
    
    self.rightInputOverlay = [[UIButton alloc] init];
    self.rightInputOverlay.frame = rightInputFrame;
    self.rightInputOverlay.backgroundColor = [UIColor clearColor];
    [self.rightInputOverlay addTarget:self action:@selector(inputTouched:) forControlEvents:UIControlEventTouchUpInside];
    self.rightInputOverlay.tag = inputRight;
    
    self.leftInputLabel.text = @"0.00";
    self.rightInputLabel.text = @"0.00";
    // Add to view
    [self.view addSubview:self.leftInputLabel];
    [self.view addSubview:self.leftInputOverlay];
    [self.view addSubview:self.rightInputLabel];
    [self.view addSubview:self.rightInputOverlay];
}


- (void) setupMeasurementTypePickers
{
    CGRect pickerFrame = CGRectMake(0, self.leftInputLabel.frame.size.height + 4, self.bounds.size.width/2, 180.0);
    
    self.leftPickerView = [[UIPickerView alloc] init];
    self.leftPickerView.tag = inputLeft;
    self.leftPickerView.frame = CGRectMake(0, pickerFrame.origin.y, pickerFrame.size.width, pickerFrame.size.height);
    self.leftPickerView.dataSource = self;
    self.leftPickerView.delegate = self;
    
    self.rightPickerView = [[UIPickerView alloc] init];
    self.rightPickerView.tag = inputRight;
    self.rightPickerView.frame = CGRectMake(pickerFrame.size.width, pickerFrame.origin.y, pickerFrame.size.width, pickerFrame.size.height);
    self.rightPickerView.dataSource = self;
    self.rightPickerView.delegate = self;
    
    
    [self.view addSubview:self.leftPickerView];
    [self.view addSubview:self.rightPickerView];
    
    [self setupPickerOverlay];
}


- (void) setupButtons
{
    CGFloat buttonPadding = 3;
    CGPoint buttonOrigin = CGPointMake(0, (self.leftPickerView.frame.origin.y + self.leftPickerView.frame.size.height + 4));
    CGSize buttonSize = CGSizeMake(bounds.size.width*0.33, ((bounds.size.height - buttonOrigin.y - self.tabBarController.tabBar.frame.size.height - 4)/4) - buttonPadding -5);
    UIColor *backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.2];
    NSArray *buttons    = @[self.sevenButton,self.eightButton,self.nineButton,
                            self.fourButton,self.fiveButton,self.sixButton,
                            self.oneButton,self.twoButton,self.threeButton,
                            self.zeroButton,self.periodButton,self.clearButton];
    UIFont *font = [UIFont fontWithName:@"Verdana" size:20];
    
    
    int col = 0;
    int row = 0;
    
    for (int i=0; i<[buttons count]; i++)
    {
        CGFloat x = ((buttonSize.width + buttonPadding) * col) + buttonOrigin.x;
        CGFloat y = ((buttonSize.height + buttonPadding) * row) + buttonOrigin.y;
        
        UIButton *button = [buttons objectAtIndex:i];
        button.frame = CGRectMake(x, y, buttonSize.width, buttonSize.height);
        button.titleLabel.font = font;
        button.backgroundColor = backgroundColor;
        button.titleLabel.textColor = [UIColor whiteColor];
        [button addTarget:self action:@selector(buttonTouchDownInside:) forControlEvents:UIControlEventTouchDown];
        [button addTarget:self action:@selector(buttonTouchUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
        [button addTarget:self action:@selector(buttonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        
        row = (col == 2)? ++row: row;
        col = (col == 2)? 0: ++col;
        
        [self.view addSubview:button];
    }
    
    
    [self labelButtons];
}


- (void) labelButtons
{
    [self.oneButton setTitle:@"1" forState:UIControlStateNormal];
    [self.twoButton setTitle:@"2" forState:UIControlStateNormal];
    [self.threeButton setTitle:@"3" forState:UIControlStateNormal];
    [self.fourButton setTitle:@"4" forState:UIControlStateNormal];
    [self.fiveButton setTitle:@"5" forState:UIControlStateNormal];
    [self.sixButton setTitle:@"6" forState:UIControlStateNormal];
    [self.sevenButton setTitle:@"7" forState:UIControlStateNormal];
    [self.eightButton setTitle:@"8" forState:UIControlStateNormal];
    [self.nineButton setTitle:@"9" forState:UIControlStateNormal];
    [self.zeroButton setTitle:@"0" forState:UIControlStateNormal];
    [self.periodButton setTitle:@"." forState:UIControlStateNormal];
    [self.clearButton setTitle:@"C" forState:UIControlStateNormal];
}


- (void) setupPickerOverlay
{
    UIColor *color  = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0];
    CGFloat pickerTop = 44.0;
    CGFloat pickerBottom = 225.0;
    CGSize horizontalBar = CGSizeMake(self.bounds.size.width, 13.0);
    CGSize verticalBar = CGSizeMake(11.0, pickerBottom-pickerTop);
    
    UILabel *top    = [[UILabel alloc] init];
    top.frame = CGRectMake(0, pickerTop, horizontalBar.width, horizontalBar.height);
    top.backgroundColor = color;
    
    UILabel *bottom = [[UILabel alloc] init];
    bottom.frame = CGRectMake(0, pickerBottom-horizontalBar.height, horizontalBar.width, horizontalBar.height);
    bottom.backgroundColor = color;
    
    UILabel *left   = [[UILabel alloc] init];
    left.frame = CGRectMake(0, pickerTop, verticalBar.width, verticalBar.height);
    left.backgroundColor = color;
    
    UILabel *middle = [[UILabel alloc] init];
    middle.frame = CGRectMake((bounds.size.width/2) - verticalBar.width, pickerTop, verticalBar.width*2, verticalBar.height);
    middle.backgroundColor = color;
    
    UILabel *right  = [[UILabel alloc] init];
    right.frame = CGRectMake(bounds.size.width-verticalBar.width, pickerTop, verticalBar.width, verticalBar.height);
    right.backgroundColor = color;
    
    UILabel *selection = [[UILabel alloc] init];
    selection.frame = CGRectMake(0, pickerTop + (self.leftPickerView.frame.size.height/2) - 22.0, bounds.size.width, 44.0);
    selection.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];

    UILabel *selectionBorder = [[UILabel alloc] init];
    selectionBorder.frame = selection.frame;
    selectionBorder.backgroundColor = [UIColor clearColor];
    selectionBorder.layer.borderColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7].CGColor;
    selectionBorder.layer.borderWidth = 2.0;
    
    [self.view addSubview:selection];
    [self.view addSubview:selectionBorder];
    [self.view addSubview:top];
    [self.view addSubview:bottom];
    [self.view addSubview:left];
    [self.view addSubview:middle];
    [self.view addSubview:right];
    
}



/*********************
        Misc
 *********************/







/*********************
    Touch Events
 *********************/
- (void) inputTouched:(id)sender
{
    self.selectedInput = [sender tag];
    UIButton *selectedOverlay = (UIButton *)sender;
    UIButton *alternativeOverlay = (self.selectedInput == inputLeft)? self.rightInputOverlay: leftInputOverlay;
    
    selectedOverlay.layer.borderColor = [UIColor colorWithRed:44.0/255.0 green:228/255.0 blue:254.0/255.0 alpha:0.4].CGColor;
    selectedOverlay.layer.borderWidth = 3.0;
    selectedOverlay.layer.cornerRadius = 3.0;
    
    alternativeOverlay.layer.borderColor = [UIColor clearColor].CGColor;
    alternativeOverlay.layer.borderWidth = 0.0;
    alternativeOverlay.layer.cornerRadius = 0.0;
}


- (void) buttonTouchDownInside:(id)sender
{
    [(UIButton *)sender setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.4]];
}


- (void) buttonTouchUpInside:(id)sender
{
    [(UIButton *)sender setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.2]];
    
    NSLog(@"%@",[[(UIButton *)sender titleLabel] text]);
}


- (void) buttonTouchUpOutside:(id)sender
{
    [(UIButton *)sender setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.2]];
    
    NSLog(@"%@",[[(UIButton *)sender titleLabel] text]);
}





/*************************************
    PickerView Delegate Methods
 *************************************/
- (CGFloat) pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 50.0;
}


- (CGFloat) pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return self.leftPickerView.frame.size.width - 22;
}


- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [[self.calculator measurementTypesForCategory:self.category] objectAtIndex:row];
}


- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
}




/*************************************
 PickerView Datasource Methods
 *************************************/
- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return 1;
}


- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [[self.calculator measurementTypesForCategory:self.category] count];
}
@end
