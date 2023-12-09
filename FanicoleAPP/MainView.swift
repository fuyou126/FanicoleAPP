import SwiftUI
import PopupView
struct MainView: View{ 
    @Binding var isLogin:Bool
    @State var isPop = false
    @State var message_icon = "1"
    @State var message_id = "Fan"
    @State var message_content = "Message"
    @State var nowTime = "20:20"
    @State var showFanicole:Bool = true
    var body :some View{
        ZStack{
            TabView{
                MessageView(isPop:$isPop,message_icon: $message_icon,message_id: $message_id,message_content: $message_content,nowTime: $nowTime)
                    .tabItem({
                        Image(systemName: "bubble.left")
                        Text("信息")
                    })
                FriendView()
                    .tabItem({
                        Image(systemName: "person.2")
                        Text("朋友")
                    })
                HobbyView(showFanicole:$showFanicole)
                    .tabItem({
                        Image(systemName: "camera.aperture")
                        Text("发现")
                    })
                SettingsView(isLogin:$isLogin)
                //ImageFUCK(url:"https://img1.baidu.com/it/u=1203299873,2045772297&fm=26&fmt=auto")
                    .tabItem({
                        Image(systemName: "gearshape")
                        Text("设置")
                    })
            }
            //.frame(width: 200, height: 200, alignment: .center)
            //.overlay(RoundedRectangle(cornerRadius: 8, style: .continuous).stroke(Color.gray,lineWidth: 1.5))
            .tabViewStyle(.automatic)
            VStack{
                Text(showFanicole ? "Fanicole":"   ")
                    .font(.system(size: 20, weight: Font.Weight.light, design: .monospaced))
                    .padding(EdgeInsets.init(top: 15, leading: 0, bottom: 0, trailing: 0))
                Divider()
                Spacer()
            }
        }
        .popup(isPresented: $isPop, type:.toast,position: .top,autohideIn: 2.0,view: {
            NotificationView(message_icon:$message_icon,message_id:$message_id,message_content:$message_content,nowTime:$nowTime)
                .ignoresSafeArea(.all)
        })
    }
}
