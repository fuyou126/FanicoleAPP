import SwiftUI
import SwiftyJSON
import Moya

struct ChatView:View{
    @Environment(\.presentationMode) var presentation
    @State var lastEmo = 2
    @State var input:String = ""
    @State var my_id:String = "Fan"
    @State var my_image:String = "1"
    @Binding var your_id:String
    @State var your_image:String = "1"
    @State var Word:[String] = []
    @State var isMyWord:[Bool] = []
    @State var isReportAlert = false
    @State var reportReason = ""
    @State var isClearAlert = false
    @State var changeContentPosition = false
    @Binding var havemessage:Bool
    @Environment(\.colorScheme) var colorScheme
    var body:some View{
        ZStack{
            VStack{
                ZStack{
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
                            isReportAlert = true
                        }){
                            Image(systemName: "exclamationmark.triangle")
                                .resizable()
                                .frame(width: 20, height: 20, alignment: .center)
                        }
                        .padding()
                    }
                    Button(action:{
                        let provider = MoyaProvider<MyService>()
                        provider.request(.GetChat(code: "GetChat", ID: AccountState.acconutName, YourID: your_id)){result in
                            switch result{
                            case let .success(moyaResponse):
                                let data = moyaResponse.data
                                isMyWord = []
                                Word = []
                                do{
                                    let json = try JSON(data:data)
                                    if json["code"].int! == 1 && json["Number"].int! != 0{
                                        my_image = json["MyIcon"].string!
                                        your_image = json["YourIcon"].string!
                                        for i in 1...json["Number"].int!{
                                            if json[String(i)][0].string! == "1"{
                                                isMyWord.append(true)
                                            }else{
                                                isMyWord.append(false)
                                            }
                                            Word.append(json[String(i)][1].string!)
                                        }
                                        changeContentPosition = !changeContentPosition
                                        withAnimation(.spring()){
                                            lastEmo = json["Emo"].int!
                                        }
                                    }
                                }catch{
                                }
                            case let .failure(error):
                                print("\(error)")
                            }
                        }
                    }){
                        Text(your_id)
                            .font(.system(size: 18, weight: .ultraLight, design: .monospaced))
                        //.foregroundColor(Color.black)
                    }
                    .alert(isPresented: $isClearAlert) {()-> Alert in 
                        Alert(title: Text("要清空聊天记录吗"), message: nil, primaryButton: .default(Text("要"),action: {
                            let provider = MoyaProvider<MyService>()
                            provider.request(.ClearChats(code: "ClearChats", ID: AccountState.acconutName, YourID: your_id)){result in
                                let provider = MoyaProvider<MyService>()
                                provider.request(.GetChat(code: "GetChat", ID: AccountState.acconutName, YourID: your_id)){result in
                                    Word = []
                                    isMyWord = []
                                    switch result{
                                    case let .success(moyaResponse):
                                        let data = moyaResponse.data
                                        do{
                                            let json = try JSON(data:data)
                                            if json["code"].int! == 1 && json["Number"].int! != 0{
                                                my_image = json["MyIcon"].string!
                                                your_image = json["YourIcon"].string!
                                                for i in 1...json["Number"].int!{
                                                    if json[String(i)][0].string! == "1"{
                                                        isMyWord.append(true)
                                                    }else{
                                                        isMyWord.append(false)
                                                    }
                                                    Word.append(json[String(i)][1].string!)
                                                }
                                            }
                                        }catch{
                                        }
                                    case let .failure(error):
                                        print("\(error)")
                                    }
                                }
                            }
                        }), secondaryButton: .default(Text("不要"),action: {
                        }))
                    }
                    
                    
                }
                ScrollView(.vertical){
                    ScrollViewReader{sp in
                    VStack{
                        //一堆聊天记录
                        ForEach(0..<isMyWord.count,id:\.self){index in
                            if isMyWord[index]{
                                MessageContentView(image: $my_image, isMyWord: $isMyWord[index], Word:$Word[index] )
                                    .onLongPressGesture(perform: {
                                        isClearAlert = true
                                    })
                            }else{
                                MessageContentView(image: $your_image, isMyWord: $isMyWord[index], Word:$Word[index] )
                                    .onLongPressGesture(perform: {
                                        isClearAlert = true
                                    })
                            }
                        }.onChange(of:changeContentPosition){[changeContentPosition] newState in
                            sp.scrollTo(isMyWord.count - 1,anchor:.bottom)
                        }
                        /*
                         MessageContentView()
                         MessageContentView(image: UIImage(named: "Cat")!, isMyWord: true, Word: "Fuck")
                         */
                    }
                    }
                }
                Spacer()
                ZStack{
                    TextField("你要说啥", text: $input)
                        .font(.system(size: 15, weight: .light, design: .rounded))
                        .offset(x: 0, y: 0)
                        .frame(width: 200, height: 35, alignment: .center)
                        .background(colorScheme == .light ? Color.white:Color.black)
                        .cornerRadius(0)
                        .overlay(Image(systemName: "text.bubble")
                                    .resizable()
                                    .frame(width: 20, height: 20, alignment: .center)
                                    .foregroundColor(Color.blue)
                                    .offset(x: -123, y: 1.5))
                        .onSubmit({
                            //消息发出去啦
                            if input != ""{
                                let new_input = input
                                Word.append(new_input)
                                isMyWord.append(true)
                                changeContentPosition = !changeContentPosition
                                input = ""
                                let provider = MoyaProvider<MyService>()
                                provider.request(.SendMessage(code: "SendMessage", ID: AccountState.acconutName, YourID: your_id, Content: new_input)){result in
                                    let provider = MoyaProvider<MyService>()
                                    provider.request(.GetChat(code: "GetChat", ID: AccountState.acconutName, YourID: your_id)){result in
                                        switch result{
                                        case let .success(moyaResponse):
                                            let data = moyaResponse.data
                                            do{
                                                let json = try JSON(data:data)
                                                Word = []
                                                isMyWord = []
                                                if json["code"].int! == 1 && json["Number"].int! != 0{
                                                    my_image = json["MyIcon"].string!
                                                    your_image = json["YourIcon"].string!
                                                    for i in 1...json["Number"].int!{
                                                        if json[String(i)][0].string! == "1"{
                                                            isMyWord.append(true)
                                                        }else{
                                                            isMyWord.append(false)
                                                        }
                                                        Word.append(json[String(i)][1].string!)
                                                    }
                                                    changeContentPosition = !changeContentPosition
                                                    withAnimation(.spring()){
                                                        lastEmo = json["Emo"].int!
                                                    }
                                                }
                                            }catch{
                                            }
                                        case let .failure(error):
                                            print("\(error)")
                                        }
                                    }
                                }
                            }
                        })
                    Button(action:{
                        //消息发出去啦
                        if input != ""{
                            let new_input = input
                            Word.append(new_input)
                            isMyWord.append(true)
                            changeContentPosition = !changeContentPosition
                            input = ""
                            let provider = MoyaProvider<MyService>()
                            provider.request(.SendMessage(code: "SendMessage", ID: AccountState.acconutName, YourID: your_id, Content: new_input)){result in
                                let provider = MoyaProvider<MyService>()
                                provider.request(.GetChat(code: "GetChat", ID: AccountState.acconutName, YourID: your_id)){result in
                                    switch result{
                                        case let .success(moyaResponse):
                                        let data = moyaResponse.data
                                        do{
                                            let json = try JSON(data:data)
                                            Word = []
                                            isMyWord = []
                                            if json["code"].int! == 1 && json["Number"].int! != 0{
                                                my_image = json["MyIcon"].string!
                                                your_image = json["YourIcon"].string!
                                                for i in 1...json["Number"].int!{
                                                    if json[String(i)][0].string! == "1"{
                                                        isMyWord.append(true)
                                                    }else{
                                                        isMyWord.append(false)
                                                    }
                                                    Word.append(json[String(i)][1].string!)
                                                }
                                                changeContentPosition = !changeContentPosition
                                                withAnimation(.spring()){
                                                    lastEmo = json["Emo"].int!
                                                }
                                            }
                                        }catch{
                                        }
                                    case let .failure(error):
                                        print("\(error)")
                                    }
                                }
                            }
                        }
                    }){
                        Image(systemName: "arrow.right.circle")
                            .resizable()
                            .frame(width: 20, height: 20, alignment: .center)
                            .foregroundColor(Color.blue)
                        //.padding(EdgeInsets.init(top: 0, leading: 250, bottom: 0, trailing: 0))
                    }
                    .frame(width: 20, height: 20, alignment: .center)
                    .padding(EdgeInsets.init(top: 0, leading: 250, bottom: 0, trailing: 0))
                    
                }
                .frame(width: 300, height: 35, alignment: .center)
                .background(colorScheme == .light ? Color.white:Color.black)
                .cornerRadius(18)
                .overlay(RoundedRectangle(cornerRadius: 18, style: .continuous).stroke(Color.blue,lineWidth: 0.8))
                .padding(EdgeInsets.init(top: 0, leading: 0, bottom: 50, trailing: 0))
                
                
            }
            .onAppear(perform: {
                //
                havemessage = false
                let provider = MoyaProvider<MyService>()
                provider.request(.GetChat(code: "GetChat", ID: AccountState.acconutName, YourID: your_id)){result in
                    Word = []
                    isMyWord = []
                    switch result{
                    case let .success(moyaResponse):
                        let data = moyaResponse.data
                        do{
                            let json = try JSON(data:data)
                            if json["code"].int! == 1 && json["Number"].int! != 0{
                                my_image = json["MyIcon"].string!
                                your_image = json["YourIcon"].string!
                                for i in 1...json["Number"].int!{
                                    if json[String(i)][0].string! == "1"{
                                        isMyWord.append(true)
                                    }else{
                                        isMyWord.append(false)
                                    }
                                    Word.append(json[String(i)][1].string!)
                                }
                                changeContentPosition = !changeContentPosition
                                withAnimation(.spring()){
                                    lastEmo = json["Emo"].int!
                                }
                            }
                        }catch{
                        }
                    case let .failure(error):
                        print("\(error)")
                    }
                }
            })
            .background(colorScheme == .light ? Color.init(red: 242.0/256, green: 242.0/256, blue: 246.0/256):Color.init(red: 28.0/256, green: 28.0/256, blue: 30.0/256))
            if isReportAlert {
                ReportView(isReportAlert: $isReportAlert, YourID: $your_id)
            }
            if lastEmo == 4{
                EmoAnimationView(lottieFile: "Emo_animation_4",lastEmo: $lastEmo)
                    .frame(width: 100, height: 100)
                    .animation(.easeInOut(duration: 0.5), value: lastEmo)
            }else if lastEmo == 3{
                EmoAnimationView(lottieFile: "Emo_animation_3",setFrame: true,startFrame: 0,endFrame: 90.0, lastEmo: $lastEmo)
                    .frame(width: 300, height: 500)
                    .animation(.easeInOut(duration:0.5),value: lastEmo)
            }else if lastEmo == 1{
                EmoAnimationView(lottieFile:"Emo_animation_1",lastEmo:$lastEmo)
                    .frame(width:200,height:200)
                    .animation(.easeInOut(duration:0.5), value: lastEmo)
            }else if lastEmo == 0{
                EmoAnimationView(lottieFile:"Emo_animation_0",lastEmo:$lastEmo)
                .frame(width:300,height:300)
                    .animation(.easeInOut(duration:0.5), value: lastEmo)
            }
        }
    }
}

