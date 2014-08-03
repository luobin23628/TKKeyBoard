TKKeyBoard
==========

This library provides an alternative to the native iOS keyboard, support customize the look and feel of the keyboard.


## Usage


### Use already support keyboard type

1、`TKKeyboardTypeIntegerPad`<br/>
2、`TKKeyboardTypeUIntegerPad`<br/>
3、`TKKeyboardTypeHexPad`<br/>
4、`TKKeyboardTypeUnsignedHexPad`<br/>
5、`TKKeyboardTypeFloatPad`<br/>
6、`TKKeyboardTypeUnsignedFloatPad`

#### Use example

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
