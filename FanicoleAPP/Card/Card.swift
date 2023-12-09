import SwiftUI

struct Card:View{
    @Binding var image:String
    @Binding var battery:Float
    @Binding var name:String
    @Binding var signed:String
    @Binding var haveMessage:Bool
    @Binding var online:Bool
    @Binding var HobbyType:String
    @Binding var Mood:Int
    @Binding var Hobby:String
    @Environment(\.colorScheme) var colorScheme
    var body: some View{
        ZStack{
            VStack{
                HStack(spacing:0){
                    Image(uiImage: UIImage(named: "Icon_"+image)!)
                        .resizable()
                        .cornerRadius(8)
                        .frame(width: 50, height: 50, alignment: .center)
                        .padding([.leading],10)
                    VStack(alignment:.leading){
                        Text(name)
                            .font(.system(size: 20, weight: Font.Weight.light, design: .monospaced))
                            .frame(width: 200, height: 20,alignment: .leading)
                            .padding([.top],5)
                        //Text("电池")
                        Spacer()
                        HStack{
                            if !haveMessage{
                                if online{
                                    Text("在线")
                                        .font(.system(size: 12, weight: Font.Weight.light, design: .rounded))
                                        .padding([.bottom],5)
                                    Circle()
                                        .foregroundColor(Color.green)
                                        .frame(width: 8, height: 8, alignment: .leading)
                                        .overlay(RoundedRectangle(cornerRadius: 8, style: .continuous).stroke(Color.gray,lineWidth: 0.5))
                                        .padding([.bottom],5)
                                }else{
                                    Text("离线")
                                        .font(.system(size: 12, weight: Font.Weight.light, design: .rounded))
                                        .padding([.bottom],5)
                                    Circle()
                                        .foregroundColor(Color.gray)
                                        .frame(width: 8, height: 8, alignment: .leading)
                                        .overlay(RoundedRectangle(cornerRadius: 8, style: .continuous).stroke(Color.gray,lineWidth: 0.5))
                                        .padding([.bottom],5)
                                }
                                Spacer()
                            } else{
                                Text("有新消息")
                                    .font(.system(size: 12, weight: Font.Weight.light, design: .rounded))
                                    .foregroundColor(Color.red)
                                    .offset(x: 0, y: -5)
                                Image(systemName:"envelope.badge")
                                    .frame(width: 10, height: 10, alignment: .center)
                                    .foregroundColor(Color.red)
                                    .offset(x: 0, y: -6)
                            }
                        }
                    }
                    .frame(width: 80, height: 60)
                    .padding([.leading],70)
                    Spacer()
                    ZStack{
                        if battery > 0.2 {
                            Circle()
                                .stroke(lineWidth: 5.0)
                                .opacity(0.3)
                                .foregroundColor(Color.green)
                            Circle()
                                .trim(from: 0.0, to: CGFloat(self.battery))
                                .stroke(style: StrokeStyle(lineWidth: 5.0, lineCap: .round, lineJoin: .round))
                                .foregroundColor(Color.green)
                                .rotationEffect(Angle(degrees: 270.0))
                        } else{
                            Circle()
                                .stroke(lineWidth: 5.0)
                                .opacity(0.3)
                                .foregroundColor(Color.red)
                            Circle()
                                .trim(from: 0.0, to: CGFloat(self.battery))
                                .stroke(style: StrokeStyle(lineWidth: 5.0, lineCap: .round, lineJoin: .round))
                                .foregroundColor(Color.red)
                                .rotationEffect(Angle(degrees: 270.0))
                        }
                        Text(String(format:"%.0f",battery * 100))
                            .font(.system(size: 13, weight: .regular, design: .default))
                    }
                    .frame(width: 35, height: 35, alignment: .center)
                    .padding([.trailing],0)
                    .offset(x: -13, y: 0)
                }
                .padding(.top,15)
                Spacer()
                VStack(spacing:8){
                    HStack{
                        Image(systemName: "rectangle.and.pencil.and.ellipsis")
                        Text(signed)
                            .font(.system(size: 14, weight: Font.Weight.thin, design: .default))
                        Spacer()
                    }
                    .offset(y:HobbyType != "0" ? 0:-20)
                    if HobbyType != "0"{
                        HStack{
                            if Mood == 3{
                                Image("emoji_happy")
                                    .resizable()
                                    .frame(width: 17, height: 17)
                            }else if Mood == 2{
                                Image("emoji_dull")
                                    .resizable()
                                    .frame(width: 17, height: 17)
                            }else{
                                Image("emoji_sad")
                                    .resizable()
                                    .frame(width: 17, height: 17)
                            }
                            Text(HobbyType == "1" ? "最近在读《\(Hobby)》":"最近很喜欢《\(Hobby)》")
                                .font(.system(size: 14, weight: .thin, design: .default))
                            Spacer()
                        }
                        .padding(.bottom,10)
                    }
                }
                .padding(.bottom,10)
                .padding(.leading,15)
            }
            .frame(width: 260, height: 150, alignment: .center)
            .overlay(RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .stroke(Color.black,lineWidth:1.5).shadow(color: .gray, radius:1,x:-1,y:-1))
            .background(colorScheme == .light ? Color.white:Color.black)
            .cornerRadius(8)
            
            
        }
    }
}
