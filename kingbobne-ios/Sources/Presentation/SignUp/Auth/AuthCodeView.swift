//
//  AuthCodeView.swift
//  kingbobne-ios
//
//  Created by victhor on 2022/08/20.
//  Copyright © 2022 3999WG8MCQ. All rights reserved.
//

import SwiftUI

struct AuthCodeView: View {
    @StateObject var viewModel: AuthCodeViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("인증번호를 입력해주세요.")
                .font(Font(uiFont: UIFont.setFont(style: .Headline1Regular)))
                .foregroundColor(Color(UIColor.Custom.brownGray500))
            
            HStack {
                TextField("인증번호 6자리", text: $viewModel.viewState.authCode)
                    .font(Font(uiFont: UIFont.setFont(style: .Body1Regular)))
                    .foregroundColor(Color(UIColor.Custom.brownGray200))
                    .keyboardType(.decimalPad)
                
                Spacer()
                
                Button("재요청") {
                    self.viewModel.regenerateAuthCode()
                }.font(Font(uiFont: UIFont.setFont(style: .Body2Regular)))
                    .padding(EdgeInsets(top: 4, leading: 6, bottom: 4, trailing: 6))
                    .foregroundColor(Color(UIColor.Custom.brownGray300))
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color(UIColor.Custom.brownGray200), lineWidth: 1)
                    )
            }.padding(EdgeInsets(top: 31, leading: 0, bottom: 0, trailing: 0))
            Divider()
            Text("다음으로 전송된 인증번호 : " + viewModel.viewState.email + " \n전송된 인증번호는 10분 동안 유효합니다")
                .font(Font(uiFont: UIFont.setFont(style: .CaptionRegular)))
                .foregroundColor(Color(UIColor.Custom.brownGray400))
            Spacer()
            Button(action: {
                self.viewModel.authenticate()
            }) {
                Text("다음")
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
