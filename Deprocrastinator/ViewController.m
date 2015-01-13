//
//  ViewController.m
//  Deprocrastinator
//
//  Created by Matthew Bradshaw on 1/12/15.
//  Copyright (c) 2015 Matthew Bradshaw. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITextField *userEntry;
@property (strong, nonatomic) IBOutlet UITableView *userEntryTableView;

@property NSMutableArray *userEntries;
@property NSMutableString *userString;

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
