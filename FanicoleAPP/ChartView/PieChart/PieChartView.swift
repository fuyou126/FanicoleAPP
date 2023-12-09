////
////  PieChartView.swift
////  ChartView
////
////  Created by András Samu on 2019. 06. 12..
////  Copyright © 2019. András Samu. All rights reserved.
////
//
//import SwiftUI
//
//public struct PieChartView : View {
//    @Environment(\.colorScheme) var colorScheme: ColorScheme
//    public var data: [Double]
//    public var title: String
//    public var legend: String?
//    public var style: ChartStyle
//    public var formSize:CGSize
//    public var dropShadow: Bool
//    public var valueSpecifier:String
//    public var moodText:[String] 
//    
//    @State private var currentIndex:Int = -1
//    @State private var showValue = false
//    @State private var currentValue: Double = 0 {
//        didSet{
//            if(oldValue != self.currentValue && self.showValue) {
//                HapticFeedback.playSelection()
//            }
//        }
//    }
//    
//    public init(data: [Double], title: String = "本周对话总结", legend: String? = nil, style: ChartStyle = Styles.pieChartStyleOne, form: CGSize? = .init(width: 260, height: 240), dropShadow: Bool? = true, valueSpecifier: String? = "%.1f"){
//        self.data = data
//        self.title = title
//        self.legend = legend
//        self.style = style
//        self.formSize = form!
//        if self.formSize == ChartForm.large {
//            self.formSize = ChartForm.extraLarge
//        }
//        self.dropShadow = dropShadow!
//        self.valueSpecifier = valueSpecifier!
//        self.moodText = ["感谢","愉快","中性","抱怨","愤怒"]
//    }
//    
//    public var body: some View {
//        ZStack{
//            Rectangle()
//                .fill(colorScheme == .light ? self.style.backgroundColor : .black)
//                .cornerRadius(20)
//                .shadow(color: self.style.dropShadowColor, radius: self.dropShadow ? 2 : 0)
//            VStack(alignment: .leading){
//                HStack{
//                    if(!showValue){
//                        Text(self.title)
//                            .font(.title2)
//                            .bold()
//                            .foregroundColor(colorScheme == .light ?  self.style.textColor : .white) 
//                    }else{
//                        HStack{
//                            //容易崩溃，改
//                            if currentIndex != -1{
//                                Text(moodText[currentIndex])
//                                    .font(.headline)
//                                    .foregroundColor(colorScheme == .light ? self.style.textColor : .white)
//                            }
//                            Text(": "+String(lround(currentValue)))
//                                .font(.headline)
//                                .foregroundColor(colorScheme == .light ? self.style.textColor : .white)
//                        }
//                    }
//                    Spacer()
//                    /*
//                     Image(systemName: "chart.pie.fill")
//                     .imageScale(.large)
//                     .foregroundColor(self.style.legendTextColor)
//                     */
//                }.padding()
//                PieChartRow(data: data, backgroundColor:colorScheme == .light ? self.style.backgroundColor : .black, accentColor:colorScheme == .light ? self.style.accentColor : .indigo, showValue: $showValue, currentValue: $currentValue,currentIndex:$currentIndex)
//                    .foregroundColor(self.style.accentColor).padding(self.legend != nil ? 0 : 12).offset(y:self.legend != nil ? 0 : -10)
//                if(self.legend != nil) {
//                    Text(self.legend!)
//                        .font(.headline)
//                        .foregroundColor(self.style.legendTextColor)
//                        .padding()
//                }
//                
//            }
//        }.frame(width: self.formSize.width, height: self.formSize.height)
//    }
//}
