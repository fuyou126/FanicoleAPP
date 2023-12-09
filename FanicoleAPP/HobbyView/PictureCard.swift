import SwiftUI


struct PictureCard:View{
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
                    Image(tool.image)
                        .resizable()
                    //.scaledToFit()
                        .frame(height: 536)
                    //.scaledToFit()
                    //.frame(height: reader.frame(in: .global).height-100)
                }
            })    
            .frame(height: reader.frame(in: .global).height - 67)
                .padding(.vertical,0)
                .background(colorScheme == .light ? .white : Color.init(red: 28.0/256, green: 28.0/256, blue: 29.0/256))
                .cornerRadius(25)
                .padding(.horizontal,30 + (CGFloat(tool.id - swiped) * 10 + 10))
                .offset(y: tool.id - swiped <= 2 ? CGFloat(tool.id - swiped) * 25 : 50)
                .shadow(color: .black.opacity(0.12), radius: 5, x: 0, y: 5)
            //Spacer(minLength: 0)
        }
        .contentShape(Rectangle())
        .padding(.bottom,25)
    }
}

