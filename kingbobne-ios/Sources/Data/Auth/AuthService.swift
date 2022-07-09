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
    case getToken(email: String, password: String)
    case refreshToken(refreshToken: String)
    case sample
}

extension AuthApi : TargetType {
    public var baseURL: URL {
        return BaseUrl.value
    }
    
    public var path: String {
        switch self {
        case .getToken: return "/token"
        case .refreshToken: return "/refresh-token"
        case .sample: return "/"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .getToken: return Moya.Method.post
        case .refreshToken: return Moya.Method.post
        case .sample: return Moya.Method.get
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
    func sample() -> Single<Array<ImageData>>
    func getToken(email: String, password: String) -> Single<AccessToken>
    func refreshToken(refreshToken: String) -> Single<AccessToken>
}

class AuthCompanion {
    static func newInstance() -> AuthService {
        return AuthServiceImpl()
    }
}

fileprivate class AuthServiceImpl: AuthService, Networkable {
    
    
    var provider: MoyaProvider<AuthApi> = MoyaProvider<AuthApi>()
    
    func sample() -> Single<Array<ImageData>> {
        return provider.rx.request(.sample)
            .flatMap { response in
                do {
                    let dto = try response.map(Array<RespImage>.self)
                    return Single.just(dto.map { $0.convert() })
                } catch { 
                    return Single.error(error)
                }
            }
    }
    
    func getToken(email: String, password: String) -> Single<AccessToken> {
        return provider.rx.request(.getToken(email: email, password: password))
            .flatMap { response in
                do {
                    let accessToken = try response.convert()
                    return Single.just(accessToken)
                } catch {
                    return Single.error(error)
                }
            }
    }
    
    func refreshToken(refreshToken: String) -> Single<AccessToken> {
        return provider.rx.request(.refreshToken(refreshToken: refreshToken))
            .flatMap { response in
                do {
                    let accessToken = try response.convert()
                    return Single.just(accessToken)
                } catch {
                    return Single.error(error)
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

struct RespImage: Codable, Identifiable {
    let id: String
    let author: String
    let width: Int
    let height: Int
    let url: String
    
    func convert() -> ImageData {
        return ImageData(id: id, author: author, width: width, height: height, url: url)
    }
}

struct ImageData: Identifiable {
    let id: String
    let author: String
    let width: Int
    let height: Int
    let url: String
}
