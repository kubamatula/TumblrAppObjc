// AFAppDotNetAPIClient.h
//
// Copyright (c) 2011–2016 Alamofire Software Foundation ( http://alamofire.org/ )
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "TumblrAPIClient.h"
#import "XMLDictionary.h"
#import "Post.h"

static NSString * const baseURLFormat = @"http://%@.tumblr.com/api/read/json";
typedef NSDictionary<NSString *, NSString *> * parameters;
@implementation TumblrAPIClient

+ (instancetype)sharedClient {
    static TumblrAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[TumblrAPIClient alloc] init];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"application/javascript", @"text/javascript", @"text/html", nil];
    });
    
    return _sharedClient;
}

- (NSURL *)postsURLForUser:(NSString* )username withParameters:(parameters) parameters {
    NSString *urlString = [NSString stringWithFormat: baseURLFormat, username];
    NSURLComponents *components = [NSURLComponents componentsWithString: urlString];
    NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray arrayWithCapacity: parameters.count];
    for (NSString * key in parameters) {
        NSString* value = parameters[key];
        [queryItems addObject: [NSURLQueryItem queryItemWithName:key value:value]];
    }
    [components setQueryItems: queryItems];
    return [components URL];
}

- (NSURLRequest *)postsRequestForUser:(NSString* )username withParameters:(parameters) parameters {
    NSURL *url = [self postsURLForUser:username withParameters:parameters];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: url cachePolicy: NSURLRequestReloadRevalidatingCacheData timeoutInterval: 10];
    return request;
}

- (void)fetchPostsForUser: (NSString *)username offset: (NSInteger) offset withBlock:(void (^)(NSArray<Post *> *posts, NSError *error))block {
    NSURLRequest *postsRequest = [self postsRequestForUser: username withParameters: @{@"debug": @"1", @"start": [NSString stringWithFormat: @"%ld", (long)offset]}];
    NSURLSessionDataTask *dataTask = [self dataTaskWithRequest:postsRequest completionHandler: ^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            block(@[], error);
        } else {
            NSLog(@"Request succesful");
            NSArray *postsFromResponse = [responseObject valueForKeyPath:@"posts"];
            NSArray<Post *> *posts = [Post postsWith: postsFromResponse];
            block(posts, error);
        }
    }];
    [dataTask resume];



}

@end
