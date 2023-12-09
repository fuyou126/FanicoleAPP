import SwiftUI
import Lottie

struct EmoAnimationView:UIViewRepresentable{
    let animationView = AnimationView()
    var lottieFile = ""
    var setFrame = false
    var startFrame:CGFloat = 0
    var endFrame:CGFloat = 0
    var animationSpeed = 1.0
    @Binding var lastEmo:Int
    func makeUIView(context: UIViewRepresentableContext<EmoAnimationView>) -> UIView {
        let view = UIView()
        let animation = Animation.named(lottieFile)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.animationSpeed = animationSpeed
        if setFrame{
            animationView.play(fromFrame: startFrame, toFrame: endFrame, loopMode: .playOnce, completion: {(complete:Bool) in
                lastEmo = 2
            })
        }
        else{animationView.play(completion: {(complete:Bool) in
            //withAnimation(.spring()){
                lastEmo = 2
            //}
        })
        }
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        NSLayoutConstraint.activate([animationView.heightAnchor.constraint(equalTo: view.heightAnchor),animationView.widthAnchor.constraint(equalTo: view.widthAnchor)])
        return view
    }
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<EmoAnimationView>) {
        
    }
}
