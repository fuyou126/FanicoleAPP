import SwiftUI
import Moya

enum MyService{
    case Nicole_cal(number1:String,number2:String)
    case CheckPassword(code:String,ID:String,Password:String,UUID:String)
    case Register(code:String,ID:String,Password:String ,Sign:String)
    case UpdateState(code:String,ID:String,Icon:String,Sign:String,Battery:String)
    case GetState(code:String,ID:String)
    case GetUUID(code:String,ID:String)
    case SetUUID(code:String,ID:String,UUID:String)
    case GetFriends(code:String,ID:String)
    case NewFriend_Request(code:String,ID:String,YourID:String,Word:String)
    case NewFriend_Yes(code:String,ID:String,YourID:String)
    case NewFriend_No(code:String,ID:String,YourID:String)
    case GetChat(code:String,ID:String,YourID:String)
    case SendMessage(code:String,ID:String,YourID:String,Content:String)
    case SearchID(code:String,UUID:String)
    case Report(code:String,YourID:String,ID:String,Content:String)
    case DeleteFriend(code:String,ID:String,YourID:String)
    case ClearChats(code:String,ID:String,YourID:String)
    case Blacklist(code:String,ID:String,YourID:String)
    case GetMood(code:String,ID:String)
    case GetHobby(code:String,ID:String,Book:String)
    case SetHobby(code:String,ID:String,Book:String,reading:String,love:String)
}
// MARK: - TargetType Protocol Implementation
extension MyService: TargetType {
    var baseURL: URL { return URL(string: "http://124.222.102.194:8080/NicoleTest")! }
    var path: String{
        return "/api"
    }
    var method: Moya.Method {
        /*
         switch self {
         case  .Nicole_cal, .Register:
         return .get
         }
         */
        return .get
    }
    var task: Task {
        switch self {
        case let .Nicole_cal(number1,number2):
            return .requestParameters(parameters:["number1":number1,"number2":number2],encoding:URLEncoding.queryString)
        case let .Register(code,ID,Password,Sign):
            return .requestParameters(parameters: ["code":code,"ID":ID,"Password":Password,"Sign":Sign], encoding: URLEncoding.queryString)
        case let .CheckPassword(code,ID,Password,UUID):
            return .requestParameters(parameters: ["code":code,"ID":ID,"Password":Password,"UUID":UUID], encoding: URLEncoding.queryString)
        case let .UpdateState(code,ID,Icon,Sign,Battery):
            return .requestParameters(parameters: ["code":code,"ID":ID,"Icon":Icon,"Sign":Sign,"Battery":Battery], encoding: URLEncoding.queryString)
        case let .GetState(code,ID):
            return .requestParameters(parameters: ["code":code,"ID":ID], encoding: URLEncoding.queryString)
        case let .GetUUID(code,ID):
            return .requestParameters(parameters: ["code":code,"ID":ID], encoding: URLEncoding.queryString)
        case let .SetUUID(code,ID,UUID):
            return .requestParameters(parameters: ["code":code,"ID":ID,"UUID":UUID], encoding: URLEncoding.queryString)
        case let .GetFriends(code,ID):
            return .requestParameters(parameters: ["code":code,"ID":ID], encoding: URLEncoding.queryString)
        case let .NewFriend_Request(code,ID,YourID,Word):
            return .requestParameters(parameters: ["code":code,"ID":ID,"YourID":YourID,"Word":Word], encoding: URLEncoding.queryString)
        case let .NewFriend_Yes(code,ID,YourID):
            return .requestParameters(parameters: ["code":code,"ID":ID,"YourID":YourID], encoding: URLEncoding.queryString)
        case let .NewFriend_No(code,ID,YourID):
            return .requestParameters(parameters: ["code":code,"ID":ID,"YourID":YourID], encoding: URLEncoding.queryString)
        case let .GetChat(code,ID,YourID):
            return .requestParameters(parameters: ["code":code,"ID":ID,"YourID":YourID], encoding: URLEncoding.queryString)
        case let .SendMessage(code,ID,YourID,Content):
            return .requestParameters(parameters: ["code":code,"ID":ID,"YourID":YourID,"Content":Content], encoding: URLEncoding.queryString)
        case let .SearchID(code,UUID):
            return .requestParameters(parameters: ["code":code,"UUID":UUID], encoding: URLEncoding.queryString)
        case let .Report(code,YourID,ID,Content):
            return .requestParameters(parameters: ["code":code,"YourID":YourID,"ID":ID,"Content":Content], encoding: URLEncoding.queryString)
        case let .DeleteFriend(code,ID,YourID):
            return .requestParameters(parameters: ["code":code,"ID":ID,"YourID":YourID], encoding: URLEncoding.queryString)
        case let .ClearChats(code,ID,YourID):
            return .requestParameters(parameters: ["code":code,"ID":ID,"YourID":YourID], encoding: URLEncoding.queryString)
        case let .Blacklist(code,ID,YourID):
            return .requestParameters(parameters: ["code":code,"ID":ID,"YourID":YourID], encoding: URLEncoding.queryString)
        case let .GetMood(code,ID):
            return .requestParameters(parameters: ["code":code,"ID":ID], encoding: URLEncoding.queryString)
        case let .GetHobby(code,ID,Book):
            return .requestParameters(parameters: ["code":code,"ID":ID,"Book":Book], encoding: URLEncoding.queryString)
        case let .SetHobby(code, ID, Book, reading, love):
            return .requestParameters(parameters: ["code":code,"ID":ID,"Book":Book,"reading":reading,"love":love], encoding: URLEncoding.queryString)
        }
    }
    var sampleData: Data {
        /*
         switch self {
         case .Nicole_cal(let number1,let number2):
         return "{\"number1\": \"\(number1)\", \"number2\": \"\(number2)\", \"answer\": \"-1\"}".utf8Encoded
         case .Register(let code,let ID,let Password,let Phone,let Birthday,let UUID):
         return "\(code)\(Password)\(ID)\(Phone)\(Birthday)\(UUID)".utf8Encoded
         }
         */
        return "".utf8Encoded
    }
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    var utf8Encoded: Data {
        Data(self.utf8)
    }
}
