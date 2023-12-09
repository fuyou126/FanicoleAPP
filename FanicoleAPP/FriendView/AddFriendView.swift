import SwiftUI
import Moya
import SwiftyJSON

struct AddFriendView:View{
    @Environment(\.presentationMode) var presentation
    @State var your_id:String = ""
    @State var word:String = ""
    @State var isAlert = false
    var body: some View{
        VStack{
            HStack{
                Button(action:{
                    self.presentation.wrappedValue.dismiss()
                }){
                    Text("返回")
                        .font(.system(size: 17, weight: .regular, design: .default))
                }
                .padding()
                Spacer()
                Button(action:{
                    //好友申请提交
                    if word == ""{
                        word = "加个好友吧~"
                    }
                    let provider = MoyaProvider<MyService>()
                    provider.request(.NewFriend_Request(code: "NewFriend_Request", ID: AccountState.acconutName, YourID: your_id, Word: word)){result in
                        switch result{
                        case let .success(moyaResponse):
                            let data = moyaResponse.data
                            do{
                                let json = try JSON(data:data)
                                if json["code"].int! == 1{
                                    isAlert = true
                                }
                            }catch{
                            }
                        case let .failure(error):
                            print("\(error)")
                        }
                    }
                }){
                    Text("提交")
                        .font(.system(size: 17, weight: .regular, design: .default))
                }
                .padding()
            }
            /*
            Image("Add_Friend")
                .resizable()
                .frame(width: 200, height: 200, alignment: .center)
                .padding(EdgeInsets.init(top: 80, leading: 0, bottom: 0, trailing: 0))
             */
            LottieView(lottieFile: "hello")
                .frame(width: 150, height: 150)
                .padding([.top, .bottom], 30)
            TextField("对方用户名", text: $your_id)
                .font(.system(size: 17, weight: .regular, design: .default))
                .offset(x: 10, y: 0)
                .frame(width: 250, height: 40, alignment: .center)
                .overlay(RoundedRectangle(cornerRadius: 8, style: .continuous).stroke(Color.init(red: 41/256, green: 38/256, blue: 169/256),lineWidth: 1.5))
                .padding()
            TextField("加个好友吧~",text: $word)
                .font(.system(size: 17, weight: .regular, design: .default))
                .offset(x: 10, y: 0)
                .frame(width: 250, height: 40, alignment: .center)
                .overlay(RoundedRectangle(cornerRadius: 8, style: .continuous).stroke(Color.init(red: 41/256, green: 38/256, blue: 169/256),lineWidth: 1.5))
            Spacer()
        }
        .alert(isPresented:$isAlert){()-> Alert in Alert(title:Text("申请已发送！"))}
        
    }
}
