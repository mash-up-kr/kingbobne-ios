//
//  AuthService.swift
//  kingbobne-ios
//
//  Created by 강대규 on 2022/06/25.
//

import Foundation
import Moya

internal enum AuthApi {
    case getToken(email: String, password: String)
    case refreshToken(refreshToken: String)
}

extension AuthApi : TargetType {
    public var baseURL: URL {
        return BaseUrl.value
    }
    
    public var path: String {
        switch self {
        case .getToken: return "/token"
        case .refreshToken: return "/refresh-token"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .getToken: return Moya.Method.post
        case .refreshToken: return Moya.Method.post
        }
    }
    
    public var task: Task {
        return .requestPlain
    }
    
    public var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}

protocol AuthService: Service {
    func getToken(email: String, password: String, completion: @escaping (Result<AccessToken, Error>) -> ())
    func refreshToken(refreshToken: String, completion: @escaping (Result<AccessToken, Error>) -> ())
}

class AuthCompanion {
    static func newInstance() -> AuthService {
        return AuthServiceImpl()
    }
}

fileprivate class AuthServiceImpl: AuthService, Networkable {
    var provider: MoyaProvider<AuthApi> = MoyaProvider<AuthApi>()
    
    func getToken(email: String, password: String, completion: @escaping (Result<AccessToken, Error>) -> ()) {
        provider.request(.getToken(email: email, password: password)) { result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let token = try moyaResponse.convert()
                    completion(Result.success(token))
                } catch {
                    completion(Result.failure(error))
                }
            case let .failure(moyaError):
                // do nothing
                completion(Result.failure(moyaError))
            }
        }
    }
    
    func refreshToken(refreshToken: String, completion: @escaping (Result<AccessToken, Error>) -> ()) {
        provider.request(.refreshToken(refreshToken: refreshToken)) { result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let token = try moyaResponse.convert()
                    completion(Result.success(token))
                } catch {
                    completion(Result.failure(error))
                }
            case let .failure(moyaError):
                // do nothing
                completion(Result.failure(moyaError))
            }
        }
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
        let expiredAt = Date().addingTimeInterval(Double(expiresIn))
        return AccessToken(token: token, expiredAt: expiredAt, refreshToken: refreshToken)
    }
}
