import SwiftUI

struct MyFriend:View{
    @Binding var image:String
    @Binding var name:String
    @Binding var online:Bool
    var body: some View{
        HStack{
            Image("Icon_"+image)
                .resizable()
                .cornerRadius(1000)
                .frame(width: 30, height: 30, alignment: .center)
                .overlay(RoundedRectangle(cornerRadius: 1000, style: .continuous).stroke(Color.gray,lineWidth: 0.5))
            Text(name)
                .font(.system(size: 15, weight: Font.Weight.light, design: .rounded))
                .padding([.leading])
            Spacer()
            if online{
                Text("在线")
                    .font(.system(size: 15, weight: Font.Weight.light, design: .rounded))
                Circle()
                    .foregroundColor(Color.green)
                    .frame(width: 10, height: 10, alignment: .center)
                    .overlay(RoundedRectangle(cornerRadius: 8, style: .continuous).stroke(Color.gray,lineWidth: 0.5))
            }else{
                Text("离线")
                    .font(.system(size: 15, weight: Font.Weight.light, design: .rounded))
                Circle()
                    .foregroundColor(Color.gray)
                    .frame(width: 10, height: 10, alignment: .center)
                    .overlay(RoundedRectangle(cornerRadius: 8, style: .continuous).stroke(Color.gray,lineWidth: 0.5))
            }
        }
    }
}
