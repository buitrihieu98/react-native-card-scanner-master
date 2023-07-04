#import "CardScanner.h"

@interface RCT_EXTERN_MODULE(CardScannerModules, NSObject);

RCT_EXTERN_METHOD(startScanner:(RCTPromiseResolveBlock) resolve
                  withRejecter: (RCTPromiseRejectBlock) reject)

@end
