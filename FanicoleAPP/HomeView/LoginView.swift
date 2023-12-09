import SwiftUI
import Moya
import SwiftyJSON
struct LoginView:View{
    @State var username = ""
    @State var password = ""
    @State var isAlert = false
    @Binding var isLogin:Bool
    @Binding var canAutoLogin:Bool
    @Binding var autoLoginName:String
    @Binding var autoLoginIcon:String
    @State var agreeEULA = false
    @State var isEULAAlert = false
    var body :some View{
        VStack{
            if canAutoLogin{
                HStack{
                    VStack(alignment: .leading, spacing: 12){
                        Text("欢迎回来, ")
                            .fontWeight(.bold)
                        Text(autoLoginName)
                            .font(.title)
                            .fontWeight(.bold)
                        Button(action: {
                            withAnimation(.spring()){
                                canAutoLogin = false
                            }
                            autoLoginName = ""
                        }){
                            Text("登录其他账号")
                                .font(.system(size:14))
                                .fontWeight(.bold)
                                .foregroundColor(Color.blue)
                        }
                    }
                    Spacer(minLength: 0)
                    Image("Icon_" + autoLoginIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 85, height: 85)
                        .clipShape(Circle())
                }
                .padding(.horizontal,25)
                .padding(.top,30)
            }
            VStack(alignment: .leading, spacing: 15){
                if !canAutoLogin{
                    Text("欢迎!")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("用户名")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                    TextField("Username", text: $username)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(5)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                        .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: -5)
                    Text("密码")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(5)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                        .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: -5)
                    Button(action: {
                        
                    }){
                        Text("忘记密码")
                            .font(.system(size:14))
                            .fontWeight(.bold)
                            .foregroundColor(Color.blue)
                    }
                    .padding(.top,10)
                }else{
                    LottieView(lottieFile:"welcome")
                        .frame(width:300,height:60)
                        .offset(x: -5, y: 0)
                }
            }
            .padding(.horizontal,25)
            .padding(.top,25)
            Button(action:{
                if canAutoLogin{
                    AccountState.acconutName = autoLoginName
                    withAnimation(.spring()){
                        isLogin = true
                    }
                }else{
                    if password != "" && username != "" && agreeEULA{
                        let provider = MoyaProvider<MyService>()
                        let UUID = UIDevice.current.identifierForVendor?.uuidString
                        provider.request(.CheckPassword(code:"CheckPassword",ID: username,Password: password,UUID: UUID ?? "None")){result in
                            switch result{
                            case let .success(moyaResponse):
                                let data = moyaResponse.data
                                do{
                                    let json = try JSON(data:data)
                                    if(json["code"].int! == 1 && json["CheckResult"].string! == "true"){
                                        AccountState.acconutName = username
                                        withAnimation(.spring()){
                                            isLogin = true
                                        }
                                    }else{
                                        isAlert = true
                                    }
                                }catch{
                                }
                            case let .failure(error):
                                print("\(error)")
                            }
                        }
                    }else{
                        isAlert = true
                    }
                }
            }){
                Text("登录")
                    .font(.system(size:20))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .frame(width:UIScreen.main.bounds.width - 50)
                    .background(LinearGradient(gradient: .init(colors: [Color.blue,Color.teal]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .cornerRadius(8)
            }
            .padding(.horizontal,25)
            .padding(.top,25)
            
            //EULA
            if !canAutoLogin{
                VStack{
                    HStack{
                        Button(action:{
                            withAnimation{
                                agreeEULA.toggle()
                            }
                        }){
                            Image(systemName: agreeEULA ? "checkmark.square.fill":"square")
                        }
                        VStack{
                            Text("我已经认真阅读并同意")
                                .font(.system(size: 12, weight: .regular, design: .default))
                            +
                            Text("用户条款(EULA)")
                                .font(.system(size: 12, weight: .regular, design: .default))
                                .foregroundColor(Color.blue)
                        }
                        .onTapGesture(perform: {
                            isEULAAlert = true
                        })
                    }
                    .padding(.top,30)
                }
            }
        }
        .alert(isPresented:$isAlert){()-> Alert in Alert(title:Text("输入有误(或未同意用户条款)"))}
        .sheet(isPresented:$isEULAAlert,content: {
            EULAView()
        })
    }
}
