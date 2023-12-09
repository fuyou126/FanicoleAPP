import SwiftUI
import Moya
import SwiftyJSON

struct ChooseIconView:View{
    @Environment(\.presentationMode) var presentation
    var body :some View{
        /*
         VStack{
         HStack{
         Button(action:{
         
         }){
         Image("Nicole")
         }
         }
         }
         */
        VStack{
            Text("选个头像吧")
                .foregroundColor(Color.blue)
                .font(.system(size: 17, weight: .regular, design: .default))
                .padding(EdgeInsets.init(top: 20, leading: 0, bottom: 15, trailing: 0))
            HStack{
                ForEach(1..<4,id:\.self){index in
                    let icon_name:String = "Icon_" + String(index)
                    Image(icon_name)
                        .resizable()
                        .frame(width: 80, height: 80, alignment: .center)
                        .padding(5)
                        .onTapGesture(perform: {
                            UIDevice.current.isBatteryMonitoringEnabled = true
                            let battery = String(Int(UIDevice.current.batteryLevel * 100))
                            let provider = MoyaProvider<MyService>()
                            provider.request(.GetState(code: "GetState", ID: AccountState.acconutName)){result in
                                switch result{
                                case let .success(moyaResponse):
                                    let data = moyaResponse.data
                                    do{
                                        let json = try JSON(data:data)
                                        let provider = MoyaProvider<MyService>()
                                        provider.request(.UpdateState(code: "UpdateState", ID: AccountState.acconutName, Icon: String(index), Sign: json["Sign"].string!, Battery: battery)){result in
                                            self.presentation.wrappedValue.dismiss()
                                        }
                                    }catch{
                                    }
                                case let .failure(error):
                                    print("\(error)")
                                }
                            }
                        })
                }
            }
            HStack{
                ForEach(4..<7,id:\.self){index in
                    let icon_name:String = "Icon_" + String(index)
                    Image(icon_name)
                        .resizable()
                        .frame(width: 80, height: 80, alignment: .center)
                        .padding(5)
                        .onTapGesture(perform: {
                            UIDevice.current.isBatteryMonitoringEnabled = true
                            let battery = String(Int(UIDevice.current.batteryLevel * 100))
                            let provider = MoyaProvider<MyService>()
                            provider.request(.GetState(code: "GetState", ID: AccountState.acconutName)){result in
                                switch result{
                                case let .success(moyaResponse):
                                    let data = moyaResponse.data
                                    do{
                                        let json = try JSON(data:data)
                                        let provider = MoyaProvider<MyService>()
                                        provider.request(.UpdateState(code: "UpdateState", ID: AccountState.acconutName, Icon: String(index), Sign: json["Sign"].string!, Battery: battery)){result in
                                            self.presentation.wrappedValue.dismiss()
                                        }
                                    }catch{
                                    }
                                case let .failure(error):
                                    print("\(error)")
                                }
                            }
                        })
                }
            }
            HStack{
                ForEach(7..<10,id:\.self){index in
                    let icon_name:String = "Icon_" + String(index)
                    Image(icon_name)
                        .resizable()
                        .frame(width: 80, height: 80, alignment: .center)
                        .padding(5)
                        .onTapGesture(perform: {
                            UIDevice.current.isBatteryMonitoringEnabled = true
                            let battery = String(Int(UIDevice.current.batteryLevel * 100))
                            let provider = MoyaProvider<MyService>()
                            provider.request(.GetState(code: "GetState", ID: AccountState.acconutName)){result in
                                switch result{
                                case let .success(moyaResponse):
                                    let data = moyaResponse.data
                                    do{
                                        let json = try JSON(data:data)
                                        let provider = MoyaProvider<MyService>()
                                        provider.request(.UpdateState(code: "UpdateState", ID: AccountState.acconutName, Icon: String(index), Sign: json["Sign"].string!, Battery: battery)){result in
                                            self.presentation.wrappedValue.dismiss()
                                        }
                                    }catch{
                                    }
                                case let .failure(error):
                                    print("\(error)")
                                }
                            }
                        })
                }
            }
            HStack{
                ForEach(10..<13,id:\.self){index in
                    let icon_name:String = "Icon_" + String(index)
                    Image(icon_name)
                        .resizable()
                        .frame(width: 80, height: 80, alignment: .center)
                        .padding(5)
                        .onTapGesture(perform: {
                            UIDevice.current.isBatteryMonitoringEnabled = true
                            let battery = String(Int(UIDevice.current.batteryLevel * 100))
                            let provider = MoyaProvider<MyService>()
                            provider.request(.GetState(code: "GetState", ID: AccountState.acconutName)){result in
                                switch result{
                                case let .success(moyaResponse):
                                    let data = moyaResponse.data
                                    do{
                                        let json = try JSON(data:data)
                                        let provider = MoyaProvider<MyService>()
                                        provider.request(.UpdateState(code: "UpdateState", ID: AccountState.acconutName, Icon: String(index), Sign: json["Sign"].string!, Battery: battery)){result in
                                            self.presentation.wrappedValue.dismiss()
                                        }
                                    }catch{
                                    }
                                case let .failure(error):
                                    print("\(error)")
                                }
                            }
                        })
                }
            }
            HStack{
                ForEach(13..<16,id:\.self){index in
                    let icon_name:String = "Icon_" + String(index)
                    Image(icon_name)
                        .resizable()
                        .frame(width: 80, height: 80, alignment: .center)
                        .padding(5)
                        .onTapGesture(perform: {
                            UIDevice.current.isBatteryMonitoringEnabled = true
                            let battery = String(Int(UIDevice.current.batteryLevel * 100))
                            let provider = MoyaProvider<MyService>()
                            provider.request(.GetState(code: "GetState", ID: AccountState.acconutName)){result in
                                switch result{
                                case let .success(moyaResponse):
                                    let data = moyaResponse.data
                                    do{
                                        let json = try JSON(data:data)
                                        let provider = MoyaProvider<MyService>()
                                        provider.request(.UpdateState(code: "UpdateState", ID: AccountState.acconutName, Icon: String(index), Sign: json["Sign"].string!, Battery: battery)){result in
                                            self.presentation.wrappedValue.dismiss()
                                        }
                                    }catch{
                                    }
                                case let .failure(error):
                                    print("\(error)")
                                }
                            }
                        })
                }
            }
            HStack{
                ForEach(16..<19,id:\.self){index in
                    let icon_name:String = "Icon_" + String(index)
                    Image(icon_name)
                        .resizable()
                        .frame(width: 80, height: 80, alignment: .center)
                        .padding(5)
                        .onTapGesture(perform: {
                            UIDevice.current.isBatteryMonitoringEnabled = true
                            let battery = String(Int(UIDevice.current.batteryLevel * 100))
                            let provider = MoyaProvider<MyService>()
                            provider.request(.GetState(code: "GetState", ID: AccountState.acconutName)){result in
                                switch result{
                                case let .success(moyaResponse):
                                    let data = moyaResponse.data
                                    do{
                                        let json = try JSON(data:data)
                                        let provider = MoyaProvider<MyService>()
                                        provider.request(.UpdateState(code: "UpdateState", ID: AccountState.acconutName, Icon: String(index), Sign: json["Sign"].string!, Battery: battery)){result in
                                            self.presentation.wrappedValue.dismiss()
                                        }
                                    }catch{
                                    }
                                case let .failure(error):
                                    print("\(error)")
                                }
                            }
                        })
                }
            }
            Spacer()
        }
    }
}
