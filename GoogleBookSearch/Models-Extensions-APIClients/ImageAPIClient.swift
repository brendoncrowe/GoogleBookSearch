import UIKit


// MARK: This client is help fetch the image for both the cell image and the detail view image

struct Image {
    static func getImage(from urlStr: String,
                  completion: @escaping (Result<UIImage, NetworkError>) -> ()) {
        NetWorkHelper.shared.performDataTask(with: urlStr) { (result) in
            switch result {
            case .failure(let error):
                completion(.failure(.networkClientError(error)))
            case .success(let data):
                guard let image = UIImage(data: data) else {
                    completion(.failure(.noImage))
                    return
                }
                completion(.success(image))
            }
        }
    }
}
