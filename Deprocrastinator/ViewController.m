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
@property NSMutableArray *userEntries;
@property (strong, nonatomic) IBOutlet UITableView *userEntryTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    NSLog(@"<%@:%@:%d>", NSStringFromClass([self class]), NSStringFromSelector(_cmd), __LINE__);

    [super viewDidLoad];

    self.userEntries = [NSMutableArray arrayWithObjects: nil];

}

- (IBAction)onAddButtonPressed:(UIButton *)sender {
    NSLog(@"<%@:%@:%d>", NSStringFromClass([self class]), NSStringFromSelector(_cmd), __LINE__);

    if (self.userEntry.text) {
        NSString *myUserEntry = self.userEntry.text;
        [self.userEntries addObject:myUserEntry];
        NSLog(@"my user entry %@", myUserEntry);
        NSLog(@"self.userEntries.count %lu", (unsigned long)self.userEntries.count);
        [self.userEntryTableView reloadData];
//        self.userEntry.text = @"";
    }




//    if (self.userEntry.text) {
//        NSLog(@"We Have Entry %@", myUserEntry);
//    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"<%@:%@:%d>", NSStringFromClass([self class]), NSStringFromSelector(_cmd), __LINE__);

    return self.userEntries.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"<%@:%@:%d>", NSStringFromClass([self class]), NSStringFromSelector(_cmd), __LINE__);

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ToDoCellID"];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", self.userEntry.text];

    return cell;
}




@end
