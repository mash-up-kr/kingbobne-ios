//
//  CharacterView.swift
//  kingbobne-ios
//
//  Created by victhor on 2022/08/21.
//  Copyright © 2022 3999WG8MCQ. All rights reserved.
//

import SwiftUI
import Lottie

struct CharacterView: View {
    @StateObject var viewModel: CharacterViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            if (viewModel.viewState.characterVisible) {
                HStack {
                    Text(viewModel.viewState.characterType.nickname())
                        .font(Font(uiFont: UIFont.setFont(style: .Headline1Bold)))
                        .foregroundColor(Color(UIColor.Custom.brandOrange))
                    
                    Text("당첨")
                        .font(Font(uiFont: UIFont.setFont(style: .Headline1Regular)))
                        .foregroundColor(Color(UIColor.Custom.brownGray500))
                }.frame(alignment: .center)
                    .frame(maxWidth:.infinity)
                
                Text(viewModel.viewState.characterType.description())
                    .multilineTextAlignment(.center)
                    .font(Font(uiFont: UIFont.setFont(style: .Body2Regular)))
                    .foregroundColor(Color(UIColor.Custom.brownGray300))
                    .padding(EdgeInsets(top: 12, leading: 0, bottom: 0, trailing: 0))
                    .frame(alignment: .center)
                    .frame(maxWidth:.infinity)
                
                ZStack {
                    Image(uiImage: .img_characterBackground)
                        .frame(width: 228, height: 220, alignment: .center)
                    
                    Image(uiImage: viewModel.viewState.characterType.image())
                        .frame(width: 248, height: 248, alignment: .center)
                        .padding(EdgeInsets(top: 21, leading: 0, bottom: 0, trailing: 0))
                }
                .frame(maxWidth:.infinity, alignment: .top)
                .padding(EdgeInsets(top: 36, leading: 0, bottom: 0, trailing: 0))
                
                Text("이제 끼록을 시작해볼까요?")
                    .multilineTextAlignment(.center)
                    .font(Font(uiFont: UIFont.setFont(style: .Body1Regular)))
                    .foregroundColor(Color(UIColor.Custom.brownGray400))
                    .padding(EdgeInsets(top: 4, leading: 0, bottom: 0, trailing: 0))
                    .frame(alignment: .center)
                    .frame(maxWidth:.infinity, alignment: .top)
                
                Spacer()
                Button(action: {
                    self.viewModel.start()
                }) {
                    Text("시작하기")
                        .frame(maxWidth: .infinity, minHeight: 48, maxHeight: 48, alignment: .center)
                        .font(Font(uiFont: UIFont.setFont(style: .Body1Bold)))
                        .background(Color(UIColor.Custom.brandOrange))
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                }
            } else {
                Text("사용자 닉네임과 어울리는\n캐릭터를 찾고있어요...")
                    .font(Font(uiFont: UIFont.setFont(style: .Headline1Regular)))
                    .foregroundColor(Color(UIColor.Custom.brownGray500))
                
                LottieView(filename: "loading.json")
                    .padding(EdgeInsets(top: 24, leading: 31, bottom: 0, trailing: 31))
            }
        }.padding(EdgeInsets(top: 82, leading: 24, bottom: 20, trailing: 24))
    }
}

extension CharacterType {
    func nickname() -> String {
        switch self {
        case .BROCCOLI: return "활발한 브로콜리"
        case .CARROT: return "감성적인 당근"
        case .GREEN_ONION: return "카리스마 대파"
        }
    }
    
    func description() -> String {
        switch self {
        case .BROCCOLI: return "와썹 가이즈~\n내 풍성한 머리 좀 볼래?ㅋㅋ"
        case .CARROT: return "안녕하세요!\n저는 흔하디 흔한 당근이에요>.<"
        case .GREEN_ONION: return "반가워! 나는 멋쟁이 대파!\n라면에 대파 안 넣으면 미워할꺼야"
        }
    }
    
    func image() -> UIImage {
        switch self {
        case .BROCCOLI: return .ic_alarm_44
        case .CARROT: return .ic_alarm_44
        case .GREEN_ONION: return .ic_alarm_44
        }
    }
}

struct LottieView: UIViewRepresentable {
  
  //makeCoordinator를 구현하여 제약사항을 구현합니다.
  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
  

  //json파일명을 받을 프로퍼티
  var filename: String
  
  //lottie View
  var animationView = AnimationView()
  
  
  class Coordinator: NSObject {
    var parent: LottieView
    
    init(_ animationView: LottieView) {
      //frame을 LottieView로 할당합니다.
      self.parent = animationView
      super.init()
    }
  }
  
  func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
    let view = UIView()
    
    //lottie 구현뷰
    animationView.animation = Animation.named(filename)
    animationView.contentMode = .scaleAspectFit
    animationView.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(animationView)
    
    NSLayoutConstraint.activate([
      animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
      animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
    ])
    
    //애니메이션이 계속 반복되게합니다.
    animationView.loopMode = .loop
    animationView.play()
    return view
  }
  
  //updateView가 구현되어있지않습니다.
  func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
    
  }
}
