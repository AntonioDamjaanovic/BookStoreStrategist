# BookStoreStrategist

This is a multiplatform app that shows book store statitistics with the SwiftCharts API. You can see bar, pie, line, and scatter plots.

[![Swift](https://img.shields.io/badge/Swift-5-F05138?logo=swift&logoColor=white)](https://swift.org)
[![SwiftUI](https://img.shields.io/badge/SwiftUI-Framework-007AFF?logo=swift&logoColor=white)](https://developer.apple.com/xcode/swiftui/)
[![iOS](https://img.shields.io/badge/iOS-17.0+-000000?logo=apple&logoColor=white)](https://developer.apple.com/ios/)
[![macOS](https://img.shields.io/badge/macOS-14.0+-000000?logo=apple&logoColor=white)](https://developer.apple.com/macos/)

<br>

<video src="https://github.com/user-attachments/assets/bb9cd2be-9a9c-4806-8f9c-3dd1497d0174" autoplay loop muted playsinline height="300px" width="300px"></video>

<br>

## Features

- **📊 Interactive Charts** — Bar, pie, line, and scatter plots powered by SwiftCharts
- **⚡ Reactive ViewModels** — Combine-driven data flow for real-time UI updates
- **✨ Smooth Animations** — Native SwiftUI transitions and chart animations
- **📱 Multiplatform** — Single codebase targeting both iOS and macOS

## Tech Stack

| Layer | Technology |
|-------|-----------|
| UI | SwiftUI |
| Charts | SwiftCharts |
| Data Flow | Combine + MVVM |
| Animations | SwiftUI Animations |

## Requirements

- Xcode 16+
- iOS 17.0+ / macOS 14.0+
- Swift 5

## Architecture

The app follows the **MVVM** pattern with Combine pipelines connecting data models to SwiftUI views. ViewModels publish transformed data streams that views subscribe to, keeping the UI reactive and the business logic testable. Platform-specific layouts (iOS vs macOS) are handled through dedicated content views sharing the same underlying ViewModels.
