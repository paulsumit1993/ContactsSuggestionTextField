# ContactsSuggestionTextField

A simple and adaptive subclass of UITextField which attaches a contact picker to the textfield's input accessory view. 

## Usage

To start using the component add it to your project using Carthage or manually as per the [Installation](#installation) section.

The UI component can be used via the `ContactsSuggestionTextField` class. This control can be used very similar to `UITextField` - both from Interface Builder, or from code.

To create an instance of the class, use Interface builder, or do it from code. This example will create a field which shows a short name and email address of a contact:

```swift
let textField = ContactsSuggestionTextField(frame: CGRect(x: 10, y: 10, width: 200, height: 45))

/// customize the textfield.
/// For Interface Builder, an IBOutlet can be created and the customize block can be created as illustrated below.
textField.customize = { builder in
builder.contactNameStyle = .short
builder.contactType = .emailAddress
}
self.view.addSubview(textField)
```
# Installation
#### Carthage
The component supports [Carthage](https://github.com/Carthage/Carthage). Start by making sure you have the latest version of Carthage installed. Using [Homebrew](http://brew.sh/) run this:
```shell
$ brew update
$ brew install carthage
```
Then add `ContactsSuggestionTextField` to your `Cartfile`:
```
github "paulsumit1993/ContactsSuggestionTextField"
```
Finally, add the framework to the Xcode project of your App. Link the framework to your App and copy it to the App’s Frameworks directory via the “Build Phases” section.

#### Manual

You can download the latest files from our [Releases page](https://github.com/paulsumit1993/ContactsSuggestionTextField/releases). After doing so, copy the files in the `ContactsSuggestionTextField` folder to your project.

## Contributing

We welcome all contributions. Just open an issue or submit pull requests, and we will take it forward.
