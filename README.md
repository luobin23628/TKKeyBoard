TKKeyBoard
==========

AFNetworking is a delightful networking library for iOS and Mac OS X. It's built on top of the [Foundation URL Loading System](http://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/URLLoadingSystem/URLLoadingSystem.html), extending the powerful high-level networking abstractions built into Cocoa. It has a modular architecture with well-designed, feature-rich APIs that are a joy to use.

Perhaps the most important feature of all, however, is the amazing community of developers who use and contribute to AFNetworking every day. AFNetworking powers some of the most popular and critically-acclaimed apps on the iPhone, iPad, and Mac.

Choose AFNetworking for your next project, or migrate over your existing projects—you'll be happy you did!


## Usage


### Use support keyBoard Type

1、`TKKeyboardTypeIntegerPad`<br/>
2、`TKKeyboardTypeUIntegerPad`<br/>
3、`TKKeyboardTypeHexPad`<br/>
4、`TKKeyboardTypeUnsignedHexPad`<br/>
5、`TKKeyboardTypeFloatPad`<br/>
6、`TKKeyboardTypeUnsignedFloatPad`

#### Example

```objective-c
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 70, 280, 44)];
    textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.font = [UIFont systemFontOfSize:20];
    textField.keyboardType = TKKeyboardTypeIntegerPad;
```

### Customize a keyboard

#### Creat TKKeyboardConfiguration object

```objective-c
    TKKeyboardConfiguration *configiration = [[TKKeyboardConfiguration alloc] init];
    configiration.keyboardType = TKKeyboardTypeIntegerPad;
    configiration.keyboardHeight = 216;
    configiration.backgroundColor = [UIColor colorWithWhite:179/255.0 alpha:1];
```

#### Creat TkLayout object

```objective-c
   TKGridLayout *layout = [[TKGridLayout alloc] init];
    layout.rowCount = 4;
    layout.columnCount = 3;
    configiration.layout = layout;
    [layout release];
```

#### Creat TKKeyItem object

```objective-c
    TKKeyItem *keyItem = [[TKKeyItem alloc] initWithInsertText:[NSString stringWithFormat:@"%d", i]];
    [keyItem release];
    configiration.keyItems = @[keyItem];
    [keyItem release];
```


```objective-c
    TKKeyboardConfiguration *configiration = [[TKKeyboardConfiguration alloc] init];
    configiration.keyboardType = TKKeyboardTypeIntegerPad;
    configiration.keyboardHeight = 216;
    configiration.backgroundColor = [UIColor colorWithWhite:179/255.0 alpha:1];
    
    TKGridLayout *layout = [[TKGridLayout alloc] init];
    layout.rowCount = 4;
    layout.columnCount = 3;
    configiration.layout = layout;
    [layout release];
    
    NSMutableArray *keyItems = [NSMutableArray array];
    for (int i = 0; i < 9; i++) {
        TKKeyItem *keyItem = [[TKKeyItem alloc] initWithInsertText:[NSString stringWithFormat:@"%d", i]];
        [keyItems addObject:keyItem];
        [keyItem release];
    }
    
    TKKeyItem *keyItem;
    keyItem = [[TKKeyItem alloc] initWithType:TKKeyItemTypePositiveOrNegative action:^(id<TKTextInput> textInput, TKKeyItem *keyItem) {
         [textInput positiveOrNegative];
    }];
    [keyItems addObject:keyItem];
    [keyItem release];

    keyItem = [[TKKeyItem alloc] initWithInsertText:@"0"];
    [keyItems addObject:keyItem];
    [keyItem release];
    
    keyItem = [[TKKeyItem alloc] initWithType:TKKeyItemTypeDelete action:^(id<TKTextInput> textInput, TKKeyItem *keyItem) {
        [textInput deleteBackward];
    }];
    keyItem.enablesAutomatically = NO;
    keyItem.enableLongPressRepeat = YES;
    keyItem.backgroundColor = [UIColor colorWithWhite:225/255.0 alpha:1];
    keyItem.highlightBackgroundColor = [UIColor colorWithWhite:251/255.0 alpha:1];
    [keyItems addObject:keyItem];
    [keyItem release];
    
    configiration.keyItems = keyItems;
    [[TKKeyboardManager shareInstance] registerKeyboardConfiguration:configiration];
    [configiration release];
}];
```

### AFURLSessionManager

`AFURLSessionManager` creates and manages an `NSURLSession` object based on a specified `NSURLSessionConfiguration` object, which conforms to `<NSURLSessionTaskDelegate>`, `<NSURLSessionDataDelegate>`, `<NSURLSessionDownloadDelegate>`, and `<NSURLSessionDelegate>`.

#### Creating a Download Task

```objective-c
NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];

NSURL *URL = [NSURL URLWithString:@"http://example.com/download.zip"];
NSURLRequest *request = [NSURLRequest requestWithURL:URL];

NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
    NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
} completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
    NSLog(@"File downloaded to: %@", filePath);
}];
[downloadTask resume];
```

#### Creating an Upload Task

```objective-c
NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];

NSURL *URL = [NSURL URLWithString:@"http://example.com/upload"];
NSURLRequest *request = [NSURLRequest requestWithURL:URL];

NSURL *filePath = [NSURL fileURLWithPath:@"file://path/to/image.png"];
NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithRequest:request fromFile:filePath progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
    if (error) {
        NSLog(@"Error: %@", error);
    } else {
        NSLog(@"Success: %@ %@", response, responseObject);
    }
}];
[uploadTask resume];
```

#### Creating an Upload Task for a Multi-Part Request, with Progress

```objective-c
NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:@"http://example.com/upload" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:@"file://path/to/image.jpg"] name:@"file" fileName:@"filename.jpg" mimeType:@"image/jpeg" error:nil];
    } error:nil];

AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
NSProgress *progress = nil;

NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:&progress completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
    if (error) {
        NSLog(@"Error: %@", error);
    } else {
        NSLog(@"%@ %@", response, responseObject);
    }
}];

[uploadTask resume];
```

#### Creating a Data Task

```objective-c
NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];

NSURL *URL = [NSURL URLWithString:@"http://example.com/upload"];
NSURLRequest *request = [NSURLRequest requestWithURL:URL];

NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
    if (error) {
        NSLog(@"Error: %@", error);
    } else {
        NSLog(@"%@ %@", response, responseObject);
    }
}];
[dataTask resume];
```

### Maintainers

- [LuoBin](https://github.com/luobin23628) ([@luobin](mailto:luobin23628@163.com?subject=TKKeyboard))

## License

AFNetworking is available under the Apache v2 license. See the LICENSE file for more info.
