import SwiftUI
import Moya
import SwiftyJSON

struct BlacklistView:View{
    @Environment(\.colorScheme) var colorScheme
    @Binding var isBlacklistView:Bool
    @Binding var new_friend_id:[String]
    @State var YourID:Int = 0
    var body: some View{
        VStack{
            HStack{
                Spacer()
                Button(action:{
                    isBlacklistView = false
                }){
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .foregroundColor(Color.red)
                        .frame(width: 20, height: 20, alignment: .center)
                        .padding()
                }
            }
            Text("你要拉黑谁")
                .font(.system(size: 17, weight: .regular, design: .default))
                .padding([.bottom])
            Picker(selection: $YourID, label: Text("ta")) {
                ForEach(0..<new_friend_id.count,id:\.self){index in
                    Text(new_friend_id[index])
                }
            }
            Button(action:{
                let provider = MoyaProvider<MyService>()
                provider.request(.Blacklist(code: "Blacklist", ID: AccountState.acconutName, YourID: new_friend_id[YourID])){result in
                    switch result{
                    case let .success(moyaResponse):
                        let data = moyaResponse.data
                        do{
                            let json = try JSON(data:data)
                            if json["code"].int! == 1 {
                                isBlacklistView = false
                            }
                        }catch{}
                    case let .failure(error):
                        print("\(error)")
                    }
                }
            }){
                Image(systemName: "person.badge.minus")
                    .resizable()
                    .foregroundColor(Color.red)
                    .frame(width: 30, height: 30, alignment: .center)
            }
            .padding()
            Spacer()
        }
        .frame(width: 200, height: 250, alignment: .center)
        .cornerRadius(8)
        .background(colorScheme == .light ? Color.white:Color.init(red: 28.0/256, green: 28.0/256, blue: 30.0/256))
        .overlay(RoundedRectangle(cornerRadius: 8, style: .continuous).stroke(Color.black,lineWidth: 1.2))
        //.alert(isPresented:$isAlert){()-> Alert in Alert(title:Text("提交成功"))}
    
    }
    
}
