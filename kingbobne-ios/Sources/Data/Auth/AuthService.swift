//
//  AuthService.swift
//  kingbobne-ios
//
//  Created by 강대규 on 2022/06/25.
//

import Foundation
import Moya
import RxMoya
import RxSwift

internal enum AuthApi {
    case signIn(body: ReqSignIn)
    case validateEmail(email: String)
    case requestAuthCode(body: ReqRequestAuthCode)
    case authenticateCode(body: ReqAuthenticateCode)
    case validateNickname(nickname: String)
    case signUp(body: ReqSignUp)
}

extension AuthApi : TargetType {
    public var baseURL: URL {
        return BaseUrl.value
    }
    
    public var path: String {
        switch self {
        case .signIn: return "/auth/login"
        case .validateEmail: return "/auth/validate/email"
        case .requestAuthCode: return "/auth/code"
        case .authenticateCode: return "/auth/code/check"
        case .validateNickname: return "/auth/validate/nickname"
        case .signUp: return "/auth/signup"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .signIn: return Moya.Method.post
        case .validateEmail: return Moya.Method.get
        case .requestAuthCode: return Moya.Method.post
        case .authenticateCode: return Moya.Method.post
        case .validateNickname: return Moya.Method.get
        case .signUp: return Moya.Method.post
        }
    }
    
    public var task: Task {
        switch self {
        case .validateEmail(let email):
            return .requestParameters(parameters: ["email": email], encoding: URLEncoding.queryString)
        case .validateNickname(let nickname):
            return .requestParameters(parameters: ["nickname": nickname], encoding: URLEncoding.queryString)
        case .signIn(let body):
            return .requestJSONEncodable(body)
        case .signUp(let body):
            return .requestJSONEncodable(body)
        case .requestAuthCode(let body):
            return .requestJSONEncodable(body)
        case .authenticateCode(let body):
            return .requestJSONEncodable(body)
        }
    }
    
    public var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}

protocol AuthService: Service {
    func signIn(email: String, password: String) -> Single<AccessToken>
    func signUp(email: String, password: String, nickname: String) -> Single<AccessToken>
    func validateEmail(email: String) -> Completable
    func requestAuthCode(email: String, type: AuthCodeTypeDto) -> Completable
    func authenticateCode(email: String, code: String, type: AuthCodeTypeDto) -> Completable
    func validateNickname(nickname: String) -> Completable
}

class AuthCompanion {
    static func newInstance() -> AuthService {
        return AuthServiceImpl()
    }
}

fileprivate class AuthServiceImpl: AuthService, Networkable {
    
    var provider: MoyaProvider<AuthApi> = MoyaProvider<AuthApi>(plugins: [RequestLoggingPlugin()])
 
    func signIn(email: String, password: String) -> Single<AccessToken> {
        return provider.rx.request(.signIn(body: ReqSignIn(email: email, password: password)))
            .flatMap { response in
                do {
                    let accessToken = try response.convert()
                    return Single.just(accessToken)
                } catch {
                    return Single.error(error)
                }
            }
    }
    
    func signUp(email: String, password: String, nickname: String) -> Single<AccessToken> {
        return provider.rx.request(.signUp(body: ReqSignUp(email: email, password: password, nickname: nickname)))
            .flatMap { response in
                do {
                    let accessToken = try response.convert()
                    return Single.just(accessToken)
                } catch {
                    return Single.error(error)
                }
            }
    }
    
    func validateEmail(email: String) -> Completable {
        return provider.rx.request(.validateEmail(email: email))
            .filterSuccessfulStatusCodes()
            .asCompletable()
    }
    
    func requestAuthCode(email: String, type: AuthCodeTypeDto) -> Completable {
        return provider.rx.request(.requestAuthCode(body: ReqRequestAuthCode(email: email, type: type)))
            .filterSuccessfulStatusCodes()
            .asCompletable()
    }
    
    func authenticateCode(email: String, code: String, type: AuthCodeTypeDto) -> Completable {
        return provider.rx.request(.authenticateCode(body: ReqAuthenticateCode(email: email, code: code, type: type)))
            .filterSuccessfulStatusCodes()
            .asCompletable()
    }
    
    func validateNickname(nickname: String) -> Completable {
        return provider.rx.request(.validateNickname(nickname: nickname))
            .filterSuccessfulStatusCodes()
            .asCompletable()
    }
   
}

fileprivate extension Response {
    func convert() throws -> AccessToken {
        let response = try map(RespAccessToken.self)
        return response.convert()
    }
}

fileprivate extension RespAccessToken {
    func convert() -> AccessToken {
        return AccessToken(token: accessToken)
    }
}
