//
//  ViewController.m
//  Deprocrastinator
//
//  Created by Matthew Bradshaw on 1/12/15.
//  Copyright (c) 2015 Matthew Bradshaw. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *userEntry;
@property (strong, nonatomic) IBOutlet UITableView *userEntryTableView;

@property NSMutableArray *userEntries;
@property NSMutableString *userString;
@property NSIndexPath *deleteIndexPath;

@end

@implementation ViewController

- (void)viewDidLoad {
    NSLog(@"<%@:%@:%d>", NSStringFromClass([self class]), NSStringFromSelector(_cmd), __LINE__);

    [super viewDidLoad];


    self.userEntries = [NSMutableArray arrayWithObjects: nil];

}

- (IBAction)onAddButtonPressed:(UIButton *)sender {
    NSLog(@"<%@:%@:%d>", NSStringFromClass([self class]), NSStringFromSelector(_cmd), __LINE__);

    NSString *myUserEntry = self.userEntry.text;
    [self.userEntries addObject:myUserEntry];

//    NSLog(@"my user entry %@", myUserEntry);
//    NSLog(@"self.userEntries.count %lu", (unsigned long)self.userEntries.count);

    self.userEntry.text = @"";
    [self.userEntry resignFirstResponder];
    [self.userEntryTableView reloadData];

}
#pragma mark OnEdit
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    NSString *titleItem = [self.userEntries objectAtIndex:sourceIndexPath.row];
    [self.userEntries removeObject:titleItem];
    [self.userEntries insertObject:titleItem atIndex:destinationIndexPath.row];

}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{

    [self.userEntries removeObjectAtIndex:indexPath.row];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        self.deleteIndexPath = indexPath;
    }


    [self.userEntryTableView reloadData];
}

- (IBAction)onEditButtonPressed:(UIBarButtonItem *)sender {

    if (self.userEntryTableView.editing) {
        self.editing = false;
        [self.userEntryTableView setEditing:NO animated:YES];
        sender.style = UIBarButtonItemStylePlain;
        sender.title = @"Edit";
    } else {
        self.editing = true;
        [self.userEntryTableView setEditing:YES animated:YES];
        sender.style = UIBarButtonItemStyleDone;
        sender.title = @"Done";
        [sender setTitle:@"Done"];
//        [self superDuper];
    }

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self.userEntries removeObjectAtIndex:self.deleteIndexPath.row];
        [self.userEntryTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:self.deleteIndexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


-(void)superDuper {
    NSLog(@"LOVE");
    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"ALERT" message:@"Are you sure you want to DELETE?"
                                                  delegate:self
                                         cancelButtonTitle:@"Cancel"
                                         otherButtonTitles:@"Delete", nil];
    [alert show];

}
#pragma mark SwipeGestures
- (IBAction)onSwipeRight:(UISwipeGestureRecognizer *)sender {
    CGPoint location  = [sender locationInView:self.userEntryTableView];
    NSIndexPath *indexPath = [self.userEntryTableView indexPathForRowAtPoint:location];
    UITableViewCell *swipedCell = [self.userEntryTableView cellForRowAtIndexPath:indexPath];



//    swipedCell.textLabel.textColor = [UIColor blackColor];
    if (swipedCell.textLabel.textColor == [UIColor blackColor]) {
        swipedCell.textLabel.textColor = [UIColor redColor];

    } else if (swipedCell.textLabel.textColor == [UIColor redColor]){
        swipedCell.textLabel.textColor = [UIColor yellowColor];

    } else if (swipedCell.textLabel.textColor == [UIColor yellowColor]) {
        swipedCell.textLabel.textColor = [UIColor greenColor];

    } else if (swipedCell.textLabel.textColor == [UIColor greenColor]) {
        swipedCell.textLabel.textColor = [UIColor blackColor];

    }

}


#pragma mark UITableViewDataSource



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"<%@:%@:%d>", NSStringFromClass([self class]), NSStringFromSelector(_cmd), __LINE__);
    NSLog(@"self.userEntries.count %lu", (unsigned long)self.userEntries.count);
    return self.userEntries.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"<%@:%@:%d>", NSStringFromClass([self class]), NSStringFromSelector(_cmd), __LINE__);

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ToDoCellID"];
    cell.textLabel.text = [self.userEntries objectAtIndex:indexPath.row];
    NSLog(@"cell.textLabel.text %@", cell.textLabel.text);
//    cell.textLabel.textColor = [UIColor blueColor];


    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor greenColor];

    NSLog(@" cell.textLabel %@", cell.textLabel);

}


@end
