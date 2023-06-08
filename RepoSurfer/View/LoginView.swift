//
//  ContentView.swift
//  RepoSurfer
//
//  Created by Ramdhas on 2023-06-05.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject private var vm = LoginViewModel(loginService: LoginService())
    
    var body: some View {
        VStack {
            Button {
                vm.login()
            } label: {
                Text("Sign in with GitHub")
                    .foregroundColor(.black)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 20)
            }
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
