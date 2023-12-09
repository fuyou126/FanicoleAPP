import SwiftUI

struct MessageContentView:View{
    @Binding var image:String
    @Binding var isMyWord:Bool
    @Binding var Word:String
    @Environment(\.colorScheme) var colorScheme
    var body: some View{
        HStack{
            if !isMyWord{
                Image("Icon_"+image)
                    .resizable()
                    .cornerRadius(8)
                    .frame(width: 35, height: 35, alignment: .center)
                    .overlay(RoundedRectangle(cornerRadius: 8, style: .continuous).stroke(Color.white,lineWidth: 1.2))
                    .padding(EdgeInsets.init(top: 0, leading: 20, bottom: 0, trailing: 0))
                Text(Word)
                    .font(.system(size: 16, weight: .regular, design: .default))
                    .frame()
                    .padding(EdgeInsets.init(top: 6, leading: 6, bottom: 6, trailing: 6))
                    .overlay(RoundedRectangle(cornerRadius: 8, style: .continuous).stroke(colorScheme == .light ? Color.black:Color.white,lineWidth: 0.8))
                Spacer()
            }else{
                Spacer()
                Text(Word)
                    .font(.system(size: 16, weight: .regular, design: .default))
                    .frame()
                    .padding(EdgeInsets.init(top: 6, leading: 6, bottom: 6, trailing: 6))
                    .overlay(RoundedRectangle(cornerRadius: 8, style: .continuous).stroke(colorScheme == .light ?  Color.black:Color.white,lineWidth: 0.8))
                Image("Icon_"+image)
                    .resizable()
                    .cornerRadius(8)
                    .frame(width: 35, height: 35, alignment: .center)
                    .overlay(RoundedRectangle(cornerRadius: 8, style: .continuous).stroke(Color.white,lineWidth: 1.2))
                    .padding(EdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 20))
            }
        }
        //.background(Color.blue)
    }
}
