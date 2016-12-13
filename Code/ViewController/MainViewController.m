//
//  MainViewController.m
//  iPhoneScreenRecoder
//
//  Created by Administrator on 16/12/14.
//  Copyright 2016 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "CSScreenRecorder.h"
#import <MediaPlayer/MediaPlayer.h>
@interface MainViewController () {
    BOOL shouldConnect;
    CSScreenRecorder *_screenRecorder;
    id routerController;
    
    IBOutlet UIView *_mpView;
    MPVolumeView *_volumeView;
    
    NSString *airplayName;
    
    IBOutlet UILabel *_lbInfo;
    IBOutlet UIButton *_btnRecord;
    IBOutlet UITextView *_infoTxtView;
    
    BOOL _isRecording;
    
}


@end

@implementation MainViewController

#pragma mark - AirPlay routeController
- (void)setupAirplayMonitoring
{
    
    if (!routerController) {
        routerController = [NSClassFromString(@"MPAVRoutingController") new];
        [routerController setValue:self forKey:@"delegate"];
        [routerController setValue:[NSNumber numberWithLong:2] forKey:@"discoveryMode"];
    }
}

-(void)routingControllerAvailableRoutesDidChange:(id)arg1{
    //NSLog(@"arg1-%@",arg1);
    if (airplayName == nil) {
        return;
    }
    
    NSArray *availableRoutes = [routerController valueForKey:@"availableRoutes"];
    for (id router in availableRoutes) {
        NSString *routerName = [router valueForKey:@"routeName"];
        //NSLog(@"routername -%@",routerName);
        if ([routerName rangeOfString:airplayName].length >0) {
            BOOL picked = [[router valueForKey:@"picked"] boolValue];
            if (picked == NO && !shouldConnect) {
                shouldConnect = YES;
                NSLog(@"connect once:%@",airplayName);
                NSString *path = @"pickRoute:";
                [routerController performSelector:NSSelectorFromString(path) withObject:router];
                //objc_msgSend(self.routerController,NSSelectorFromString(path),router);
            }
            return;
        }
    }
}

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    shouldConnect = NO;
    airplayName = [[NSString alloc] initWithString:@"XBMC-GAMEBOX(XinDawn)"];
    
    [self setupAirplayMonitoring];
    
    _screenRecorder = [CSScreenRecorder sharedCSScreenRecorder];
    
    _volumeView = [[[MPVolumeView alloc] initWithFrame:_mpView.bounds] autorelease];
    [_volumeView setShowsVolumeSlider:NO];
    [_volumeView sizeToFit];
    [_mpView addSubview:_volumeView];
    [_volumeView setShowsVolumeSlider:NO];
    [_volumeView setShowsRouteButton:NO];
    [_volumeView becomeFirstResponder];
    
    [_infoTxtView setBackgroundColor:[UIColor clearColor]];
}

- (void)viewDidAppear:(BOOL)animated{
    if (_screenRecorder != nil) {
        [_screenRecorder setDelegate:(id<CSScreenRecorderDelegate>)self];
    }
}

- (IBAction)toggleRecord:(id)sender {
    if(_isRecording)
    {
        [self stopRecord];
    }
    else
    {
        [self startRecord];
    }
}

- (void)startRecord{
    shouldConnect = NO;
    airplayName = @"XBMC-GAMEBOX(XinDawn)";
    
    NSString *filePath = [[UIApplication GetDocumentPath] stringByAppendingPathComponent:@"output.mp4"];
    [appHelper removefile:filePath];
    
    _screenRecorder.videoOutPath = [[UIApplication GetDocumentPath] stringByAppendingPathComponent:@"output"] ;
    [_screenRecorder startRecordingScreen];
    
    [_btnRecord setTitle:@"Stop" forState:UIControlStateNormal];
    [_btnRecord setBackgroundImage:[UIImage imageNamed:@"btn_recording.png"] forState:UIControlStateNormal];
    
    //[volumeView setRouteButtonImage:[UIImage imageNamed:@"btn_recording.png"] forState:UIControlStateNormal];
}

- (void)stopRecord{
    [_screenRecorder stopRecordingScreen];
    [_btnRecord setTitle:@"Start" forState:UIControlStateNormal];
    [_btnRecord setBackgroundImage:[UIImage imageNamed:@"btn_record.png"] forState:UIControlStateNormal];
    
    //[volumeView setRouteButtonImage:[UIImage imageNamed:@"btn_record.png"] forState:UIControlStateNormal];
    
    
}


#pragma mark - @protocol CSScreenRecorderDelegate <NSObject>
- (void)screenRecorderDidStartRecording:(CSScreenRecorder *)recorder{
    _isRecording = YES;
}
- (void)screenRecorderDidStopRecording:(CSScreenRecorder *)recorder{
    _lbInfo.text = @"";
    _isRecording = NO;
    
}
// Called every second.
- (void)screenRecorder:(CSScreenRecorder *)recorder recordingTimeChanged:(NSTimeInterval)recordingTime{ // time in seconds since start of capture
    if (_isRecording) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *string = [NSString stringWithFormat:@"%02li:%02li:%02li",
                                lround(floor(recordingTime / 3600.)) % 100,
                                lround(floor(recordingTime / 60.)) % 60,
                                lround(floor(recordingTime)) % 60];
            _lbInfo.text = string;
        });
        //NSLog(@"screenRecorder:recordingTimeChanged:%f",recordingTime);
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            _lbInfo.text = @"";
        });
    }
    
    
}
- (void)screenRecorder:(CSScreenRecorder *)recorder videoContextSetupFailedWithError:(NSError *)error{
    _isRecording = NO;
    NSLog(@"screenRecorder:videoContextSetupFailedWithError:%@",error);
}
- (void)screenRecorder:(CSScreenRecorder *)recorder audioSessionSetupFailedWithError:(NSError *)error{
    _isRecording = NO;
    NSLog(@"screenRecorder:audioSessionSetupFailedWithError:%@",error);
}
- (void)screenRecorder:(CSScreenRecorder *)recorder audioRecorderSetupFailedWithError:(NSError *)error{
    _isRecording = NO;
    NSLog(@"screenRecorder:audioRecorderSetupFailedWithError:%@",error);
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
