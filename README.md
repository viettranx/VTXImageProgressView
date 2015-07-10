# TXVImageProgressView
Image progress view for iOS

## Screenshot
<img src="https://www.dropbox.com/s/fss2v40kuxd6h99/Screen%20Shot%202015-07-10%20at%209.38.41%20AM.png?raw=1" />

## Usage
- Import folder TXVImageProgressView into your project

### 1. Storyboard
 After add custom class of UIView to TXVImageProgressView, you can set its properties on storyboard.

<img src="https://www.dropbox.com/s/ynh29kt5wkgs5ns/Screenshot%202015-07-10%2010.01.12.png?raw=1" />

### 2. Code
Sample for using with code
```
#import "TXVImageProgressView.h"
```
```
VTXImageProgressView *imgPV = [[VTXImageProgressView alloc] initWithFrame:CGRectMake(0, 0, 128, 128)];
    [imgPV setSourceImage:[UIImage imageNamed:@"heart"]];
    [imgPV setTintColor:[UIColor grayColor]];
    [imgPV setProgressColor:[UIColor blueColor]];
    [imgPV setProgress:50.0]; // your current progress value
    [imgPV setDirection:kVTXImageProgressBottom2Top]; // You can choose direction for progress view
  ```

## TO DO
- Improve performance
- Extends it to run with a custom text or label from user (like karaoke)

### Contribution: 
Enjoy merge requests!

# License
Just use it for FREE ! :)