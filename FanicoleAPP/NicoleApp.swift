import SwiftUI
import Lottie
import Moya
import SwiftyJSON

@main
struct NicoleApp: App {
    /*
    @State var isLogin = false
    @State var isLaunch = true
    @State var canAutoLogin:Bool = false
    @State var autoLoginName:String = ""
    @State var autoLoginIcon = ""
     */
    var body: some Scene {
        WindowGroup {
            AppView()
            /*
            if isLaunch{
                LaunchView(canAutoLogin: $canAutoLogin, autoLoginName: $autoLoginName, autoLoginIcon: $autoLoginIcon)
                    .onAppear(perform: {
                        DispatchQueue.main.asyncAfter(deadline:.now() + 1){            isLaunch.toggle()
                        }
                    })
            }else{
                if !isLogin {
                    HomeView(isLogin:$isLogin,canAutoLogin:$canAutoLogin,autoLoginName:$autoLoginName,autoLoginIcon:$autoLoginIcon)
                        .animation(.easeInOut(duration: 0.5), value: isLaunch)
                    //ContentView(isLogin:$isLogin)
                }else{
                    MainView(isLogin:$isLogin)
                        .animation(.easeInOut(duration: 0.5), value: isLogin)
                }
            }
             */
            
        }
    }
}
