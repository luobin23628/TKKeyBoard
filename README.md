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

#### TKKeyboardManager

`TKKeyboardManager` register a keyboard type based on a specified `TKKeyboardConfiguration` object`.

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

### Maintainers

- [LuoBin](https://github.com/luobin23628) ([@luobin](mailto:luobin23628@163.com?subject=TKKeyboard))

## License

TKKeyboard is available under the Apache v2 license. See the LICENSE file for more info.
