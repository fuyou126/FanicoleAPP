import SwiftUI

struct LoveView :View{
    @State var imageNumber:Int = 3
    @State var loading:Bool = false
    @State var image:[UIImage?] = [UIImage(systemName: "person"),UIImage(systemName: "person"),UIImage(systemName: "person")]
    @Environment(\.colorScheme) var colorScheme
    var body :some View{
        TabView{
            ForEach(1...imageNumber,id:\.self){index in
                VStack{
                    /*
                     if !loading{
                     Text("Wait")
                     .onTapGesture(perform: {loading = true})
                     }else{
                     ImageView(url:"http://124.222.102.194:8080/NicoleTest/Picture/Fanicole" + String(index) + ".jpg")
                     .cornerRadius(8)
                     .frame(width: 250, height: 250, alignment: .center)
                     }
                     */
                    Image(uiImage: image[index-1]!)
                        .resizable()
                        .cornerRadius(8)
                        .frame(width: 250, height: 250, alignment: .center)
                }
                .overlay(RoundedRectangle(cornerRadius: 8, style: .continuous).stroke(Color.white,lineWidth: 1.5))
                .shadow(radius: 10)
                .onAppear(perform: {
                    // 改用多线程实现
                    DispatchQueue.global().async {
                        for index in 1...imageNumber{
                            let url = URL(string: "http://124.222.102.194:8080/Picture/Fanicole" + String(index) + ".jpg")
                            let data = try! Data(contentsOf: url!)
                            image[index-1] = UIImage(data: data)
                        }
                    }
                    
                })
                .tabItem({})
            }
            /*
             VStack{
             Image("516")
             .resizable()
             .cornerRadius(8)
             .frame(width: 250, height: 250, alignment: .center)
             //Text("Nicole")
             }
             .overlay(RoundedRectangle(cornerRadius: 8, style: .continuous).stroke(Color.white,lineWidth: 1.5))
             .shadow(radius: 10)
             .tabItem({})
             VStack{
             Image("Pic_2")
             .resizable()
             .cornerRadius(8)
             .frame(width: 320, height: 240, alignment: .center)
             .rotationEffect(.degrees(90))
             }
             .overlay(RoundedRectangle(cornerRadius: 8, style: .continuous).stroke(Color.white,lineWidth: 1.5)
             .rotationEffect(.degrees(90)))
             .shadow(radius: 10)
             .tabItem({})
             VStack{
             Image("Pic_3")
             .resizable()
             .cornerRadius(8)
             .frame(width: 320 * 0.9, height: 240 * 0.9, alignment: .center)
             
             }
             .overlay(RoundedRectangle(cornerRadius: 8, style: .continuous).stroke(Color.white,lineWidth: 1.5))
             .shadow(radius: 10)
             .tabItem({})
             */
        }
        .tabViewStyle(.page)
        .background(colorScheme == .light ? Color.init(red: 242.0/256, green: 242.0/256, blue: 246.0/256) : .black)
    }
}
