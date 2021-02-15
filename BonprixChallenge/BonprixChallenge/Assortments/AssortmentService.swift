//
//  AssortmentService.swift
//  BonprixChallenge
//
//  Created by Sandro Wehrhahn on 08.02.21.
//


import Foundation


public class AssortmentService {
    
    public static let shared = AssortmentService()
    
    private let header: [String: String] = ["x-api-key": "N8Nx0OwOvo1iuN2ZkFHZlyVKBVgoIcy4tUHMppO5"]
    private let baseURL = "https://codechallenge.mobilelab.io/v1/bonprix/navigation"
    private let decoder = JSONDecoder()
    
    public enum AssortmentServiceError: Error {
        case failedToGetAssortments
        case invalidURL
        case failedToDecodeModels(Error)
    }
    
    public enum AssortmentImageError: Error {
        case failedToGetImageData
    }
    
}

public extension AssortmentService {
    
    typealias AssortmentResult = (Result<[AssortmentModel], AssortmentServiceError>) -> Void
    typealias AssortmentImageResult = (Result<Data, AssortmentImageError>) -> Void
    
    func getAssortments(completion: @escaping AssortmentResult) {
        guard let url = URL(string: baseURL) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = header
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(.failedToGetAssortments))
                return
            }
            
            do {
                let assortments = try self.getAssortmentsFrom(data: data)
                completion(.success(assortments))
            } catch {
                completion(.failure(.failedToDecodeModels(error)))
            }
        }.resume()
    }
    
    func getAssortmentsFrom(data: Data) throws -> [AssortmentModel] {
        // AssortmentListModel is only used for decoding the nested list
        let assortmentList = try self.decoder.decode(AssortmentListModel.self, from: data)
        return assortmentList.categories
    }

    func getImageFrom(assortment: AssortmentModel, completion: @escaping AssortmentImageResult) {
        guard
            let imageURL = assortment.image,
            let url = URL(string: imageURL)
        else {
            completion(.failure(.failedToGetImageData))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let imageData = data
            else {
                completion(.failure(.failedToGetImageData))
                return
            }
            completion(.success(imageData))
        }.resume()
    }
    
}
