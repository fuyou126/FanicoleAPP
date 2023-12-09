import SwiftUI
import Moya
import SwiftyJSON

struct ReportView:View{
    @Binding var isReportAlert:Bool
    @State var content:Int = 0
    @State var ReportType:[String] = ["违法违规","人身攻击","色情或低俗内容","赌博诈骗","侵犯隐私","垃圾广告","恶意刷屏","个人信息存在违规内容"]
    @State var isAlert = false
    @Binding var YourID:String
    @Environment(\.colorScheme) var colorScheme
    var body: some View{
        VStack{
            HStack{
                Spacer()
                Button(action:{
                    isReportAlert = false
                }){
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .foregroundColor(Color.red)
                        .frame(width: 20, height: 20, alignment: .center)
                        .padding()
                }
            }
            Text("选择举报内容")
                .font(.system(size: 17, weight: .regular, design: .default))
                .padding([.bottom])
            Text("管理员会在24h内处理请求")
            Picker(selection: $content, label: Text("")) {
                ForEach(0..<ReportType.count,id:\.self){index in
                    Text(ReportType[index])
                }
            }
            .pickerStyle(.menu)
            /*
            TextField("           举报内容", text: $content)
                .frame(width: 150, height: 30, alignment: .center)
                .overlay(RoundedRectangle(cornerRadius: 8, style: .continuous).stroke(Color.black,lineWidth: 1.0))
             */
            Button(action:{
                let provider = MoyaProvider<MyService>()
                provider.request(.Report(code: "Report", YourID: YourID, ID: AccountState.acconutName, Content: ReportType[content])){result in
                    switch result{
                    case let .success(moyaResponse):
                        let data = moyaResponse.data
                        do{
                            let json = try JSON(data:data)
                            if json["code"].int! == 1 {
                                isAlert = true
                            }
                        }catch{
                        }
                    case let .failure(error):
                        print("\(error)")
                    }
                }
            }){
                Image(systemName: "icloud.and.arrow.up")
                    .resizable()
                    .foregroundColor(Color.green)
                    .frame(width: 30, height: 30, alignment: .center)
            }
            .padding()
            Spacer()
        }
        .frame(width: 200, height: 250, alignment: .center)
        .cornerRadius(8)
        .background(colorScheme == .light ? Color.white:Color.black)
        .overlay(RoundedRectangle(cornerRadius: 8, style: .continuous).stroke(colorScheme == .light ? Color.black:Color.white,lineWidth: 1.2))
        .alert(isPresented:$isAlert){()-> Alert in Alert(title:Text("提交成功"))}
        
    }
}
