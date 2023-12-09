import SwiftUI
import Moya
import SwiftyJSON

struct FriendView:View{
    @State var have_new_friend:Int = 0
    @State var new_friend_str:String = "还没有好友请求"
    /*
     var new_friend_str:String {
     if have_new_friend == 0{
     return "还没有好友请求"
     }else{
     return "有\(have_new_friend)条好友请求"
     }
     }
     */
    /*
     @State var new_friend1_image = UIImage(named: "Shit")!
     @State var new_friend1_word:String = "fan：想加个好友"
     */
    @State var new_friend_image:[String] = []
    @State var new_friend_id:[String] = []
    @State var new_friend_word:[String] = []
    
    @State var friend:Int = 0
    @State var myfriend_image:[String] = []
    @State var myfriend_name:[String] = []
    @State var myfriend_online:[Bool] = []
    
    @State var add_friend:Bool = false
    @State var add_friend_name:String = ""
    @State var add_friend_word:String = ""
    
    @State var button = false
    @State var delete_button = false
    @State var black_button = false
    @Environment(\.colorScheme) var colorScheme
    var body: some View{
        ZStack{
            VStack{
                List{
                    Section(header:Text("新的好友请求")){
                        DisclosureGroup(new_friend_str){
                            ForEach(0..<new_friend_image.count,id:\.self){index in
                                NewFriend_Request(new_friend_image: $new_friend_image[index], new_friend_word: $new_friend_word[index], new_friend_id: $new_friend_id[index])
                                    .onTapGesture(perform: {
                                        button = true
                                    })
                                    .alert(isPresented: $button) {()-> Alert in Alert(title: Text("确定加好友吗"), message: Text("拉黑后不接受请求"), primaryButton:.default(Text("确定"), action: {
                                        let provider = MoyaProvider<MyService>()
                                        provider.request(.NewFriend_Yes(code: "NewFriend_Yes", ID: AccountState.acconutName, YourID: new_friend_id[index])){result in
                                            new_friend_id = []
                                            new_friend_image = []
                                            new_friend_word = []
                                            have_new_friend = 0
                                            myfriend_name = []
                                            myfriend_image = []
                                            myfriend_online = []
                                            let provider = MoyaProvider<MyService>()
                                            provider.request(.GetFriends(code: "GetFriends", ID: AccountState.acconutName)){result in
                                                switch result{
                                                case let .success(moyaResponse):
                                                    let data = moyaResponse.data
                                                    do{
                                                        let json = try JSON(data: data)
                                                        if json["code"].int! == 1 && json["Number"].int! != 0{
                                                            for i in 1...json["Number"].int!{
                                                                if json[String(i)][2].string! == "1"{
                                                                    myfriend_name.append(json[String(i)][0].string!)
                                                                    myfriend_image.append(json[String(i)][4].string!)
                                                                    if json[String(i)][1].string! == "1"{
                                                                        myfriend_online.append(true)
                                                                    }else{
                                                                        myfriend_online.append(false)
                                                                    }
                                                                }else if json[String(i)][2].string! != "-1" {
                                                                    new_friend_id.append(json[String(i)][0].string!)
                                                                    new_friend_image.append(json[String(i)][4].string!)
                                                                    new_friend_word.append(json[String(i)][2].string!)
                                                                    have_new_friend = have_new_friend + 1
                                                                }
                                                            }
                                                            if have_new_friend != 0{
                                                                new_friend_str = "有\(have_new_friend)条好友请求"
                                                            }else{
                                                                new_friend_str = "还没有好友请求"
                                                            }
                                                        }
                                                    }catch{
                                                    }
                                                case let .failure(error):
                                                    print("\(error)")
                                                }
                                            }
                                        }
                                    }), secondaryButton: .default(Text("取消"), action: {
                                        let provider = MoyaProvider<MyService>()
                                        provider.request(.NewFriend_No(code: "NewFriend_No", ID: AccountState.acconutName, YourID: new_friend_id[index])){result in
                                            new_friend_id = []
                                            new_friend_image = []
                                            new_friend_word = []
                                            have_new_friend = 0
                                            myfriend_name = []
                                            myfriend_image = []
                                            myfriend_online = []
                                            let provider = MoyaProvider<MyService>()
                                            provider.request(.GetFriends(code: "GetFriends", ID: AccountState.acconutName)){result in
                                                switch result{
                                                case let .success(moyaResponse):
                                                    let data = moyaResponse.data
                                                    do{
                                                        let json = try JSON(data: data)
                                                        if json["code"].int! == 1 && json["Number"].int! != 0{
                                                            for i in 1...json["Number"].int!{
                                                                if json[String(i)][2].string! == "1"{
                                                                    myfriend_name.append(json[String(i)][0].string!)
                                                                    myfriend_image.append(json[String(i)][4].string!)
                                                                    if json[String(i)][1].string! == "1"{
                                                                        myfriend_online.append(true)
                                                                    }else{
                                                                        myfriend_online.append(false)
                                                                    }
                                                                }else if json[String(i)][2].string! != "-1"{
                                                                    new_friend_id.append(json[String(i)][0].string!)
                                                                    new_friend_image.append(json[String(i)][4].string!)
                                                                    new_friend_word.append(json[String(i)][2].string!)
                                                                    have_new_friend = have_new_friend + 1
                                                                }
                                                            }
                                                            if have_new_friend != 0{
                                                                new_friend_str = "有\(have_new_friend)条好友请求"
                                                            }else{
                                                                new_friend_str = "还没有好友请求"
                                                            }
                                                        }
                                                    }catch{
                                                    }
                                                case let .failure(error):
                                                    print("\(error)")
                                                }
                                            }
                                        }
                                    }))
                                    }
                                
                            }
                            /*
                             if have_new_friend == 1{
                             NewFriend_Request(new_friend_image: $new_friend1_image, new_friend_word: $new_friend1_word)
                             }
                             */
                        }
                    }
                    Section(header:Text("好友列表")){
                        ForEach(0..<myfriend_online.count,id:\.self){index in
                            MyFriend(image: $myfriend_image[index], name: $myfriend_name[index], online: $myfriend_online[index])
                                .onLongPressGesture(perform: {
                                    delete_button = true
                                })
                                .alert(isPresented: $delete_button) {()-> Alert in 
                                    Alert(title: Text("确定删除好友(\(myfriend_name[index]))"), message: nil, primaryButton: .default(Text("确定"),action: {
                                        let provider = MoyaProvider<MyService>()
                                        provider.request(.DeleteFriend(code: "DeleteFriend", ID: AccountState.acconutName, YourID: myfriend_name[index])){result in
                                            
                                            let provider = MoyaProvider<MyService>()
                                            provider.request(.GetFriends(code: "GetFriends", ID: AccountState.acconutName)){result in
                                                switch result{
                                                case let .success(moyaResponse):
                                                    new_friend_id = []
                                                    new_friend_image = []
                                                    new_friend_word = []
                                                    have_new_friend = 0
                                                    myfriend_name = []
                                                    myfriend_image = []
                                                    myfriend_online = []
                                                    let data = moyaResponse.data
                                                    do{
                                                        let json = try JSON(data: data)
                                                        if json["code"].int! == 1 && json["Number"].int! != 0{
                                                            for i in 1...json["Number"].int!{
                                                                if json[String(i)][2].string! == "1"{
                                                                    myfriend_name.append(json[String(i)][0].string!)
                                                                    myfriend_image.append(json[String(i)][4].string!)
                                                                    if json[String(i)][1].string! == "1"{
                                                                        myfriend_online.append(true)
                                                                    }else{
                                                                        myfriend_online.append(false)
                                                                    }
                                                                }else if json[String(i)][2].string! != "-1"{
                                                                    new_friend_id.append(json[String(i)][0].string!)
                                                                    new_friend_image.append(json[String(i)][4].string!)
                                                                    new_friend_word.append(json[String(i)][2].string!)
                                                                    have_new_friend = have_new_friend + 1
                                                                }
                                                            }
                                                            if have_new_friend != 0{
                                                                new_friend_str = "有\(have_new_friend)条好友请求"
                                                            }
                                                        }
                                                    }catch{
                                                    }
                                                case let .failure(error):
                                                    print("\(error)")
                                                }
                                            }
                                        }
                                    }), secondaryButton: .default(Text("取消")))}
                        }
                        /*
                         MyFriend(image: $myfriend_image, name: $myfriend_name,online:$myfriend_online)
                         */
                    }
                }
                .padding(EdgeInsets.init(top: 53, leading: 0, bottom: 0, trailing: 0))
                Button(action:{
                    add_friend = true
                }){
                    Image(systemName: "person.crop.circle.badge.plus")
                        .resizable()
                        .frame(width: 35, height: 30, alignment: .center)
                        .padding(EdgeInsets.init(top: 0, leading: 0, bottom: 40, trailing: 0))
                }
                
            }
            .onAppear(perform: {
                let provider = MoyaProvider<MyService>()
                provider.request(.GetFriends(code: "GetFriends", ID: AccountState.acconutName)){result in
                    switch result{
                    case let .success(moyaResponse):
                        new_friend_id = []
                        new_friend_image = []
                        new_friend_word = []
                        have_new_friend = 0
                        myfriend_name = []
                        myfriend_image = []
                        myfriend_online = []
                        let data = moyaResponse.data
                        do{
                            let json = try JSON(data: data)
                            if json["code"].int! == 1 && json["Number"].int! != 0{
                                for i in 1...json["Number"].int!{
                                    if json[String(i)][2].string! == "1"{
                                        myfriend_name.append(json[String(i)][0].string!)
                                        myfriend_image.append(json[String(i)][4].string!)
                                        if json[String(i)][1].string! == "1"{
                                            myfriend_online.append(true)
                                        }else{
                                            myfriend_online.append(false)
                                        }
                                    }else if json[String(i)][2].string! != "-1"{
                                        new_friend_id.append(json[String(i)][0].string!)
                                        new_friend_image.append(json[String(i)][4].string!)
                                        new_friend_word.append(json[String(i)][2].string!)
                                        have_new_friend = have_new_friend + 1
                                    }
                                }
                                if have_new_friend != 0{
                                    new_friend_str = "有\(have_new_friend)条好友请求"
                                }
                            }
                        }catch{
                        }
                    case let .failure(error):
                        print("\(error)")
                    }
                }
            })
            .sheet(isPresented: $add_friend,content: {
                AddFriendView()
            })
            .background(colorScheme == .light ? Color.init(red: 242.0/256, green: 242.0/256, blue: 246.0/256) : Color.black)
            
            VStack{
                HStack{
                    Spacer()
                    Button(action:{
                        black_button = true
                    }){
                        Image(systemName: "person.crop.circle.badge.exclamationmark")
                            .resizable()
                            .frame(width: 35, height: 30, alignment: .center)
                            .padding(EdgeInsets.init(top: 10, leading: 0, bottom: 0, trailing: 20))
                            .foregroundColor(Color.red)
                    }
                }
                Spacer()
            }
            if black_button {
                BlacklistView(isBlacklistView: $black_button, new_friend_id: $new_friend_id)
            }
        }
    }
}
