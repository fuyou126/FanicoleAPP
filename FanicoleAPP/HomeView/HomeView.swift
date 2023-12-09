import SwiftUI
import Moya
import SwiftyJSON
struct HomeView: View {
    @State var index = 0
    @Binding var isLogin:Bool 
    @Binding var canAutoLogin:Bool
    @Binding var autoLoginName:String
    @Binding var autoLoginIcon:String
    @Namespace var name
    var body: some View {
        VStack{
            Image("Fanicole")
                .resizable()
                .aspectRatio(contentMode:.fill)
                .frame(width:70,height:70)
            
            HStack(spacing:0){
                Button(action:{
                    withAnimation(.spring()){
                        index = 0
                    }
                }){
                    VStack{
                        Text("登录")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(index == 0 ?.black :.gray)
                        ZStack{
                            Capsule()
                                .fill(Color.black.opacity(0.04))
                                .frame(height: 4)
                            if index == 0{
                                Capsule()
                                    .fill(Color.blue)
                                    .frame(height: 4)
                                    .matchedGeometryEffect(id: "Tab", in: name)
                            }
                        }
                    }
                }
                
                Button(action:{
                    withAnimation(.spring()){
                        index = 1
                    }
                }){
                    VStack{
                        Text("注册")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(index == 1 ?.black :.gray)
                        ZStack{
                            Capsule()
                                .fill(Color.black.opacity(0.04))
                                .frame(height: 4)
                            if index == 1{
                                Capsule()
                                    .fill(Color.blue)
                                    .frame(height: 4)
                                    .matchedGeometryEffect(id: "Tab", in: name)
                            }
                        }
                    }
                }
            }
            .padding(.top,30)
            // loginView
            if index == 0{
                LoginView(isLogin:$isLogin,canAutoLogin:$canAutoLogin,autoLoginName: $autoLoginName,autoLoginIcon:$autoLoginIcon)
            }else{
                SignUpView()
            }
        }
        .padding(.vertical)
        .onAppear(perform: {
            /*
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
             */
        })
    }
}
