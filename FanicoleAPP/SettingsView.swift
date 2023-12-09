import SwiftUI
import Moya
import SwiftyJSON
import SwiftPieChart

struct SettingsView:View{
    @Binding var isLogin:Bool
    
    @State var my_signed = ""
    @State var new_signed:String = ""
    @State var isEditSign:Bool = false
    @State var isChooseIcon:Bool = false
    
    @State var image_icon = "1"
    //@State var image = UIImage(systemName: "person")!
    @State var battery:Float = 1.0
    @State var haveMessage:Bool = false
    @State var online:Bool = true
    @State var UserName:String = AccountState.acconutName
    @State var Mood:Int = 0
    @State var HobbyType:String = "0"
    @State var Hobby:String = ""
    @State var MoodLine:[Double] = [2,2,2,2,2,2,2]
    @State var MoodDateString:[String] = ["","","","","","",""]
    @State var MoodPie:[Double] = [0,0,0,0,0]
    @State var chooseChart:Int = 0
    
    @Environment(\.colorScheme) var colorScheme
    var body: some View{
        ZStack{
            //ScrollView(.vertical,showsIndicators:false){
            VStack{
                Card(image: $image_icon, battery: $battery, name: $UserName, signed: $my_signed, haveMessage: $haveMessage , online: $online,HobbyType: $HobbyType,Mood: $Mood,Hobby: $Hobby)
                    .onTapGesture(perform: {
                        isChooseIcon = true
                    })
                HStack{
                    if !isEditSign{
                        Text(my_signed)
                            .font(.system(size: 15, weight: .light, design: .default))
                            .padding()
                    }else{
                        TextField("输入个性签名", text: $new_signed)
                            .font(.system(size: 15, weight: .light, design: .default))
                            .padding()
                    }
                    Spacer()
                    Button(action:{
                        withAnimation{
                            if !isEditSign{
                                new_signed = ""
                            }
                            if isEditSign && new_signed != ""{
                                //签名修改了！
                                my_signed = new_signed
                                //
                                let provider = MoyaProvider<MyService>()
                                provider.request(.UpdateState(code: "UpdateState", ID: UserName, Icon: image_icon, Sign: my_signed, Battery: String(Int(battery * 100.0)))){result in
                                }
                                //
                            }
                            isEditSign.toggle()
                        }
                    }){
                        if !isEditSign{
                            Image(systemName: "pencil.circle")
                                .resizable()
                                .frame(width: 20, height: 20, alignment: .center)
                                .padding()
                        }else {
                            Image(systemName: "xmark.circle")
                                .resizable()
                                .frame(width: 20, height: 20, alignment: .center)
                                .padding()
                        }
                    }
                    .foregroundColor(Color.gray)
                }
                .frame(width: 260, height: 40, alignment: .leading)
                .background(colorScheme == .light ? Color.white:Color.black)
                .cornerRadius(8)
                .overlay(RoundedRectangle(cornerRadius: 8, style: .continuous).stroke(Color.gray,lineWidth: 0.8))
                .padding()
                if chooseChart == 0{
                    ZStack{
                        LineChartView(data: MoodLine,dateString: MoodDateString)
                            .padding([.bottom],20)
                        Button(action: {
                            withAnimation(.spring()){
                                chooseChart = 1
                            }
                        }, label: {
                            Image(systemName: "chart.pie.fill")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundColor(.gray)
                                .padding([.trailing],15)
                        })
                            .padding([.leading],215)
                            .padding([.bottom],190)
                    }
                } else{
                    ZStack{
                        PieChartView(values: MoodPie,names:["感谢","愉快","中性","抱怨","愤怒"],formatter:{value in String(format:"$%.2f",value)},colors:[Color.red,Color.purple,Color.orange,Color.green,Color.blue ],backgroundColor: .init(red: 242.0/256, green: 242.0/256, blue: 246.0/256),innerRadiusFraction: 0.5)
                            .padding([.bottom],20)
                        Button(action: {
                            withAnimation(.spring()){
                                chooseChart = 0
                            }
                        }, label: {
                            Image(systemName: "chart.line.uptrend.xyaxis")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundColor(.gray)
                                .padding([.trailing],15)
                        })
                            .padding([.leading],215)
                            .padding([.bottom],190)
                    }
                }
                Spacer()
                Button(action:{
                    isLogin = false
                    let provider = MoyaProvider<MyService>()
                    provider.request(.SetUUID(code: "SetUUID", ID: AccountState.acconutName, UUID: "None")){result in
                        AccountState.acconutName = ""
                    }
                }){
                    Text("退出登录")
                        .frame(width: 260, height: 40, alignment: .center)
                        .font(.system(size: 16, weight: .regular, design: .default))
                        .foregroundColor(Color.white)
                }
                //.frame(width: 250, height: 40, alignment: .center)
                .background(Color.red)
                .cornerRadius(8)
                .overlay(RoundedRectangle(cornerRadius: 8, style: .continuous).stroke(Color.white,lineWidth: 0.8))
                .padding(EdgeInsets.init(top: 0, leading: 0, bottom: 50, trailing: 0))
            }
            .padding(EdgeInsets.init(top: 90, leading: 0, bottom: 0, trailing: 0))
            
        }
        .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, minHeight: 0, idealHeight: .infinity, maxHeight: .infinity, alignment: .center)
        .background(colorScheme == .light ? Color.init(red: 242.0/256, green: 242.0/256, blue: 246.0/256):Color.init(red: 28.0/256, green: 28.0/256, blue: 30.0/256))
        .sheet(isPresented: $isChooseIcon){
            ChooseIconView()
                .onDisappear(perform: {
                    let provider = MoyaProvider<MyService>()
                    UIDevice.current.isBatteryMonitoringEnabled = true
                    battery = UIDevice.current.batteryLevel
                    provider.request(.GetState(code: "GetState", ID: AccountState.acconutName)){result in
                        switch result{
                        case let .success(moyaResponse):
                            let data = moyaResponse.data
                            do{
                                let json = try JSON(data:data)
                                if json["code"].int! == 1{
                                    image_icon = json["Icon"].string!
                                    my_signed = json["Sign"].string!
                                    let provider_ = MoyaProvider<MyService>()
                                    provider_.request(.UpdateState(code: "UpdateState", ID: AccountState.acconutName, Icon: image_icon, Sign: my_signed, Battery: String(Int(battery*100)))){result in
                                    }
                                }
                            }catch{
                            }
                        case let .failure(error):
                            print("\(error)")
                        }
                    }
                })
        }
        .onAppear(perform: {
            let provider = MoyaProvider<MyService>()
            UIDevice.current.isBatteryMonitoringEnabled = true
            battery = UIDevice.current.batteryLevel
            provider.request(.GetState(code: "GetState", ID: AccountState.acconutName)){result in
                switch result{
                case let .success(moyaResponse):
                    let data = moyaResponse.data
                    do{
                        let json = try JSON(data:data)
                        if json["code"].int! == 1{
                            image_icon = json["Icon"].string!
                            my_signed = json["Sign"].string!
                            HobbyType = json["HobbyType"].string!
                            Hobby = json["Hobby"].string!
                            let provider_ = MoyaProvider<MyService>()
                            provider_.request(.UpdateState(code: "UpdateState", ID: AccountState.acconutName, Icon: image_icon, Sign: my_signed, Battery: String(Int(battery*100)))){result in
                            }
                        }
                    }catch{
                    }
                case let .failure(error):
                    print("\(error)")
                }
            }
            //
            let provider_ = MoyaProvider<MyService>()
            provider_.request(.GetMood(code: "GetMood", ID: AccountState.acconutName)){result in
                switch result{
                case let .success(moyaResponse):
                    let data = moyaResponse.data
                    do{
                        let json = try JSON(data:data)
                        if json["code"].int! == 1{
                            //获取折线图数据
                            for i in 1...7{
                                var moodSum = 0
                                //感谢+1
                                moodSum += json["day" + String(i)][0].int!
                                //愉快+2
                                moodSum += 2 * json["day" + String(i)][1].int!
                                //抱怨-1
                                moodSum -= json["day" + String(i)][3].int!
                                //生气-2
                                moodSum -= 2 * json["day" + String(i)][4].int!
                                
                                if moodSum > 0{
                                    MoodLine[i - 1] = 3
                                }else if moodSum < 0{
                                    MoodLine[i - 1] = 1
                                }else{
                                    MoodLine[i - 1] = 2
                                }
                                MoodDateString[i - 1] = json["dateString"][i - 1].string!
                            }
                            Mood = lround(MoodLine[6])
                            //获取饼状图数据
                            var moodPieSum:[Int] = [0,0,0,0,0]
                            for i in 1...7{
                                for j in 0..<5{
                                    moodPieSum[j] += json["day" + String(i)][j].int!
                                }
                            }
                            for i in 0..<5{
                                MoodPie[i] = Double(moodPieSum[i])
                            }
                        }
                    }catch{}
                case let .failure(error):
                    print(error)
                }
            }/*
             let provider__ = MoyaProvider<MyService>()
             provider_.request(.UpdateState(code:"UpdateState",ID: AccountState.acconutName,Icon: image_icon,Sign: my_signed,Battery: String(Int(battery * 100.0)))){result in
             switch result{
             case let .success(moyaResponse):
             let data = moyaResponse.data
             do{
             let json = try JSON(data:data)
             if json["code"].int! == 1{
             print("Update Successful")
             }
             }catch{
             }
             case let .failure(error):
             print("\(error)")
             }
             }
              */
        })
    }
}
