import SwiftUI
import Moya
import SwiftyJSON

struct HobbyView:View{
    @Environment(\.colorScheme) var colorScheme
    @State var design_tools = HobbyContent.picture_tools
    @State var swiped = 0
    @Namespace var name
    @State var selected:Tools = HobbyContent.picture_tools[0]
    @State var show = false
    @State var chooseHobbyType:Int = 0
    @State var isSad:Bool = false
    @Binding var showFanicole:Bool
    let HobbyType:[String] = ["美图","书籍","影视"]
    
    var body:some View{
        ZStack{
            VStack{
                HStack{
                    VStack(alignment:.leading,spacing: 0){
                        Text("休闲一刻")
                            .font(.system(size: 35))
                            .fontWeight(.bold)
                            .foregroundColor(colorScheme == .light ? .black : .white)
                        HStack(spacing:15){
                            Menu{
                                Button(HobbyType[0]){
                                    if chooseHobbyType != 0{
                                        chooseHobbyType = 0
                                        swiped = 0
                                        if !isSad{
                                            selected = HobbyContent.picture_tools[0]
                                            design_tools = HobbyContent.picture_tools
                                        }else{
                                            selected = HobbyContent.picture_tools_sad[0]
                                            design_tools = HobbyContent.picture_tools_sad
                                        }
                                    }
                                }
                                Button(HobbyType[1]){
                                    if chooseHobbyType != 1{
                                        chooseHobbyType = 1
                                        swiped = 0
                                        selected = HobbyContent.book_tools[0]
                                        design_tools = HobbyContent.book_tools
                                    }
                                }
                                Button(HobbyType[2]){
                                    if chooseHobbyType != 2{
                                        chooseHobbyType = 2
                                        swiped = 0
                                        selected = HobbyContent.film_tools[0]
                                        design_tools = HobbyContent.film_tools
                                    }
                                }
                            }label:{
                                Text(HobbyType[chooseHobbyType])
                                    .font(.system(size: 30))
                                    .foregroundColor(colorScheme == .light ?  Color.black.opacity(0.5) : Color.white.opacity(0.5))
                                Image(systemName: "chevron.down")
                                    .font(.system(size: 30))
                                    .foregroundColor(.orange)
                            }
                        }
                    }
                    .padding([.top],50)
                    Spacer(minLength: 0)
                }
                .padding()
                GeometryReader{reader in
                    ZStack{
                        ForEach(design_tools.reversed()){ tool in
                            if chooseHobbyType == 0{
                                PictureCard(tool: tool, reader: reader, swiped: $swiped, show: $show, selected: $selected, name: name)
                                    .offset(x:tool.offset)
                                    .rotationEffect(.init(degrees: getRoation(offset: tool.offset)))
                                    .gesture(DragGesture().onChanged({(value) in
                                        withAnimation{
                                            if value.translation.width > 0{
                                                design_tools[tool.id].offset = value.translation.width
                                            }
                                        }
                                    }).onEnded({(value) in
                                        withAnimation{
                                            if value.translation.width > 150{
                                                design_tools[tool.id].offset = 1000
                                                swiped = tool.id + 1
                                                restoreCard(id: tool.id)
                                            }else{
                                                design_tools[tool.id].offset = 0
                                            }
                                        }
                                    }))
                            }else{
                                
                                CardView(tool: tool, reader: reader, swiped: $swiped,show: $show,selected: $selected,name:name)
                                    .offset(x:tool.offset)
                                    .rotationEffect(.init(degrees: getRoation(offset: tool.offset)))
                                    .gesture(DragGesture().onChanged({(value) in
                                        withAnimation{
                                            if value.translation.width > 0{
                                                design_tools[tool.id].offset = value.translation.width
                                            }
                                        }
                                    }).onEnded({(value) in
                                        withAnimation{
                                            if value.translation.width > 150{
                                                design_tools[tool.id].offset = 1000
                                                swiped = tool.id + 1
                                                restoreCard(id: tool.id)
                                            }else{
                                                design_tools[tool.id].offset = 0
                                            }
                                        }
                                    }))
                            }
                        }
                    }
                    .offset(y:-50)
                }
            }
            if show{
                Detail(tool: selected, show: $show, name: name,showFanicole:$showFanicole,isBook:(chooseHobbyType == 1))
                
            }
        }
        .background(colorScheme == .light ? Color.init(red: 242.0/256, green: 242.0/256, blue: 246.0/256) : .black)
        .onAppear { 
            let provider = MoyaProvider<MyService>()
            provider.request(.GetMood(code: "GetMood", ID: AccountState.acconutName)){result in
                switch result{
                case let .success(moyaResponse):
                    let data = moyaResponse.data
                    do{
                        let json = try JSON(data:data)
                        if json["code"].int! == 1{
                            var moodSum = 0
                            moodSum += json["day7"][0].int!
                            moodSum += 2 * json["day7"][1].int!
                            moodSum -= json["day7"][3].int!
                            moodSum -= 2 * json["day7"][4].int!
                            
                            if moodSum < 0 && !isSad{
                                isSad = true
                                swiped = 0
                                design_tools = HobbyContent.picture_tools_sad
                                selected = HobbyContent.picture_tools_sad[0]
                            }
                        }
                    }catch{}
                case let .failure(error):
                    print(error)
                }
            }
        }
        //.background(LinearGradient(gradient: .init(colors: [.purple,.cyan,.orange]), startPoint: .top, endPoint: .bottom)
        //.edgesIgnoringSafeArea(.all)
        //.opacity(show ? 0 : 1)
        //)
    }
    func restoreCard(id:Int){
        var currentCard = design_tools[id]
        currentCard.id = design_tools.count
        design_tools.append(currentCard)
        DispatchQueue.main.asyncAfter(deadline:.now()+0.3){
            withAnimation{
                design_tools[design_tools.count - 1].offset = 0
            }
        }
    }
    func getRoation(offset:CGFloat) -> Double{
        let value = offset / 150
        let angle:CGFloat = 5
        let degree = Double(value * angle)
        return degree
    }
}
