# Teltech Coding Challenge #2

For this coding challenge I've used MVVM Architecture with Coordinator pattern for navigation.

Communication between ViewModel and ViewController is done with RxSwift where I'm using ReplaySubject for input events that are binded to output which is represented with BehaviorRelay.

Whole flow should be easy to follow, because every input event is processed inside viewModel and results in some kind of output.

UI is done programatically using UIKit for UI elements, SnapKit for managing constraints and Kingfisher for loading images.

Network requests are processed with Alamofire with generic function inside RESTManager that returns observable objects so it can be used with RxSwift.
Repository pattern is implemented so code is more testable as every repository is injected as a dependecy and easily replaced with mock.

Strings localization, assets and colors are managed with R.Swift which provides strong typed and autocompleted resources.

At the moment proper API is not provided so I've created mock response from the JSON that was provided. If proper API is provided implementing it will be quick and easy job as everything is already prepared.
