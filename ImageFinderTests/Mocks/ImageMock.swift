//
//  ImageMock.swift
//  ImageFinderTests
//
//  Created by Andrea Altea on 05/12/2018.
//  Copyright © 2018 Andrea Altea. All rights reserved.
//

import Foundation
@testable import ImageFinder

class ImageMock {
    
    static var image: Image {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try! decoder.decode(Image.self, from: ImageMock.imageJson.data(using: .utf8)!)
    }

    static var fullImage: FullImage {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try! decoder.decode(FullImage.self, from: ImageMock.fullImageJson.data(using: .utf8)!)
    }

    private static let imageJson = "{\"id\":\"8UcNYpynFLU\",\"created_at\":\"2018-05-03T08:39:51-04:00\",\"updated_at\":\"2018-08-28T21:01:41-04:00\",\"width\":4125,\"height\":2768,\"color\":\"#232F37\",\"description\":\"assorted-color balloons on air\",\"urls\":{\"raw\":\"https://images.unsplash.com/photo-1525351159099-81893194469e?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjQ0MTc2fQ&s=a2865aea7394e733a46042fc0c8cc1d6\",\"full\":\"https://images.unsplash.com/photo-1525351159099-81893194469e?ixlib=rb-0.3.5&q=85&fm=jpg&crop=entropy&cs=srgb&ixid=eyJhcHBfaWQiOjQ0MTc2fQ&s=8bfe4fa5f5fd73698e3544b4e0191c01\",\"regular\":\"https://images.unsplash.com/photo-1525351159099-81893194469e?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjQ0MTc2fQ&s=4ab710aec6d38b1dbb595ec26f24aded\",\"small\":\"https://images.unsplash.com/photo-1525351159099-81893194469e?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=400&fit=max&ixid=eyJhcHBfaWQiOjQ0MTc2fQ&s=5c35f0ae74ccbf1ed963ffc4bb46f184\",\"thumb\":\"https://images.unsplash.com/photo-1525351159099-81893194469e?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=200&fit=max&ixid=eyJhcHBfaWQiOjQ0MTc2fQ&s=70e377606b66fd937001b878f832a1cf\"},\"links\":{\"self\":\"https://api.unsplash.com/photos/8UcNYpynFLU\",\"html\":\"https://unsplash.com/photos/8UcNYpynFLU\",\"download\":\"https://unsplash.com/photos/8UcNYpynFLU/download\",\"download_location\":\"https://api.unsplash.com/photos/8UcNYpynFLU/download\"},\"categories\":[],\"sponsored\":false,\"sponsored_by\":null,\"sponsored_impressions_id\":null,\"likes\":186,\"liked_by_user\":false,\"current_user_collections\":[],\"slug\":null,\"user\":{\"id\":\"HFaKI6keLfo\",\"updated_at\":\"2018-11-13T09:00:58-05:00\",\"username\":\"sagarp7\",\"name\":\"Sagar Patil\",\"first_name\":\"Sagar\",\"last_name\":\"Patil\",\"twitter_username\":null,\"portfolio_url\":\"https://sagarpatil.carrd.co\",\"bio\":null,\"location\":\"Mumbai\",\"links\":{\"self\":\"https://api.unsplash.com/users/sagarp7\",\"html\":\"https://unsplash.com/@sagarp7\",\"photos\":\"https://api.unsplash.com/users/sagarp7/photos\",\"likes\":\"https://api.unsplash.com/users/sagarp7/likes\",\"portfolio\":\"https://api.unsplash.com/users/sagarp7/portfolio\",\"following\":\"https://api.unsplash.com/users/sagarp7/following\",\"followers\":\"https://api.unsplash.com/users/sagarp7/followers\"},\"profile_image\":{\"small\":\"https://images.unsplash.com/profile-1524123520211-6021079cf6dc?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=32&w=32&s=3001ea5d9bbd31763c7a5a3e1cddb1ad\",\"medium\":\"https://images.unsplash.com/profile-1524123520211-6021079cf6dc?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=64&w=64&s=50f94c2c1520644f69049b8cf20938c6\",\"large\":\"https://images.unsplash.com/profile-1524123520211-6021079cf6dc?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=128&w=128&s=e84facbecb54bfbc14c69d2185034b15\"},\"instagram_username\":\"navigation_charlie\",\"total_collections\":0,\"total_likes\":0,\"total_photos\":17,\"accepted_tos\":false},\"tags\":[{\"title\":\"floating\"},{\"title\":\"sky\"},{\"title\":\"bright\"},{\"title\":\"pink\"},{\"title\":\"yellow\"},{\"title\":\"orange\"},{\"title\":\"blue\"},{\"title\":\"celebrate\"},{\"title\":\"party\"},{\"title\":\"closeup\"}],\"photo_tags\":[{\"title\":\"floating\"},{\"title\":\"sky\"},{\"title\":\"bright\"},{\"title\":\"pink\"},{\"title\":\"yellow\"}]}"
    
