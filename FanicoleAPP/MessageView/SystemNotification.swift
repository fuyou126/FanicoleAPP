import SwiftUI
import UserNotifications

func setNotification(){
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]){ (granted, _) in
        if granted {
            //用户同意我们推送通知
            print("用户同意我们推送通知")
        }else{
            //用户不同意
            print("用户不同意通知")
        }
    }
}
//推送通知
func makeNotification(title:String, text:String){
    //设置通知的触发器：0.1秒后触发推送（这种通知推送不能重复）
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
    
    //通知的内容
    let content = UNMutableNotificationContent()
    content.title = "\(title)"
    content.body = "\(text)"
    /* 通知提示音，default是“叮～”，就是短信的提示音。还有个defaultCritical，就是一般app推送通知的声音 */
    content.sound = UNNotificationSound.default 
    
    //完成通知的设置
    let request = UNNotificationRequest(identifier: "通知名称", content: content, trigger: trigger)
    //添加我们的通知到UNUserNotificationCenter推送的队列里
    UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
}
