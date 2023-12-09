import SwiftUI
import Moya

struct NewFriend_Request:View{
    @Binding var new_friend_image:String
    @Binding var new_friend_word:String
    @Binding var new_friend_id:String
    @State var button = false
    var body:some View{
        HStack{
            Image("Icon_" + new_friend_image)
                .resizable()
                .frame(width: 35, height: 35, alignment: .center)
            Text(new_friend_id+":"+new_friend_word)
                .font(.system(size: 15, weight: Font.Weight.regular, design: .rounded))
            Spacer()
            Button(action:{
                button = true
                /*
                 .onLongPressGesture(perform: {
                 black_button = true
                 })
                 .alert(isPresented:$black_button){()->Alert in
                 Alert(title: Text("要拉黑ta吗(\(new_friend_id[index]))"), message: nil, primaryButton: .default(Text("确定"),action: {
                 let provider = MoyaProvider<MyService>()
                 provider.request(.Blacklist(code: "Blacklist", ID: AccountState.acconutName, YourID: new_friend_id[index])){result in
                 
                 }
                 }), secondaryButton: .default(Text("取消"),action: {}))
                 }
                 */
            }){
                Image(systemName: "checkmark.circle")
                    .resizable()
                    .frame(width: 20, height: 20, alignment: .center)
            }
        }
        
    }
}
