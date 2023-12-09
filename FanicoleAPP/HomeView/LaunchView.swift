import SwiftUI
import Moya
import SwiftyJSON
import Lottie
struct LaunchView:View{
    @State var showLoadingIndicator:Bool = true
    @Binding var canAutoLogin:Bool
    @Binding var autoLoginName:String
    @Binding var autoLoginIcon:String
    var body: some View{
        VStack{
            Image("Fanicole")
                .resizable()
                .frame(width: 130, height: 130, alignment: .center)
                .padding([.top],150)
            Spacer()
            LottieView(lottieFile:"launch_loading")
                .frame(width: 100, height: 100)
            //ActivityIndicatorView(isVisible: $showLoadingIndicator, type: .growingArc(.blue, lineWidth: 4))
            //.frame(width: 30, height: 30, alignment: .center)
            //.foregroundColor(.blue)
            //.padding([.bottom],20)
            Text("让沟通变简单~")
                .padding([.bottom],30)
        }
        .onAppear(perform: {
            DispatchQueue.global().async {
                let provider = MoyaProvider<MyService>()
                let UUID = UIDevice.current.identifierForVendor?.uuidString
                provider.request(.SearchID(code: "SearchID", UUID:UUID ?? "")){result in
                    switch result{
                    case let .success(moyaResponse):
                        let data = moyaResponse.data
                        do{
                            let json = try JSON(data:data)
                            if(json["code"].int! == 1 && json["ID"].string! != "None"){
                                autoLoginName = json["ID"].string!
                                //AccountState.acconutName = autoLoginName
                                autoLoginIcon = json["Icon"].string!
                                canAutoLogin = true
                            }
                        }catch{
                        }
                    case let .failure(error):
                        print("\(error)")
                    }
                }
            }
        })
        .onDisappear(perform: {
            showLoadingIndicator = false
        })
    }
}
