# TV Shows

A simple application that allows user to log in, see list of TV shows and a TV show detail with a list of episodes. 

## Architecture

I decided to use MVVM+C pattern to separate business and navigation logic from view layer. 

### Coordinator 

Takes care of all the navigation, including alert presentation. Usually I use a library for Coordinator pattern implementation, but for this project I decided to make my own. 

### View Model 

Handles all the business logic, including API calls. It's defined by a protocol containing variables and functions visible for the View Controller. It uses observable LiveData to allow real-time view updates. 

### Data Provider

Common API calls implementation is defined in ApiDataProvider. Data Provider for each module is defined by an extension of ApiDataProvider conforming to specified protocol

### View Controller

Is just a dummy view that presents and updates content given by View Model 

## Dependencies 

Most of the libraries I chose for this app are the ones that I use on a daily basis. The main dependency manager is CocoaPods, however I also use SPM because one library lacks CocoaPods support. 

### SnapKit

Writing AutoLayout constraints programmatically can be a pain sometimes, but SnapKit makes it easy and fun. 

### Alamofire

Well-known networking library

### SwiftLint

Great tool for checking code style and conventions 

### PromiseKit

Promises are an ellegant way to handle asynchronous programming, mostly when dealing with API calls. 

### Kingfisher 

My favourite tool for downloading images with just one line of code 

### JVFloatLabeledTextField

UITextfield with a floating label and beautiful animation 

### ETBinding

Observable values and events

### ETPersistentValue

Easy and convenient UserDefaults wrapper
