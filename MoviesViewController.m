//
//  MoviesViewController.m
//  RottenTomato
//
//  Created by Ashok Kumar on 1/25/15.
//  Copyright (c) 2015 ashok. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"
#import "MovieDetailViewController.h"
#import "SVProgressHUD.h"

@interface MoviesViewController() <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *names;
@property (nonatomic, strong) NSArray *movies;
@property (strong, nonatomic) IBOutlet UIImageView *nwerroricon;
@property (strong, nonatomic) IBOutlet UILabel *nwerrorLabel;
@end


@implementation MoviesViewController

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
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 128;
    [SVProgressHUD show];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MovieCell" bundle:nil] forCellReuseIdentifier:@"MovieCell"];
    

    
    NSURL *url = [NSURL URLWithString:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=5dj8dhsygdzc2k5gtc2egxt3&limit=20&country=us"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    UIImage * myImage = [UIImage imageNamed: @"noun_4627_cc.svg"];
    
    self.nwerroricon = [[UIImageView alloc] initWithImage: myImage];
    self.nwerrorLabel.text = @"Network Error";
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSLog(@"Error: %@", connectionError);

        
        if(connectionError){

            
            NSLog(@"Network Error");
            [self.nwerroricon reloadInputViews];
            [self.nwerrorLabel reloadInputViews];
        }
        else{
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            self.movies = responseDictionary[@"movies"];
            [self.tableView reloadData];
          //  [self.nwerroricon removeFromSuperview];
           // [self.nwerrorLabel removeFromSuperview];
            
        }

        
        [SVProgressHUD dismiss];
                //NSLog(@"%@", responseDictionary);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *movie = self.movies[indexPath.row];
    
    cell.titleLabel.text = movie[@"title"];
    cell.synopsisLabel.text = movie[@"synopsis"];
    
    [cell.posterView setImageWithURL:[NSURL URLWithString:[movie valueForKeyPath:@"posters.thumbnail"]]];
    
    self.title = @"Movies";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MovieDetailViewController *vc = [[MovieDetailViewController alloc] init];
    
    vc.movie = self.movies[indexPath.row];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
