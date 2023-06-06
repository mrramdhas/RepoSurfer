//
//  LoginViewModel.swift
//  RepoSurfer
//
//  Created by Ramdhas on 2023-06-05.
//

import SwiftUI
import Foundation
import AuthenticationServices

final class LoginViewModel: NSObject, ObservableObject {
    
    private var loginService = LoginService()
    
    /// Present login auth view through web then navigate user to the Home View
    func login() {
        let endpoint = LoginEndPoint.login(id: Client.id, uri: Client.uri)
        guard let url = URL(string: endpoint.baseURL + endpoint.path) else {return}
        
        let session = ASWebAuthenticationSession(url: url, callbackURLScheme: CallbackScheme.url) { [weak self] url, error in
            guard let self = self else {return}
            
            guard let url = url else {
                if let error = error {
                    print("Login: ", error.localizedDescription)
                }
                return
            }
            
            let component = URLComponents(url: url, resolvingAgainstBaseURL: false)
            guard let code = component?.queryItems?.first(where: { $0.name == "code" })?.value else {
                print("Invalid URL")
                return
            }
            
            // Step 2: Getting access token
            Task {
                do {
                    let result = try await self.loginService.getAccessToken(id: Client.id, secret: Client.secret, code: code, uri: Client.uri, httpMethod: .post)
                    
                    Keychain.shared.save(result.accessToken, forKey: Keys.accessToken)
                    
                    self.changeRootView()
                } catch {
                    #if DEBUG
                    print(error.localizedDescription)
                    #endif
                }
            }
        }
        
        session.presentationContextProvider = self
        session.prefersEphemeralWebBrowserSession = true
        session.start()
        
    }
    
    private func changeRootView() {
        DispatchQueue.main.async {
            UIApplication.shared.connectedScenes
                .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
                .first { $0.isKeyWindow }?.rootViewController = UIHostingController(rootView: RepositoryListView())
        }
    }
    
}


// MARK: - Conform to ASWebAuthenticationPresentationContextProviding
extension LoginViewModel: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }
}
