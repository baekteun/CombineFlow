# CombineFlow

Navigation framework for iOS applications based on a Coordinator pattern.

<br>

## Constents
- [CombineFlow](#combineflow)
  - [Constents](#constents)
  - [Requirements](#requirements)
  - [Overview](#overview)
  - [Communication](#communication)
  - [Installation](#installation)
    - [Swift Package Manager](#swift-package-manager)
    - [Manually](#manually)
  - [Usage](#usage)
    - [Quick Start](#quick-start)


## Requirements
- iOS 13.0+
- Swift 5+

<br>

## Overview
Navigation framework for iOS applications based on a Coordinator pattern

CombineFlow is inspired [RxFlow](https://github.com/RxSwiftCommunity/RxFlow)

<br>

## Communication
- If you found a bug, open an issue.
- If you have a feature request, open an issue.
 - If you want to contribute, submit a pull request.

<br>

## Installation

### Swift Package Manager
[Swift Package Manager](https://www.swift.org/package-manager/) is a tool for managing the distribution of Swift code. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

To integrate `CombineFlow` into your Xcode project using Swift Package Manager, add it to the dependencies value of your Package.swift:

```swift
dependencies: [
    .package(url: "https://github.com/baekteun/CombineFlow.git", .upToNextMajor(from: "1.0.0"))
]
```

### Manually
If you prefer not to use either of the aforementioned dependency managers, you can integrate CombineFlow into your project manually.

<br>

## Usage

### Quick Start

```swift
// create a path
import CombineFlow

enum ExStep: Step {
    case main
}
```

```swift
// create a flow
import CombineFlow
import Combine
import UIKit

final class MainFlow: Flow {
    private let rootVC = UINavigationController()

    var root: Presentable {
        rootVC
    }

    // navigation
    func navigate(to step: any Step) -> FlowContributors {
        guard let step = step as? ExStep else { return .none }
        switch step {
          case .main:
              let vc = StepperViewController()
              rootVC.setViewControllers([vc], animated: true)
              return .one(.contribute(withNextPresentable: vc, withNextStepper: vc))
        }
        return .none
    }
}
```

