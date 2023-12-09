import SwiftUI
import Lottie

struct LottieView:UIViewRepresentable{
    let animationView = AnimationView()
    var lottieFile = ""
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView()
        let animation = Animation.named(lottieFile)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 1.0
        animationView.play(completion: {(complete:Bool) in
            
        })
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        NSLayoutConstraint.activate([animationView.heightAnchor.constraint(equalTo: view.heightAnchor),animationView.widthAnchor.constraint(equalTo: view.widthAnchor)])
        return view
    }
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
        
    }
}