    private static let fullImageJson = "{\"id\":\"8UcNYpynFLU\",\"created_at\":\"2018-05-03T08:39:51-04:00\",\"updated_at\":\"2018-08-28T21:01:41-04:00\",\"width\":4125,\"height\":2768,\"color\":\"#232F37\",\"description\":\"assorted-color balloons on air\",\"urls\":{\"raw\":\"https://images.unsplash.com/photo-1525351159099-81893194469e?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjQ0MTc2fQ&s=a2865aea7394e733a46042fc0c8cc1d6\",\"full\":\"https://images.unsplash.com/photo-1525351159099-81893194469e?ixlib=rb-0.3.5&q=85&fm=jpg&crop=entropy&cs=srgb&ixid=eyJhcHBfaWQiOjQ0MTc2fQ&s=8bfe4fa5f5fd73698e3544b4e0191c01\",\"regular\":\"https://images.unsplash.com/photo-1525351159099-81893194469e?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjQ0MTc2fQ&s=4ab710aec6d38b1dbb595ec26f24aded\",\"small\":\"https://images.unsplash.com/photo-1525351159099-81893194469e?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=400&fit=max&ixid=eyJhcHBfaWQiOjQ0MTc2fQ&s=5c35f0ae74ccbf1ed963ffc4bb46f184\",\"thumb\":\"https://images.unsplash.com/photo-1525351159099-81893194469e?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=200&fit=max&ixid=eyJhcHBfaWQiOjQ0MTc2fQ&s=70e377606b66fd937001b878f832a1cf\"},\"links\":{\"self\":\"https://api.unsplash.com/photos/8UcNYpynFLU\",\"html\":\"https://unsplash.com/photos/8UcNYpynFLU\",\"download\":\"https://unsplash.com/photos/8UcNYpynFLU/download\",\"download_location\":\"https://api.unsplash.com/photos/8UcNYpynFLU/download\"},\"categories\":[],\"sponsored\":false,\"sponsored_by\":null,\"sponsored_impressions_id\":null,\"likes\":186,\"liked_by_user\":false,\"current_user_collections\":[],\"slug\":null,\"user\":{\"id\":\"HFaKI6keLfo\",\"updated_at\":\"2018-11-13T09:00:58-05:00\",\"username\":\"sagarp7\",\"name\":\"Sagar Patil\",\"first_name\":\"Sagar\",\"last_name\":\"Patil\",\"twitter_username\":null,\"portfolio_url\":\"https://sagarpatil.carrd.co\",\"bio\":null,\"location\":\"Mumbai\",\"links\":{\"self\":\"https://api.unsplash.com/users/sagarp7\",\"html\":\"https://unsplash.com/@sagarp7\",\"photos\":\"https://api.unsplash.com/users/sagarp7/photos\",\"likes\":\"https://api.unsplash.com/users/sagarp7/likes\",\"portfolio\":\"https://api.unsplash.com/users/sagarp7/portfolio\",\"following\":\"https://api.unsplash.com/users/sagarp7/following\",\"followers\":\"https://api.unsplash.com/users/sagarp7/followers\"},\"profile_image\":{\"small\":\"https://images.unsplash.com/profile-1524123520211-6021079cf6dc?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=32&w=32&s=3001ea5d9bbd31763c7a5a3e1cddb1ad\",\"medium\":\"https://images.unsplash.com/profile-1524123520211-6021079cf6dc?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=64&w=64&s=50f94c2c1520644f69049b8cf20938c6\",\"large\":\"https://images.unsplash.com/profile-1524123520211-6021079cf6dc?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=128&w=128&s=e84facbecb54bfbc14c69d2185034b15\"},\"instagram_username\":\"navigation_charlie\",\"total_collections\":0,\"total_likes\":0,\"total_photos\":17,\"accepted_tos\":false},\"exif\":{\"make\":\"NIKON CORPORATION\",\"model\":\"NIKON D5100\",\"exposure_time\":\"1/320\",\"aperture\":\"9.0\",\"focal_length\":\"80.0\",\"iso\":100},\"location\":{\"title\":\"Girgaon, Mumbai, India\",\"name\":\"Girgaon\",\"city\":\"Mumbai\",\"country\":\"India\",\"position\":{\"latitude\":18.9572287,\"longitude\":72.8196689}},\"views\":1191650,\"downloads\":11797}"
}