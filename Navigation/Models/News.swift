//
//  News.swift
//  Navigation
//
//  Created by Pavel on 08.04.2022.
//

import Foundation

struct News: Decodable {

    struct Post: Decodable {
        let author, description, image: String
        var likes: Int
        var views: Int


        enum CodingKeys: String, CodingKey {
            case author, description, image, likes, views
        }
    }

    let posts: [Post]

}
