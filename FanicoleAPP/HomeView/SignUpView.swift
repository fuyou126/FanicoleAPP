import SwiftUI
import Moya
import SwiftyJSON
struct SignUpView:View{
    @State var user = ""
    @State var password = ""
    @State var password_confirm = ""
    @State var errorStatus = ""
    @State var isAlert = false
    var body:some View{
        VStack{
            HStack{
                VStack(alignment: .leading, spacing: 12){
                    Text("新建账号")
                        .font(.title)
                        .fontWeight(.bold)
                }
                Spacer(minLength: 0)
            }
            .padding(.horizontal,25)
            .padding(.top,10)
            VStack(alignment: .leading, spacing: 15){
                Text("用户名")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                TextField("Enter user name",text:$user)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                    .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: -5)
                Text("密码")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                SecureField("Enter password",text: $password)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                    .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: -5)
                Text("确认密码")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                SecureField("Confirm password",text: $password_confirm)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                    .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: -5)
            }
            .padding(.horizontal,25)
            .padding(.top,10)
            
            Button(action:{
                //确定注册
                if !user.isEmpty && !password.isEmpty && password == password_confirm{
                    let provider = MoyaProvider<MyService>()
                    provider.request(.Register(code: "Register", ID: user, Password: password, Sign:"我对这个世界没什么好说的")){result in
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
                    errorStatus = "输入有误，请重新输入。"
                    isAlert = true
                }
            }){
                Text("注册")
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
        }
        .alert(isPresented:$isAlert){()-> Alert in Alert(title:Text(errorStatus))}
        
    }
}
