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

# Code Review
- [pn / dn rule](https://blog.banksalad.com/tech/banksalad-code-review-culture/)

# Branch Strategy
- branch merge strategy: [Squash and Merge](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/incorporating-changes-from-a-pull-request/about-pull-request-merges#squash-and-merge-your-pull-request-commits)
- [github flow](https://docs.github.com/en/get-started/quickstart/github-flow)
- naming convention
	- feature/{feature name}
	- release/{release version}
	- hotfix/{release version}

