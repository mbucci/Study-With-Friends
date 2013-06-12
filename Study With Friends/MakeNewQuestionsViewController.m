//
//  MakeNewQuestionsViewController.m
//  MakeNewGame
//
//  Created by Sharif Younes on 5/12/13.
//  Copyright (c) 2013 Sharif Younes. All rights reserved.
//

#import "MakeNewQuestionsViewController.h"
#import "MakeNewGameViewController.h"
#import "ReviewGameViewController.h"
#import "ColorsModel.h"
#import "QuestionsModel.h"
#import <QuartzCore/QuartzCore.h>

@interface MakeNewQuestionsViewController ()

@property (nonatomic, strong) QuestionsModel *model;
@property (nonatomic, strong) ColorsModel *colorsModel;

@end

@implementation MakeNewQuestionsViewController

@synthesize model;
@synthesize back, next;
@synthesize question;
@synthesize optionA, optionB, optionC, optionD, correctResponse;
@synthesize addOptionCOutlet, addOptionDOutlet;
@synthesize deleteOutlet, revertOutlet, saveOutlet, makeOutlet;
@synthesize deleteOptionCOutlet, deleteOptionDOutlet;
@synthesize questionSavedMessage;
@synthesize gameTitle;
@synthesize courseName;
@synthesize gameLength;
@synthesize optionNumbers, tempAnswerKey, tempQuestionSet, finalAnswerKey, finalQuestionSet;
@synthesize gamesToAddTo = _gamesToAddTo;
@synthesize gameCreated = _gameCreated;

@synthesize colorsModel;

int questionNumber = 1;
BOOL enteredCorrectAnswer;

NSArray *formTextViewSet;
NSArray *bottomButtonSet;
NSArray *lettersForNumbers;
NSArray *deleteButtonSet;
NSArray *addButtonSet;

#define MAX_OPTION_CHARS = 150
#define MAX_QUESTION_CHARS = 250
#define MAX_CORRECT_RESPONSE_CHARS = 1

- (NSArray *)lettersForNumbers
{
    if (!lettersForNumbers)  {
        lettersForNumbers = [NSArray arrayWithObjects:@"", @"A", @"B", @"C", @"D", nil];
    }
    return lettersForNumbers;
}

-(QuestionsModel*) model {
    if(!model) {
        model = [[QuestionsModel alloc] init];
    }
    return model;
}
-(ColorsModel*) colorsModel {
    if(!colorsModel) {
        colorsModel = [[ColorsModel alloc] init];
    }
    return colorsModel;
}
-(NSArray*) formTextViewSet {
    if(!formTextViewSet) {
        formTextViewSet = [NSArray arrayWithObjects: question, optionA, optionB, optionC, optionD, nil];
    }
    return formTextViewSet;
}
-(NSArray*) bottomButtonSet {
    if(!bottomButtonSet) {
        bottomButtonSet = [NSArray arrayWithObjects: deleteOutlet, revertOutlet, saveOutlet, makeOutlet, nil];
    }
    return bottomButtonSet;
}
-(NSArray*) deleteButtonSet {
    if(!deleteButtonSet) {
        deleteButtonSet = [NSArray arrayWithObjects: deleteOptionCOutlet, deleteOptionDOutlet, nil];
    }
    return deleteButtonSet;
}
-(NSArray*) addButtonSet {
    if(!addButtonSet) {
        addButtonSet = [NSArray arrayWithObjects: addOptionCOutlet, addOptionDOutlet, nil];
    }
    return addButtonSet;
}
-(NSMutableArray*) optionNumbers {
    if(!optionNumbers) {
        optionNumbers = [[NSMutableArray alloc] init];
    }
    return optionNumbers;
}

-(NSMutableArray*) tempQuestionSet {
    if(!tempQuestionSet) {
        tempQuestionSet = [[NSMutableArray alloc] init];
    }
    return tempQuestionSet;
}

-(NSMutableArray*) tempAnswerKey {
    if(!tempAnswerKey) {
        tempAnswerKey = [[NSMutableArray alloc] init];
    }
    return tempAnswerKey;
}
-(NSMutableArray*) finalQuestionSet {
    if(!finalQuestionSet) {
        finalQuestionSet = [[NSMutableArray alloc] init];
    }
    return finalQuestionSet;
}

