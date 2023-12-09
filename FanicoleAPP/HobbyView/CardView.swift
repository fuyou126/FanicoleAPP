import SwiftUI

struct CardView:View{
    @Environment(\.colorScheme) var colorScheme
    var tool:Tools
    var reader:GeometryProxy
    @Binding var swiped:Int
    @Binding var show:Bool
    @Binding var selected:Tools
    var name:Namespace.ID
    var body: some View{
        VStack{
            Spacer(minLength: 0)
            ZStack(alignment:Alignment(horizontal:.trailing,vertical:.bottom),content:{
                VStack{
                    Image("\(tool.image)")
                        .resizable()
                        .aspectRatio(contentMode:.fit)
                        .matchedGeometryEffect(id: tool.image, in: name)
                        .padding(.top)
                        .padding(.horizontal,25)
                    HStack{
                        VStack(alignment: .leading, spacing: 12){
                            Text("\(tool.name)")
                                .font(tool.name.count <= 6 ? .system(size: 25) : .system(size: 22))
                                .fontWeight(.bold)
                                .foregroundColor(colorScheme == .light ? .black : .white)
                            Text("\(tool.subtitle)")
                                .font(tool.subtitle.count <= 10 ?  .system(size: 20):.system(size: 15.5)) 
                                .foregroundColor(colorScheme == .light ? .black : .white)
                            Button(action:{
                                withAnimation(.spring()){
                                    selected = tool
                                    show.toggle()
                                }
                            }){
                                Text("查看更多 >")
                                    .font(.system(size: 20))
                                    .fontWeight(.bold)
                                    .foregroundColor(.orange)
                            }
                            .padding(.top)
                        }
                        Spacer(minLength: 0)
                    }
                    .padding(.horizontal,30)
                    .padding(.bottom,15)
                    .padding(.top,25)
                }
            })
            //.frame(width: 200, height: 2000)
                .frame(height: reader.frame(in: .global).height - 120)
                .padding(.vertical,10)
                .background(colorScheme == .light ? .white : Color.init(red: 28.0/256, green: 28.0/256, blue: 29.0/256))
                .cornerRadius(25)
                .padding(.horizontal,30 + (CGFloat(tool.id - swiped) * 10))
                .offset(y: tool.id - swiped <= 2 ? CGFloat(tool.id - swiped) * 25 : 50)
                .shadow(color: .black.opacity(0.12), radius: 5, x: 0, y: 5)
            Spacer(minLength: 0)
        }
        .contentShape(Rectangle())
    }
}
