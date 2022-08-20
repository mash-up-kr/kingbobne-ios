//
//  NIcknameView.swift
//  kingbobne-ios
//
//  Created by victhor on 2022/08/21.
//  Copyright © 2022 3999WG8MCQ. All rights reserved.
//

import SwiftUI

struct NicknameView: View {
    @StateObject var viewModel: NicknameViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("반가워요!\n닉네임을 설정해주세요")
                .font(Font(uiFont: UIFont.setFont(style: .Headline1Regular)))
                .foregroundColor(Color(UIColor.Custom.brownGray500))
            
            ZStack(alignment: .bottom) {
                TextField("닉네임", text: $viewModel.viewState.nickname)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .frame(maxWidth: .infinity)
                    .font(Font(uiFont: UIFont.setFont(style: .Body1Regular)))
                    .foregroundColor(Color(UIColor.Custom.brownGray500))
                    .padding(EdgeInsets(top: 36, leading: 0, bottom: 0, trailing: 0))
                    .onChange(of: viewModel.viewState.nickname) { newValue in
                        viewModel.validateNickname(nickname: newValue)
                    }
                
                HStack {
                    Spacer()
                    if (viewModel.viewState.nicknameLength != 0) {
                        if (viewModel.viewState.nicknameValidationState.validated) {
                            Image(uiImage: .ic_correct_20)
                        } else {
                            Image(uiImage: .ic_error_20)
                        }
                    }
                }
            }
            
            Divider()
                .foregroundColor(viewModel.viewState.nicknameValidationState.validated ? Color(UIColor.Custom.brownGray100) : Color(UIColor.Custom.redError))
                .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
            
            HStack {
                Spacer()
                Text(String(viewModel.viewState.nicknameLength) + "/10")
                    .foregroundColor(Color(UIColor.Custom.brownGray400))
                    .font(Font(uiFont: UIFont.setFont(style: .CaptionRegular)))
            }
            
            Spacer()
        
            Button(action: {
                viewModel.signUp()
            }) {
                Text("완료")
                    .frame(maxWidth: .infinity, minHeight: 48, maxHeight: 48, alignment: .center)
                    .font(Font(uiFont: UIFont.setFont(style: .Body1Bold)))
                    .background(viewModel.viewState.btnEnabled ? Color(UIColor.Custom.brandOrange) : Color(UIColor.Custom.brownGray100))
                    .foregroundColor(viewModel.viewState.btnEnabled ? Color.white : Color(UIColor.Custom.brownGray400))
                    .cornerRadius(10)
                    .disabled(!viewModel.viewState.btnEnabled)
            }
        }.padding(EdgeInsets(top: 30, leading: 24, bottom: 20, trailing: 24))
    }
}

