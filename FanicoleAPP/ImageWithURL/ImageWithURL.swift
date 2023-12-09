import SwiftUI

struct Image_View:View{
    var image:UIImage
    init(url:String){
        let url_ = URL(string: url)
        let data = try! Data(contentsOf:url_!)
        self.image = UIImage(data: data) ?? UIImage(systemName: "person")!
    }
    var body: some View{
        Image(uiImage: image)
            .resizable()
    }
}
struct ImageWithURL :View{
    @State var imageLoader:ImageLoaderAndCache
    init(_ url:String){
        imageLoader = ImageLoaderAndCache(imageURL: url)
    }
    var body: some View{
        Image(uiImage: UIImage(data: self.imageLoader.imageData) ?? UIImage(systemName: "person")!)
            .resizable()
            .clipped()
    }
}
class ImageLoaderAndCache:ObservableObject{
    @State var imageData = Data()
    init(imageURL:String){
        let cache = URLCache.shared
        let request = URLRequest(url:URL(string:imageURL)!,cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad,timeoutInterval: 60.0)
        if let data = cache.cachedResponse(for: request)?.data{
            print("got image from cache")
            self.imageData = data
        } else {
            URLSession.shared.dataTask(with:request,completionHandler:{(data,response,error) in
                if let data = data, let response = response{
                    let cachedData = CachedURLResponse(response:response,data:data)
                    cache.storeCachedResponse(cachedData,for:request)
                    DispatchQueue.main.async{
                        print("downloaded from internet")
                        self.imageData = data
                    }
                }
            }).resume()
        }
    }
}
