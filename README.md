TKKeyBoard
==========

This library provides an alternative to the native iOS keyboard, support customize the look and feel of the keyboard.

<img width="320" height="568" src="https://raw.githubusercontent.com/luobin23628/TKKeyBoard/gh-pages/images/Screenshot%202014.08.06%2015.28.37.png" alt="alt text" title="Title" /> _ 
<img style="margin-left:20px" width="320" height="568" src="https://raw.githubusercontent.com/luobin23628/TKKeyBoard/gh-pages/images/Screenshot%202014.08.06%2015.28.44.png" alt="alt text" title="Title" />

Features
========

* Compatible with ios 5+
* Works like system keyboard.
* Runs on both iPhone and iPad.
* Customize the look of keyboard.
* Automatic orientation.
* MIT License (you can use it for commercial apps, edit and redistribute).

## Usage

You should only import `TKKeyboard.h`

### Use already support keyboard type

Let's start with a simple example
    
```objective-c
    UITextField *textField = [[UITextField alloc] init];
    textField.keyboardType = TKKeyboardTypeIntegerPad;
    [self.view addSubview:textField];
    [textField release];
```
    
This will display a integer keyboard, as simple as use system keyboard.

#### Support keyboard type

* `TKKeyboardTypeIntegerPad`
* `TKKeyboardTypeUIntegerPad`
* `TKKeyboardTypeHexPad`
* `TKKeyboardTypeUnsignedHexPad`
* `TKKeyboardTypeFloatPad`
* `TKKeyboardTypeUnsignedFloatPad`


### Customize a keyboard

#### TKKeyboardManager

`TKKeyboardManager` register a keyboard type based on a specified `TKKeyboardConfiguration` object.

#### Creat TKKeyboardConfiguration object

```objective-c
    TKKeyboardConfiguration *configiration = [[TKKeyboardConfiguration alloc] init];
    configiration.keyboardType = TKKeyboardTypeIntegerPad;
    configiration.keyboardHeight = 216;
    configiration.backgroundColor = [UIColor colorWithWhite:179/255.0 alpha:1];
```

#### Creat Layout object

Layout object is responsible for the layout of the key buttons. The type supported is TKGridLayout and TKFlowLayout, You can also customize a Layout object， which conforms to `TkLayout`.

```objective-c
   TKGridLayout *layout = [[TKGridLayout alloc] init];
    layout.rowCount = 4;
    layout.columnCount = 3;
    configiration.layout = layout;
    [layout release];
```

#### Creat TKKeyItem object

```objective-c
    TKKeyItem *keyItem = [[TKKeyItem alloc] initWithInsertText:@"1"];
    configiration.keyItems = @[keyItem];
    [keyItem release];
```

## Maintainers

- [LuoBin](https://github.com/luobin23628) ([Email:luobin23628@163.com](mailto:luobin23628@163.com?subject=TKKeyboard),   QQ:362906763)

## License

TKKeyboard is available under MIT license. See the LICENSE file for more info.
