import SwiftUI
import UIKit
import Moya
import SwiftyJSON

struct ContentView: View {
    @State var user_name:String = ""
    @State var password:String = ""
    @State var contentBlur = 0.0
    @State var isGift = false
    @State var registerSheet = false
    @State var register_user_name = ""
    @State var register_password = ""
    @State var isAlert = false
    @State var isEULAAlert = false
    @State var agreeEULA = false
    @Binding var isLogin:Bool
    //@EnvironmentObject var accountState:AccountState
    //@Binding var accountState:AccountState
    //@EnvironmentObject var isLogin:Bool //登陆了没有
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Spacer()
                    Button(action:{
                        withAnimation{
                            if !isGift{
                                contentBlur = 20.0
                            }else{
                                contentBlur = 0.0
                            }
                            isGift.toggle()
                        }
                    }){    
                        if !isGift{
                            Image("gift_new")
                                .resizable()
                                .frame(width: 50, height: 50, alignment: .center)
                        }else{
                            Image("close_blue")
                                .resizable()
                                .frame(width: 50, height: 50, alignment: .center)
                        }
                    }
                    .padding([.trailing,.top])
                    
                }
                Spacer()
                //.padding()
                //.offset(x: 120, y: -300)
            }
            VStack{
                Image("Nicole")
                /*
                 Text("Fan 516")
                 .fontWeight(Font.Weight.bold)
                 .padding(EdgeInsets.init(top: 20, leading: 0, bottom: 20, trailing: 0))
                 */
                    .resizable()
                    .frame(width: 100, height: 100, alignment: .center)
                    .padding(EdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                TextField("User name", text: $user_name)
                    .frame(width: 200, height: 45, alignment: Alignment.center)
                    .offset(x: 40, y: 0)
                    .font(.system(size: 17, weight: Font.Weight.regular, design: .default))
                    .overlay(RoundedRectangle(cornerRadius: 8, style: .continuous).stroke(Color.blue,lineWidth: 1.5))
                    .overlay(Image(systemName: "person").scaleEffect(1.5).frame(width: 200, height: 45, alignment: .leading).offset(x: 15, y: 0).foregroundColor(Color.blue))
                    .padding(EdgeInsets.init(top: 30, leading: 0, bottom: 10, trailing: 0))
                
                SecureField("Password", text: $password)
                    .frame(width: 200, height: 45, alignment: Alignment.center)
                    .offset(x: 40, y: 0)
                    .font(.system(size: 17, weight: Font.Weight.regular, design: .default))
                    .overlay(RoundedRectangle(cornerRadius: 8, style: .continuous).stroke(Color.blue,lineWidth: 1.5))
                    .overlay(Image(systemName: "lock").scaleEffect(1.5).frame(width: 200, height: 45, alignment: .leading).offset(x: 15, y: 0).foregroundColor(Color.blue))
                    .padding(EdgeInsets.init(top: 20, leading: 0, bottom: 0, trailing: 0))
                HStack{
                    Button(action:{
                        if user_name != "" && password != "" && agreeEULA {
                            let provider = MoyaProvider<MyService>()
                            let UUID = UIDevice.current.identifierForVendor?.uuidString
                            provider.request(.CheckPassword(code:"CheckPassword",ID: user_name,Password: password,UUID: UUID ?? "None")){result in
                                switch result{
                                case let .success(moyaResponse):
                                    let data = moyaResponse.data
                                    do{
                                        let json = try JSON(data:data)
                                        if(json["code"].int! == 1 && json["CheckResult"].string! == "true"){
                                            AccountState.acconutName = user_name
                                            isLogin = true
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
                        
                        /*
                         if user_name == "Nicole" {
                         withAnimation{
                         isLogin = true
                         }
                         }else{
                         self.isAlert = true
                         }
                         */
                    }){    
                        Text("登陆")
                            .frame(width: 80, height: 40, alignment: .center).background(Color.blue).foregroundColor(Color.white)
                            .cornerRadius(12)
                    }
                    .padding(EdgeInsets.init(top: 40, leading: 0, bottom: 30, trailing: 18))
                    Button(action:{
                        self.registerSheet = true
                        
                    }){    
                        Text("注册")
                            .frame(width: 80, height: 40, alignment: .center).background(Color.blue).foregroundColor(Color.white)
                            .cornerRadius(12)
                    }
                    .sheet(isPresented: $registerSheet,content: {
                        registerView()
                    })
                    .padding(EdgeInsets(top: 40, leading: 18, bottom: 30, trailing: 0))
                    
                    
                }
                
            }
            .blur(radius: contentBlur)
            if isGift{
                VStack{
                    Image("516")
                        .resizable()
                        .frame(width: 120, height: 120, alignment: .center)
                    Text("Nicole")
                        .font(.system(size: 25, weight: Font.Weight.ultraLight, design: .rounded))
                        .padding(EdgeInsets.init(top: 20, leading: 0, bottom: 20, trailing: 0))
                    Text("2022/01/26")
                        .font(.system(size: 18, weight: Font.Weight.ultraLight, design: .default))
                    Text("Happy Birthday!")
                        .font(.system(size: 18, weight: Font.Weight.ultraLight, design: .default))
                    
                }
            }
            //EULA
            VStack{
                Spacer()
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
                .padding([.bottom])
            }
            .blur(radius: contentBlur)
            
        }
        .alert(isPresented:$isAlert){()-> Alert in Alert(title:Text("输入有误(或未同意用户条款)"))}
        .sheet(isPresented:$isEULAAlert,content: {
            EULAView()
        })
        
    }
    
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

struct registerView:View{
    @Environment(\.presentationMode) var presentation
    @State var register_user_name = ""
    @State var register_password = ""
    @State var register_password_confirm = ""
    @State var Sign = ""
    @State var graph_code = ""
    @State var isAlert = false
    @State var errorStatus = "输入不合法"
    var body: some View{
        VStack{
            HStack{
                Button(action: {
                    self.presentation.wrappedValue.dismiss()
                }){
                    Text("返回")
                        .foregroundColor(Color.blue)
                }
                .padding()
                Spacer()
                Button(action: {
                    //确定注册
                    if !register_user_name.isEmpty && !register_password.isEmpty && graph_code == "0413" && register_password == register_password_confirm{
                        let provider = MoyaProvider<MyService>()
                        provider.request(.Register(code: "Register", ID: register_user_name, Password: register_password, Sign:Sign)){result in
                            switch result{
                            case let .success(moyaResponse):
                                let data = moyaResponse.data
                                do{
                                    let json = try JSON(data:data)
                                    if json["code"].int == 1{
                                        errorStatus = "注册成功"
                                        isAlert = true
                                    }else{
                                        errorStatus = "用户名已经被用了或者是服务器崩了"
                                        isAlert = true
                                    }
                                }catch{
                                }
                            case let .failure(error):
                                print("\(error)")
                            }
                        }
                    }else{
                        errorStatus = "你输入的啥玩意"
                        isAlert = true
                    }
                }){
                    Text("确定")
                        .foregroundColor(Color.blue)
                }
                .padding()
            }
            Spacer()
            //注册信息
            Text("注册")
                .font(.system(size: 20, weight: Font.Weight.light, design: .rounded))
            VStack{
                Divider()
                VStack{
                    TextField("Enter User name", text: $register_user_name)
                        .frame(width: 180, height: 40, alignment: .center)
                    Divider()
                    TextField("Enter Password", text: $register_password)
                        .frame(width: 180, height: 40, alignment: .center)
                    Divider()
                    TextField("Confirm Password", text: $register_password_confirm)
                        .frame(width: 180, height: 40, alignment: .center)
                    Divider()
                    TextField("Personalized signature",text: $Sign)
                        .frame(width: 180, height: 40, alignment: .center)
                    Divider()
                    /*
                     TextField("Enter Phone Number", text: $phone_number)
                     .frame(width: 180, height: 40, alignment: .center)
                     Divider()
                     */
                    /*
                     HStack{
                     
                     TextField("Verification Code", text: $verification_code)
                     .frame(width: 120, height: 40, alignment: .leading)
                     Button(action: {
                     print("get code")
                     }){
                     Text("Get")
                     .foregroundColor(Color.blue)
                     }
                     .frame(width: 60, height: 40, alignment: .center)
                     //.padding()
                     }
                     .frame(width: 180, height: 40, alignment: .center)
                     Divider()
                     */
                    
                }
                HStack{
                    TextField("Graph Code", text: $graph_code)
                        .frame(width: 120, height: 40, alignment: .leading)
                    Image("Graph_code")
                        .resizable()
                        .frame(width: 60, height: 40, alignment: .center)
                }
                Spacer()
                
                
            }
            .frame(width: 220, height: 285, alignment: .center)
            .overlay(RoundedRectangle(cornerRadius: 8, style: .continuous).stroke(Color.gray,lineWidth: 1.5))
            .padding(EdgeInsets.init(top: 0, leading: 0, bottom: 100, trailing: 0))
            /*
             DatePicker(selection: $date, displayedComponents: [.date]){
             Text("生日")
             .padding(.leading, 70)
             }
             .padding(EdgeInsets.init(top: 10, leading: 0, bottom: 100, trailing: 60))
             */
            
            Spacer()
            
            
        }.alert(isPresented:$isAlert){()-> Alert in Alert(title:Text(errorStatus))}
    }
}

