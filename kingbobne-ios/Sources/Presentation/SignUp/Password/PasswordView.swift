//
//  AuthCodeView.swift
//  kingbobne-ios
//
//  Created by victhor on 2022/08/20.
//  Copyright © 2022 3999WG8MCQ. All rights reserved.
//

import SwiftUI

struct PasswordView: View {
    @StateObject var viewModel: PasswordViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("비밀번호를 설정해주세요.")
                .font(Font(uiFont: UIFont.setFont(style: .Headline1Regular)))
                .foregroundColor(Color(UIColor.Custom.brownGray500))
            
            SecureField("비밀번호 8자이상", text: $viewModel.viewState.password)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .frame(maxWidth: .infinity)
                .font(Font(uiFont: UIFont.setFont(style: .Body1Regular)))
                .foregroundColor(Color(UIColor.Custom.brownGray500))
                .padding(EdgeInsets(top: 36, leading: 0, bottom: 0, trailing: 0))
            
            Divider()
                .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
            
            SecureField("비밀번호 재입력", text: $viewModel.viewState.passwordValidation)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .font(Font(uiFont: UIFont.setFont(style: .Body1Regular)))
                .foregroundColor(Color(UIColor.Custom.brownGray500))
                .padding(EdgeInsets(top: 32, leading: 0, bottom: 0, trailing: 0))
            
            Divider()
                .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
            
            Spacer()
            
            Button(action: {
                self.viewModel.savePassword()
            }) {
                Text("다음")
                    .frame(maxWidth: .infinity, minHeight: 48, maxHeight: 48, alignment: .center)
                    .font(Font(uiFont: UIFont.setFont(style: .Body1Bold)))
                    .background(viewModel.viewState.btnEnabled ? Color(UIColor.Custom.brandOrange) : Color(UIColor.Custom.brownGray100))
                    .foregroundColor(viewModel.viewState.btnEnabled ? Color.white : Color(UIColor.Custom.brownGray400))
                    .cornerRadius(10)
                    .disabled(!viewModel.viewState.btnEnabled)
            }
        }.padding(EdgeInsets(top: 40, leading: 24, bottom: 20, trailing: 24))
    }
}