-(NSMutableArray*) finalAnswerKey {
    if(!finalAnswerKey) {
        finalAnswerKey = [[NSMutableArray alloc] init];
    }
    return finalAnswerKey;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ReviewGameViewController *RGVC = [segue destinationViewController];
    RGVC.gameTitle = self.gameTitle;
    RGVC.gameLength = self.gameLength;
    RGVC.courseTitle = self.courseName;
    RGVC.answerKey = self.finalAnswerKey;
    RGVC.questionSet = self.finalQuestionSet;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //design screen
    [self designScreenWithNumberOfOptions: 2 fromNumberOfOptions: 2];
    [self designTextViews];
    [self designButtons];
    
    //add a number of options for this question
    [self.optionNumbers addObject: [NSNumber numberWithInt:2]];
    
    //initialize the temp question and correct response and add to appropriate temporary storage arrays
    
    NSMutableArray *tempQuestion = [[NSMutableArray alloc] initWithObjects:@"", @"", @"", nil];
    [self.tempQuestionSet addObject: tempQuestion];
    [self.tempAnswerKey addObject: @""];
    self.gameCreated = NO;
    questionNumber = 1;
}

- (void)viewDidAppear:(BOOL)animated
{
    if (self.gameCreated) {
        [self exit:self.deleteOutlet];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/* -------------------------------
 
 Text management stuff
 
 ---------------------------------- */


- (BOOL)textView:(UITextView *)textViewEdited shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    //enter goes to next text view
    if([text isEqualToString:@"\n"]) {
        [textViewEdited resignFirstResponder];
        if(textViewEdited == correctResponse) {
           // [self responseFieldFilledOut];
        }
    }
    return TRUE;
}

-(void)textViewDidChange:(UITextView *)textView {
    [textView.text stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    if(textView == correctResponse) {
        
    }
    else {
        [self handleTextViewEntry:textView];
    }
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView {
    if([textView.textColor isEqual:[UIColor lightGrayColor]]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    return TRUE;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if(![textView hasText] && textView != correctResponse){
        textView.textColor = [UIColor lightGrayColor];
        if(textView == question){
            textView.text = [NSString stringWithFormat:@"Enter Question %i", questionNumber];
        }
        else if (textView == correctResponse) {
            textView.text = @"Correct";
        }
        else{
            int number = [self.formTextViewSet indexOfObject:textView];
            NSString *letter = [lettersForNumbers objectAtIndex: number];
            textView.text = [NSString stringWithFormat:@"Enter Option %@", letter];
        }
        [textView resignFirstResponder];
    }
    if (textView == correctResponse) {
        if([textView hasText]) {
            [self responseFieldFilledOut];
        }
        else {
            correctResponse.text = @"Correct";
            correctResponse.textColor = [UIColor lightGrayColor];
        }
    }
}





/* ----------------------------------
 
 DESIGN STUFF
 
---------------------------------- */


-(void) designScreenWithNumberOfOptions: (int) optionNumber fromNumberOfOptions: (int) previousOptionNumber {
    questionSavedMessage.hidden = TRUE;
    self.navigationItem.title = [NSString stringWithFormat:@"Enter Question %d", questionNumber];
    
    //based on option number
    if(optionNumber == previousOptionNumber) {
        //add text views and buttons according to number
        //text views
        for(int i = 0; i < [self.formTextViewSet count]; i++) {
            UITextView *textView = [self.formTextViewSet objectAtIndex:i];
            if( i <= optionNumber) {
                textView.hidden = FALSE;
            }
            else {
                textView.hidden = TRUE;
            }
        }
        //add (add buttons)
        for(int i = 0; i < [self.addButtonSet count]; i++) {
            UIButton *addBtn = [self.addButtonSet objectAtIndex:i];
            if(optionNumber  - 2 == i) {
                addBtn.hidden = FALSE;
            }
            else {
                addBtn.hidden = TRUE;
            }
        }
        
        //add (delete buttons)
        for( int i = 0; i < [self.deleteButtonSet count]; i++) {
            UIButton *deleteBtn = [self.deleteButtonSet objectAtIndex:i];
            if(optionNumber  - 3 == i) {
                deleteBtn.hidden = FALSE;
            }
            else {
                deleteBtn.hidden = TRUE;
            }
        }
         
    }
    else if(optionNumber == 4) {
        [self fadeInOption:optionD];
        [self fadeInButton:deleteOptionDOutlet];
    }
    else if(optionNumber == 3) {
        [self fadeInButton:addOptionDOutlet];
        [self fadeInButton:deleteOptionCOutlet];
    }
    else if(optionNumber == 2) {
        [self fadeOutOption:optionC];
        [self fadeInButton:addOptionCOutlet];
    }

    //based on previous option number
    if(optionNumber == previousOptionNumber) {
        //do nothing
    }
    else if(previousOptionNumber == 4) {
        [self fadeOutOption:optionD];
        [self fadeOutButton:deleteOptionDOutlet];
    }
    else if(previousOptionNumber == 3) {
        [self fadeOutButton:addOptionDOutlet];
        [self fadeOutButton:deleteOptionCOutlet];
    }
    else if(previousOptionNumber == 2) {
        [self fadeInOption:optionC];
        [self fadeOutButton:addOptionCOutlet];
    }
}


-(void) designTextViews {
    //design correct response text view
    [correctResponse setReturnKeyType: UIReturnKeyDone];
    [correctResponse setBackgroundColor:[UIColor whiteColor]];
    [correctResponse setTextColor: [UIColor lightGrayColor]];
    correctResponse.layer.borderColor = [[self.colorsModel secondaryOutline] CGColor];
    correctResponse.layer.borderWidth = 1.5f;
    correctResponse.layer.cornerRadius = 4;
    correctResponse.text = @"Correct";
    
    //design question/option text views
    for(UITextView *textView in self.formTextViewSet) {
        [textView setReturnKeyType: UIReturnKeyDone];
        [textView setBackgroundColor:[UIColor whiteColor]];
        [textView setTextColor: [UIColor lightGrayColor]];
        
        //option text view borders
        if(textView != question) {
            textView.layer.borderColor = [[self.colorsModel secondaryOutline] CGColor];
            textView.layer.borderWidth = 1.5f;
            textView.layer.cornerRadius = 4;
            textView.text = [NSString stringWithFormat:@"Enter option %@", [self.lettersForNumbers objectAtIndex: [self.formTextViewSet indexOfObject:textView]]];
        }
        //give question text view different border
        else{
            textView.layer.borderColor = [[UIColor blackColor] CGColor];
            textView.layer.borderWidth = 1.5f;
            textView.layer.cornerRadius = 6;
            textView.text = [NSString stringWithFormat:@"Enter question %i", questionNumber];
        }
    }
}

-(void) designButtons {
    for(UIButton *btn in self.bottomButtonSet) {
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
        
        [btn setBackgroundColor:[UIColor whiteColor]];
        btn.layer.cornerRadius = 3.0f;
        btn.layer.masksToBounds = NO;
        btn.layer.borderWidth = 1.0f;
        btn.layer.shadowColor = [UIColor blackColor].CGColor;
        btn.layer.borderColor = [UIColor grayColor].CGColor;
        btn.layer.shadowOpacity = 0.8;
        btn.layer.shadowRadius = 3;
        btn.layer.shadowOffset = CGSizeMake(0.0f, 2.0f);
    }
    //buttons to add options C,D
    for(UIButton *btn in self.addButtonSet) {
        UIImage *btnImage = [UIImage imageNamed:@"addSign.png"];
        [btn setImage:btnImage forState:UIControlStateNormal];
        
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [btn.titleLabel setFont:[UIFont fontWithName:@"Orienta" size:16.0f]];
        
        //draw a custom gradient
        CAGradientLayer *btnGradient = [CAGradientLayer layer];
        btnGradient.frame = btn.bounds;
        btnGradient.colors = [NSArray arrayWithObjects:
                              (id)[[self.colorsModel addButtonTopColor] CGColor],
                              (id)[[self.colorsModel addButtonBottomColor] CGColor],
                              (id)[[self.colorsModel addButtonTopColor] CGColor],
                              nil];
        [btnGradient setCornerRadius:6.0f];
        [btn.layer insertSublayer:btnGradient atIndex:0];
        
        // Round button corners
        [btn.layer setCornerRadius:6.0f];
       
        
        
        //border
        [btn.layer setBorderWidth:2.0f];
        [btn.layer setBorderColor:[[UIColor whiteColor] CGColor]];
        //shadow
        btn.layer.shadowRadius = 2;
        [btn.layer setShadowOffset:CGSizeMake(1, 1)];
        [btn.layer setShadowOpacity:1];
    }

    
    //buttons to delete options C,D
    for(UIButton *btn in self.deleteButtonSet) {
        UIImage *btnImage = [UIImage imageNamed:@"deleteSign.png"];
        [btn setImage:btnImage forState:UIControlStateNormal];
        
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [btn.titleLabel setFont:[UIFont fontWithName:@"Orienta" size:16.0f]];

        //draw a custom gradient
        CAGradientLayer *btnGradient = [CAGradientLayer layer];
        btnGradient.frame = btn.bounds;
        btnGradient.colors = [NSArray arrayWithObjects:
                              (id)[[self.colorsModel deleteButtonTopColor] CGColor],
                              (id)[[self.colorsModel deleteButtonBottomColor] CGColor],
                              (id)[[self.colorsModel deleteButtonTopColor] CGColor],
                              nil];
        [btnGradient setCornerRadius:6.0f];
        [btn.layer insertSublayer:btnGradient atIndex:0];
        
        // Round button corners
        [btn.layer setCornerRadius:6.0f];

        
        //border
        [btn.layer setBorderWidth:2.0f];
        [btn.layer setBorderColor:[[UIColor whiteColor] CGColor]];

        //shadow
        btn.layer.shadowRadius = 2;
        [btn.layer setShadowOffset:CGSizeMake(1, 1)];
        [btn.layer setShadowOpacity:.5];
    }
}

-(void) showOptionTextViewsWithNumberOfOptions: (int) optionNumber fromNumberOfOptions: (int) previousOptionNumber{
    for(int i = 1; i < [self.formTextViewSet count]; i++) {
        UITextView *textView = [self.formTextViewSet objectAtIndex: i];
        if(i == 0) {
            textView.hidden = FALSE;
        }
        else if(i <= optionNumber) {
            textView.hidden = FALSE;
        }
        else {
            textView.hidden = TRUE;
        }
    }
}


/* ----------------------------------
 
 BUTTON ACTIONS
 
 ---------------------------------- */

- (IBAction)addOptionC:(UIButton *)sender {
    [self fadeInOption: optionC];
    [self fadeInButton:deleteOptionCOutlet forButton:addOptionCOutlet];
    [self fadeInButton:addOptionDOutlet];
    [self.optionNumbers replaceObjectAtIndex: questionNumber - 1 withObject: [NSNumber numberWithInt:3]];
    //if option C had been filled out then deleted, add its text back to question set
    if([optionC.textColor isEqual: [UIColor blackColor]]){
        [[self.tempQuestionSet objectAtIndex:questionNumber-1] addObject: optionC.text];
    }
    //otherwise add in empty string
    else {
        [[self.tempQuestionSet objectAtIndex:questionNumber-1] addObject: @""];
    }
}

- (IBAction)addOptionD:(UIButton *)sender {
    [self fadeInOption: optionD];
    [self fadeInButton:deleteOptionDOutlet forButton:addOptionDOutlet];
    [self fadeOutButton:deleteOptionCOutlet];
    [self.optionNumbers replaceObjectAtIndex: questionNumber - 1 withObject: [NSNumber numberWithInt:4]];
    //if option D had been filled out then deleted, add its text back to question set
    if([optionD.textColor isEqual: [UIColor blackColor]]){
        [[self.tempQuestionSet objectAtIndex:questionNumber-1] addObject: optionD.text];
    }
    //otherwise add in empty string
    else{ 
        [[self.tempQuestionSet objectAtIndex:questionNumber-1] addObject: @""];
    }
}


- (IBAction)deleteOptionC:(UIButton *)sender {
    [self fadeOutOption:self.optionC];
    [self fadeInButton:self.addOptionCOutlet forButton:deleteOptionCOutlet];
    [self fadeOutButton:addOptionDOutlet];
    [self.optionNumbers replaceObjectAtIndex: questionNumber - 1 withObject: [NSNumber numberWithInt:2]];
    [[self.tempQuestionSet objectAtIndex:questionNumber-1] removeLastObject];
}

- (IBAction)deleteOptionD:(UIButton *)sender {
    [self fadeOutOption:self.optionD];
    [self fadeInButton:addOptionDOutlet forButton:deleteOptionDOutlet];
    [self fadeInButton:deleteOptionCOutlet];
    [self.optionNumbers replaceObjectAtIndex: questionNumber - 1 withObject: [NSNumber numberWithInt:3]];
    [[self.tempQuestionSet objectAtIndex:questionNumber-1] removeLastObject];
}



- (IBAction)makeGame:(UIButton *)sender {
    if([self.finalAnswerKey count] >= 1) {
        [self performSegueWithIdentifier: @"reviewGame" sender: self];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please save at least one question before creating game." message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    Game *newGame = [[Game alloc]init];
    newGame = [Game createGameWithTitle:self.gameTitle
                                 Course:self.courseName
                              Questions:self.finalQuestionSet
                                Answers:self.finalAnswerKey
                          andGameLength:self.gameLength];
    [self.gamesToAddTo addGame:newGame];
}

- (IBAction)saveQuestion:(UIButton *)sender {
    if([self canSaveQuestion]) {
        questionSavedMessage.hidden = FALSE;
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(removeSavedMessage) userInfo:nil repeats:NO];
        
        //add answer to answer key
        if([self.finalAnswerKey count] < questionNumber) {
            [self.finalAnswerKey addObject:[self.tempAnswerKey objectAtIndex:questionNumber-1]];
        }
        else {
            [self.finalAnswerKey replaceObjectAtIndex: questionNumber - 1 withObject:[self.tempAnswerKey objectAtIndex:questionNumber-1]];
        }
        //add question to question set
        if([self.finalQuestionSet count] < questionNumber) {
            [self.finalQuestionSet addObject:[NSMutableArray arrayWithArray:[self.tempQuestionSet objectAtIndex:questionNumber-1]]];
        }
        else {
            [self.finalQuestionSet replaceObjectAtIndex: questionNumber - 1 withObject: [NSMutableArray arrayWithArray:[self.tempQuestionSet objectAtIndex:questionNumber-1]]];
        }
    }
    else {
        NSString *errorString = @"Unable to save question. Please fill out all the entries.";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:errorString message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (IBAction)revertQuestion:(UIButton *)sender {
    //first make sure that there is even a saved question to revert to
    if([finalAnswerKey count] >= questionNumber) {
        //first step is to design the screen correctly, accounting for a change in the number of options
        int newOptionNumber = [[self.finalQuestionSet objectAtIndex:questionNumber-1] count]-1;
        int prevOptionNumber = [[optionNumbers objectAtIndex:questionNumber - 1] integerValue];
        [self designScreenWithNumberOfOptions:newOptionNumber fromNumberOfOptions:prevOptionNumber];
        
        //next we alter the temp question and answer key to match the saved one
        [self.tempQuestionSet replaceObjectAtIndex:questionNumber-1 withObject:[NSMutableArray arrayWithArray:[self.finalQuestionSet objectAtIndex:questionNumber-1]]];
        [self.tempAnswerKey replaceObjectAtIndex:questionNumber-1 withObject: [self.finalAnswerKey objectAtIndex:questionNumber-1]];
        
        //finally we change the text back to the original
        for(int i = 0; i < [self.formTextViewSet count] ; i++) {
            UITextView *textView = [self.formTextViewSet objectAtIndex:i];
            //if text view should hold a question/option
            textView.textColor = [UIColor blackColor];
            if(i < [[self.finalQuestionSet objectAtIndex:questionNumber-1] count]) {
                textView.text = [[self.finalQuestionSet objectAtIndex: questionNumber-1] objectAtIndex: i];
            }
            //else make the text view blank
            else {
                textView.textColor = [UIColor lightGrayColor];
                NSString *letter = [lettersForNumbers objectAtIndex: i];
                textView.text = [NSString stringWithFormat:@"Enter Option %@", letter];
            }
        }
        correctResponse.text = [self.finalAnswerKey objectAtIndex: questionNumber-1];
        correctResponse.textColor = [UIColor blackColor];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"There is no saved question to revert to." message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (IBAction)backButton:(UIBarButtonItem *)sender {
    if(questionNumber != 1){
        int prevOptions = [[self.tempQuestionSet objectAtIndex:questionNumber -1] count]-1;
        questionNumber --;
        int options = [[self.tempQuestionSet objectAtIndex:questionNumber -1] count]-1;
        [self designScreenWithNumberOfOptions:options fromNumberOfOptions:prevOptions];
        [self designTextViews];
        [self designButtons];
        //adds text to boxes that have been filled out
        for(int i = 0; i <= options; i++) {
            UITextView *textView = [self.formTextViewSet objectAtIndex:i];
            NSString *text = [[self.tempQuestionSet objectAtIndex:questionNumber-1] objectAtIndex:i];
            if(![text isEqualToString:@""]) {
                textView.text = text;
                textView.textColor = [UIColor blackColor];
            }
        }
        //adds text to correct answer box
        correctResponse.text = [self.tempAnswerKey objectAtIndex:questionNumber-1];
        correctResponse.textColor = [UIColor blackColor];
    }
}

- (IBAction)nextButton:(UIBarButtonItem *)sender {
    
    //if user has saved the current question
    if([self.finalAnswerKey count] > questionNumber - 1) {
        int prevOptions = [[self.tempQuestionSet objectAtIndex:questionNumber -1] count]-1;
        questionNumber ++;
        //if user has been to this question before and started filling it out
        if([self.tempQuestionSet count] >= questionNumber){
            int options = [[self.tempQuestionSet objectAtIndex:questionNumber -1] count]-1;
            [self designScreenWithNumberOfOptions:options fromNumberOfOptions:prevOptions];
            [self designTextViews];
            [self designButtons];
            
            //fills in text views
            for(int i = 0; i <= options; i++) {
                UITextView *textView = [self.formTextViewSet objectAtIndex:i];
                NSString *text = [[self.tempQuestionSet objectAtIndex:questionNumber-1] objectAtIndex:i];
                if(![text isEqualToString:@""]) {
                    textView.text = text;
                    textView.textColor = [UIColor blackColor];
                }
            }
            //adds text to correct answer box
            correctResponse.text = [self.tempAnswerKey objectAtIndex:questionNumber-1];
            correctResponse.textColor = [UIColor blackColor];        }
        else{
            //adds to temp question/answer set
            NSMutableArray *tempQuestion = [[NSMutableArray alloc] initWithObjects:@"", @"", @"", nil];
            [self.tempQuestionSet addObject: tempQuestion];
            [self.tempAnswerKey addObject: @""];
            
            //designs screen
            [self designScreenWithNumberOfOptions:2 fromNumberOfOptions:prevOptions];
            [self designTextViews];
            [self designButtons];
            
            //adds option number to array that tracks all the option numbers
            [self.optionNumbers addObject: [NSNumber numberWithInt:2]];
        }
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please complete and save this question before adding another one." message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (IBAction)exit:(id)sender {
    formTextViewSet = nil;
    bottomButtonSet = nil;
    lettersForNumbers = nil;
    deleteButtonSet = nil;
    addButtonSet = nil;
    self.gameTitle = nil;
    self.optionNumbers = nil;
    self.tempAnswerKey = nil;
    self.tempQuestionSet = nil;
    self.finalAnswerKey = nil;
    self.finalQuestionSet = nil;
    [self.navigationController popViewControllerAnimated:YES];
}


/* ----------------------------------
 
 BACKGROUND METHODS
 
 ---------------------------------- */

-(void) fadeInOption: (UITextView*) textView {
    CGRect newFrame = textView.frame;
    
    newFrame.size.height = 0;
    newFrame.size.width = 0;
    if(textView == optionC) {
        newFrame.origin.y = 218;
        textView.hidden = FALSE;
        
        textView.frame = newFrame;
        
        newFrame.size.height = 44;
        newFrame.size.width = 265;
        newFrame.origin.y = 196;
    }
    else if(textView == optionD) {
        newFrame.origin.y = 267;
        textView.hidden = FALSE;
        
        textView.frame = newFrame;
        
        newFrame.size.height = 44;
        newFrame.size.width = 265;
        newFrame.origin.y = 243;
    }
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.35];
    textView.frame = newFrame;
    [UIView commitAnimations];
}

-(void) fadeOutOption: (UITextView*) textView {
    CGRect newFrame = textView.frame;
    
    newFrame.size.height = 0;
    newFrame.size.width = 0;
    if(textView == optionC) {
        newFrame.origin.y = 218;
    }
    else if(textView == optionD) {
        newFrame.origin.y = 267;
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.35];
    textView.frame = newFrame;
    [UIView commitAnimations];
}

-(void) fadeInButton: (UIButton*) button {
    [NSTimer scheduledTimerWithTimeInterval:.15f
                                     target:self
                                   selector:@selector(timerFired:)
                                   userInfo: button
                                    repeats:NO];
}

- (void)timerFired:(NSTimer *)timer {
    UIButton* button = [timer userInfo];
    button.alpha = .0;
    button.hidden = FALSE;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.5];
    button.alpha = 1;
    [UIView commitAnimations];
}

-(void) fadeOutButton: (UIButton*) button {
    [NSTimer scheduledTimerWithTimeInterval:.1f
                                     target:self
                                   selector:@selector(timerFired2:)
                                   userInfo: button
                                    repeats:NO];
}

- (void)timerFired2:(NSTimer *)timer {
    UIButton* button = [timer userInfo];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.25];
    button.alpha = 0;
    [UIView commitAnimations];
}


-(void) fadeInButton: (UIButton*) button1 forButton: (UIButton*) button2 {
    button1.alpha = .4;
    button1.hidden = FALSE;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.25];
    button1.alpha = 1;
    button2.alpha = 0;
    [UIView commitAnimations];
}


-(void) responseFieldFilledOut {
    if([self isValidAnswer:correctResponse.text]) {
        enteredCorrectAnswer = TRUE;
        NSString *correctAnswer = [correctResponse.text capitalizedString];
        if([self.tempAnswerKey count] < questionNumber) {
            [self.tempAnswerKey addObject:correctAnswer];
        }
        else {
            [self.tempAnswerKey replaceObjectAtIndex: questionNumber - 1 withObject:correctAnswer];
        }
        correctResponse.text = correctAnswer;
        [correctResponse resignFirstResponder];
        
    }
    else {
        if([self.tempAnswerKey count] >= questionNumber) {
            correctResponse.text = @"Correct";
            [correctResponse setTextColor:[UIColor lightGrayColor]];
        }
        NSString *alertString = [NSString stringWithFormat:@"Correct answer must be a letter between A and %@.", [lettersForNumbers objectAtIndex:[[optionNumbers objectAtIndex:questionNumber-1] integerValue]]];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alertString message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(BOOL) isValidAnswer: (NSString*) correctAnswer {
    BOOL validAnswer = FALSE;
    for(int i = 1; i <= [[optionNumbers objectAtIndex:questionNumber-1] integerValue]; i++) {
        if([correctAnswer caseInsensitiveCompare:[lettersForNumbers objectAtIndex: i]] == NSOrderedSame) {
            validAnswer = TRUE;
        }
    }
    return validAnswer;
}

-(void) handleTextViewEntry: (UITextView*) textView {
    NSMutableArray *tempQuestion = [self.tempQuestionSet objectAtIndex:questionNumber-1];
    int textViewNumber = [self.formTextViewSet indexOfObject:textView];
    [tempQuestion replaceObjectAtIndex:textViewNumber withObject:textView.text];
    
}

-(BOOL) canSaveQuestion {
    BOOL formsFilledOut = TRUE;
    NSMutableArray *tempQuestion = [self.tempQuestionSet objectAtIndex:questionNumber-1];
    //some option left empty
    for(NSString *string in tempQuestion) {
        if([string isEqualToString:@""]) {
            formsFilledOut = FALSE;
        }
    }
    if(formsFilledOut && enteredCorrectAnswer) {
        return TRUE;
    }
    return FALSE;
}

-(void) removeSavedMessage {
    questionSavedMessage.hidden = TRUE;
}



@end
