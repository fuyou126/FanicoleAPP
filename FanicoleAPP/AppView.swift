import SwiftUI
import Moya

struct AppView: View {
    @State var isLogin = false
    @State var isLaunch = true
    @State var canAutoLogin:Bool = false
    @State var autoLoginName:String = ""
    @State var autoLoginIcon = ""
    var body: some View {
        if isLaunch{
            LaunchView(canAutoLogin: $canAutoLogin, autoLoginName: $autoLoginName, autoLoginIcon: $autoLoginIcon)
                .onAppear(perform: {
                    DispatchQueue.main.asyncAfter(deadline:.now() + 1){ 
                        isLaunch.toggle()
                    }
                })
                .onAppear(perform: {
                    setNotification()
                })
        }else if !isLogin {
                HomeView(isLogin:$isLogin,canAutoLogin:$canAutoLogin,autoLoginName:$autoLoginName,autoLoginIcon:$autoLoginIcon)
                    .animation(.easeInOut(duration: 0.3), value: isLaunch)
            }else{
                MainView(isLogin:$isLogin)
                    .animation(.easeInOut(duration: 0.3), value: isLogin)
            }
        
    }
}

