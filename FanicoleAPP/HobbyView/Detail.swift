import SwiftUI
import Moya
import SwiftyJSON

struct Detail:View{
    @Environment(\.colorScheme) var colorScheme
    var tool:Tools
    @Binding var show:Bool
    @State var isLike:Bool = false
    @State var isReading:Bool = false
    @State var showTopFloater:Bool = false
    var name:Namespace.ID
    @Binding var showFanicole:Bool
    var isBook:Bool
    var body: some View{
        VStack{
            HStack(alignment: .top, spacing: 12){
                Button(action: {
                    let provider = MoyaProvider<MyService>()
                    provider.request(.SetHobby(code: "SetHobby", ID: AccountState.acconutName, Book: tool.name, reading: isReading ? "1":"0", love: isLike ? "1":"0")){result in
                    }
                    withAnimation(.spring()){
                        show.toggle()
                    }
                    showFanicole = true
                }){
                    Image(systemName: "chevron.left")
                        .font(.system(size: 30,weight: .bold))
                        .foregroundColor(colorScheme == .light ?  .black : .white)
                        .padding()
                }
                Spacer(minLength: 0)
                Image(tool.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .matchedGeometryEffect(id: tool.image, in: name)
            }
            .padding(.leading,20)
            .padding(.top,80)
            .padding([.trailing])
            
            HStack{
                VStack(alignment: .leading, spacing: 0){
                    Text(tool.name)
                        .font(.system(size: 30,weight: .bold))
                        .foregroundColor(colorScheme == .light ? .black : .white)
                    Text(isBook ? "作者："+tool.subtitle:"导演："+tool.subtitle)
                        .font(.system(size: 20))
                        .foregroundColor(colorScheme == .light ? .black :.white)
                }
                Spacer()
            }
            .padding(.horizontal,20)
            
            ScrollView(.vertical,showsIndicators: false){
                VStack{
                    Text(tool.content)
                        .font(.system(size: 14))
                        .foregroundColor(colorScheme == .light ?  .black.opacity(0.7): .white.opacity(0.7))
                        .multilineTextAlignment(.leading)
                        .lineSpacing(10)
                        .padding(.top)
                }
                .padding(.horizontal,20)
            }
            HStack(spacing:isReading ? 60 : 65){
                if isBook{
                Button(action:{
                    isReading.toggle()
                    if isReading{
                        showTopFloater = true
                        showFanicole = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                            showFanicole = true
                        })
                    }
                }){
                    if !isReading{
                        Image(systemName: "text.book.closed")
                            .resizable()
                            .frame(width: 25, height: 28)
                        //.font(.system(size: 25))                     
                            .foregroundColor(.orange)
                            .padding()
                            .background(colorScheme == .light ? .white:.black)
                            .clipShape(Circle())
                            .shadow(radius: 3)
                    }else{
                        Image(systemName: "book.fill")
                            .resizable()
                            .frame(width:30, height: 25)
                        //.font(.system(size: 20))
                            .foregroundColor(.orange)
                            .padding()
                            .background(colorScheme == .light ? .white:.black)
                            .clipShape(Circle())
                            .shadow(radius: 3)
                    }
                }
                    /*
                     
                     Text("在读")
                     .fontWeight(.bold)
                     .foregroundColor(.white)
                     .padding(.vertical)
                     .frame(width: 200)
                     .frame(width: 100, height: 30)
                     .frame(width: UIScreen.main.bounds.width - 120)
                     .background(Color.orange)
                     .clipShape(Capsule())
                     */
                }
                Button(action:{
                    isLike.toggle()
                }){
                    if isLike {
                        Image(systemName: "suit.heart.fill")
                            .font(.title)
                            .foregroundColor(Color.orange)
                            .padding()
                            .background(colorScheme == .light ? Color.white:.black)
                            .clipShape(Circle())
                            .shadow(radius: 3)
                    }else{
                        Image(systemName: "suit.heart")
                            .font(.title)
                            .foregroundColor(Color.orange)
                            .padding()
                            .background(colorScheme == .light ? Color.white:.black)
                            .clipShape(Circle())
                            .shadow(radius: 3)
                    }
                }
            }
            .padding(.top,25)
            .padding(.bottom)
        }
        .background(colorScheme == .light ? .white : .black)
        .onAppear(perform: {
            let provider = MoyaProvider<MyService>()
            provider.request(.GetHobby(code: "GetHobby", ID: AccountState.acconutName, Book: tool.name)){result in
                switch result{
                case let .success(moyaResponse):
                    let data = moyaResponse.data
                    do{
                        let json = try JSON(data:data)
                        if json["code"].int! == 1{
                            isReading = (json["reading"].int! == 1)
                            isLike = (json["love"].int! == 1)
                        }
                    }catch{}
                case let .failure(error):
                    print(error)
                }
            }
        })
        .popup(isPresented: $showTopFloater, type: .floater(), position: .top, animation: .spring(), autohideIn: 2) {
            TopFloater()
        }
    }
}

struct TopFloater:View{
    var body: some View{
        HStack(spacing: 10) {
            Image(systemName: "book")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 20, height: 20)
                .foregroundColor(.white)
            
            VStack(spacing: 8) {
                Text("已加入书单")
                    .font(.system(size: 12))
                    .foregroundColor(.white)
                /*
                HStack(spacing: 0) {
                    Color(red: 1, green: 112/255, blue: 59/255)
                        .frame(width: 30, height: 5)
                    Color(red: 1, green: 1, blue: 1)
                        .frame(width: 70, height: 5)
                }
                .cornerRadius(2.5)
                 */
            }
        }
        .frame(width: 200, height: 60)
        .background(Color.init(red: 28.0/256, green: 28.0/256, blue: 29.0/256))
        .cornerRadius(30.0)
    }
}
