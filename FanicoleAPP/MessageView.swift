import SwiftUI
import SwiftyJSON
import Moya

struct MessageView:View{
    @Environment(\.colorScheme) var colorScheme
    @State var firend_index:Int = 0
    @State var isChatting:Bool = false
    @State var friendNumber:Int = 2
    //再加点每个好友的数据用来传参
    @State var friend_image:[String] = []
    @State var friend_battery:[Float] = []
    @State var friend_name:[String] = []
    @State var friend_sign:[String] = []
    @State var friend_havemessage:[Bool] = []
    @State var friend_online:[Bool] = []
    @State var friend_HobbyType:[String] = []
    @State var friend_mood:[Int] = []
    @State var friend_Hobby:[String] = []
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    @State var lastMessage = ""
    @Binding var isPop:Bool
    @Binding var message_icon:String
    @Binding var message_id:String
    @Binding var message_content:String
    @Binding var nowTime:String
    var body: some View{
        VStack{
            ScrollView(.vertical){
                VStack{
                    /*
                     //好友1
                     if friendNumber >= 1{
                     Card(image: UIImage(named: "Cat")!, battery: 0.2, name: "Cat", signed: "这bug", haveMessage: true, online: true)
                     .padding()
                     .onTapGesture(perform: {
                     isChatting = true
                     })
                     }
                     //好友2
                     if friendNumber >= 2{
                     Card(image: UIImage(named: "Shit")!, battery: 0.85, name: "Fan", signed: "我对这个世界没什么好说的", haveMessage: true, online: true)
                     .padding()
                     .onTapGesture(perform: {
                     isChatting = true
                     })
                     */
                    //在这里修改循环 
                    ForEach(0..<friend_online.count,id:\.self){ index in
                        Card(image: $friend_image[index], battery: $friend_battery[index], name: $friend_name[index], signed: $friend_sign[index], haveMessage: $friend_havemessage[index], online: $friend_online[index],HobbyType: $friend_HobbyType[index],Mood: $friend_mood[index],Hobby: $friend_Hobby[index])
                            .padding()
                            .onTapGesture(perform: {
                                firend_index = index
                                isChatting = true
                                //friend_id = friend_name[index]
                            })
                    }
                }
                .sheet(isPresented: $isChatting){
                    ChatView(your_id: $friend_name[firend_index],havemessage:$friend_havemessage[firend_index])
                }
            }
        }
        .onAppear(perform: {
            friend_image = []
            friend_battery = []
            friend_name = []
            friend_sign = []
            friend_havemessage = []
            friend_online = []
            friend_HobbyType = []
            friend_Hobby = []
            friend_mood = []
            let provider = MoyaProvider<MyService>()
            provider.request(.GetFriends(code: "GetFriends", ID: AccountState.acconutName)){result in
                switch result{
                case let .success(moyaResponse):
                    let data = moyaResponse.data
                    do{
                        let json = try JSON(data:data)
                        if json["code"].int! == 1 && json["Number"].int! != 0{
                            for i in 1...json["Number"].int!{
                                if json[String(i)][2].string! == "1"{
                                    friend_image.append(json[String(i)][4].string!)
                                    friend_battery.append(Float(Float(json[String(i)][6].string!)! * 0.01))
                                    friend_name.append(json[String(i)][0].string!)
                                    friend_sign.append(json[String(i)][5].string!)
                                    if json[String(i)][3].string! == "1"{
                                        friend_havemessage.append(true)
                                    }else{
                                        friend_havemessage.append(false)
                                    }
                                    if json[String(i)][1].string! == "1"{
                                        friend_online.append(true)
                                    }else{
                                        friend_online.append(false)
                                    }
                                    friend_HobbyType.append(json[String(i)][8].string!)
                                    friend_Hobby.append(json[String(i)][9].string!)
                                    let str = json[String(i)][10].string!
                                    friend_mood.append(Int(str)!)
                                }
                            }
                        }
                    }catch{
                    }
                case let .failure(error):
                    print("\(error)")
                }
            }
        })
        .onReceive(timer){time in
            let provider = MoyaProvider<MyService>()
            provider.request(.GetFriends(code: "GetFriends", ID: AccountState.acconutName)){result in
                switch result{
                case let .success(moyaResponse):
                    let data = moyaResponse.data
                    do{
                        let json = try JSON(data:data)
                        if json["code"].int! == 1 && json["Number"].int! != 0{
                            for i in 1...json["Number"].int!{
                                if json[String(i)][3].string! == "1" && json[String(i)][7].string! != lastMessage{
                                    nowTime = time.formatted(.dateTime.hour().minute())
                                    friend_havemessage[i - 1] = true
                                    message_icon = friend_image[i - 1]
                                    message_id = friend_name[i - 1]
                                    message_content = json[String(i)][7].string!
                                    lastMessage = message_content
                                    isPop = false
                                    isPop = true
                                    //makeNotification(title: message_id, text: message_content)
                                    break
                                }
                            }
                        }
                    }catch{}
                case let .failure(error):
                    print("\(error)")
                }
            }
        }
        //.background(Color.blue)
        .padding(EdgeInsets.init(top: 58, leading: 0, bottom: 0, trailing: 0))
        .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, minHeight: 0, idealHeight: .infinity, maxHeight: .infinity, alignment: .center)
        .background(colorScheme == .light ? Color.init(red: 242.0/256, green: 242.0/256, blue: 246.0/256):Color.init(red: 28.0/256, green: 28.0/256, blue: 30.0/256))
    }
}

