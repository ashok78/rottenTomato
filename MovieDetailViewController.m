//
//  MovieDetailViewController.m
//  RottenTomato
//
//  Created by Ashok Kumar on 1/25/15.
//  Copyright (c) 2015 ashok. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "UIImageView+AFNetworking.h"

@interface MovieDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *poster;

@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@end

@implementation MovieDetailViewController

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
    
    self.titleLabel.text = self.movie[@"title"];
    self.synopsisLabel.text = self.movie[@"synopsis"];
    
    NSString * tb = [self.movie valueForKeyPath:@"posters.thumbnail"];
    
    [self.poster setImageWithURL:[NSURL URLWithString:[tb stringByReplacingOccurrencesOfString:@"_tmb." withString:@"_ori."]]];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
