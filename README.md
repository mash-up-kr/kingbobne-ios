# Role
- 

# Architecture
- Clean Architecture + MVVM (Based on **RxSwift**)
	- Entity
		- Data Model 
	- Data
		- DTO <-> Data Model
		- Moya (Service)
		- Repository
	- Presentation
		- ViewModel
		- View
			- UIKit base (+ SwfitUI)(Optional)
			- StoryBoard : View Controller = 1:1 (Optional)
				- Avoid merge conflicts.
			- Kingfisher

# Data Model
- user
	- UserProfile
	- MyProfile

	- Character
	- CharacterState
- auth
	- Token
- post
	- Post
- Recipe
	- Recipe

# Dependencies
- [RxSwfit](https://github.com/ReactiveX/RxSwift)
- [Moya](https://github.com/Moya/Moya)
- [Kingfisher](https://github.com/onevcat/Kingfisher)
- [Then](https://github.com/devxoul/Then)
- [Image Picker](https://developer.apple.com/documentation/uikit/uiimagepickercontroller)
- [Image Crop](https://github.com/TimOliver/TOCropViewController)
- [Codable](https://developer.apple.com/documentation/swift/codable)

# Coding Convention
- [Swift Coding Convention](https://google.github.io/swift)

# Target Version
- iOS 13
- Swift Package Manager 
