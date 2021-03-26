//
//  ViewController.m
//  securiOS
//
//  Created by GeoSn0w on 3/9/21.
//

#import "ViewController.h"
#include <sys/stat.h>
#include "iSecureOS-Common.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 13.0, *)) {
            self.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
    }
    bool shouldNotScan = scanFileExists("/var/mobile/iSecureOS/ScanResult.json");
    
    if (shouldNotScan == false) {
        _currentStatus.text = @"You have never scanned.";
        _shieldStatus.image = [UIImage imageNamed: @"shielderr.png"];
    } else {
        
        _currentStatus.text = @"You have scanned before.";
        _shieldStatus.image = [UIImage imageNamed: @"shield.png"];
    }
     
    _secureOS_Load_Btn.layer.cornerRadius = 22;
    _secureOS_Load_Btn.clipsToBounds = YES;
    
    setuid(0);
    setgid(0);
    
    if (getuid() != 0){
        _secureOS_Load_Btn.enabled = NO;
        [_secureOS_Load_Btn setTitle:@"Not running as ROOT" forState:UIControlStateDisabled];
    }
}

bool scanFileExists (char *filename) {
  struct stat   buffer;
  return (stat (filename, &buffer) == 0);
}

- (IBAction)shouldScanDeep:(id)sender {
    UISwitch *scanDepth = (UISwitch *)sender;
        if ([scanDepth isOn]) {
            shouldPerformInDepthScan = true;
        } else {
            shouldPerformInDepthScan = false;
        }
}

@end
