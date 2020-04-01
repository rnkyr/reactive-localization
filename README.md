# Reactive localization with RxSwift and SwiftGen

![Swift 5.0](https://img.shields.io/badge/Swift-5.0-orange.svg) ![iOS 9+](https://img.shields.io/badge/iOS-9.0-orange.svg) ![swiftgen 6.1](https://img.shields.io/badge/swiftgen-6.1-green.svg) ![RxSwift](https://img.shields.io/badge/rxswift-5.0-green.svg)

## Overview

The project demonstrates an approach to localize your project with the ability to select interface language in run-time without the need to drastically change your codebase. 

Main requirements for a task were to reduce the number of changes needed to be introduced to support real-time language changing and to work with SwiftGen.

To achieve this, I decided to create a custom stencil for a SwiftGen and cover all the reactiveness there.

## How to use

- Add [rx_strings.stencil](rx_strings.stencil) to your project directory.

- Tune your swiftgen to use that stencil. 

At the time of writing, swiftgen does not support running codegen for strings twice, so instead of running simply `swiftgen`, you need to run it twice - default one and another one with parameters:
```
${PODS_ROOT}/SwiftGen/bin/swiftgen
${PODS_ROOT}/SwiftGen/bin/swiftgen strings Example/Supporting\ Files/en.lproj/Localizable.strings --templatePath rx_strings.stencil --output Example/Extensions/Swiftgen/RxStrings.swift
```

- Now you can use generated code

was:
```
label.title = L10n.someTitle
```
become:
```
label.localizedTitle = RxL10n.someTitle
```

- To change language, run `Bundle.setLanguage(with:)` passing exact language code.

The **Example** project demonstrates all the described steps.

## Implementation details

The `rx_strings.stencil` is based on `flat-swift4.stencil` and extends it to create additional helper methods for UIKit's classes, methods to change and manipulate localization schema. It also changes `tr` method to return `Observable<String>`. Nothing more changed, so you can copy-paste the code to any other stencil.

To use proper Bundle (e.g. "localized" one), stencil overrides `NSLocalizedString` method publicly. Each time language changed through `Bundle.setLanguage` it changes `currentLanguage` static variable, which triggers any subscribers that use `tr` method.

To improve API, stencil adds extensions for major UIKit classes with properties like `var localizedText: Observable<String>` that can be used to directly bind localized text.
