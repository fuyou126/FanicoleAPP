import SwiftUI

struct NotificationView:View{
    @Binding var message_icon:String
    @Binding var message_id:String
    @Binding var message_content:String
    @Binding var nowTime:String
    var body: some View{
        VStack {
            Spacer(minLength: 20)
            HStack {
                Image("Icon_" + message_icon)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .cornerRadius(25)
                VStack(alignment: .leading, spacing: 2) {
                    HStack {
                        Text(message_id)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                        Spacer()
                        Text(nowTime)
                            .font(.system(size: 12))
                            .foregroundColor(Color(red: 0.9, green: 0.9, blue: 0.9))
                    }
                    
                    Text(message_content)
                        .lineLimit(2)
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                }
            }
            .padding(15)
        }
        .frame(height: 110)
        .background(LinearGradient(gradient: .init(colors: [Color.mint,Color.teal]), startPoint: .topLeading, endPoint: .bottomTrailing))
    }
}
