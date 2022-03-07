//
//  CaseService.swift
//  Cases
//
//  Created by Johan Torell on 2021-02-08.
//

import Foundation

// protocol a type exactly as the graphql type with the values you want
public protocol Case {
    var id: String? { get }
    var title: String? { get }
    var desc: String? { get }
}

public protocol CaseServiceProtocol {
    func getCases(resultHandler: @escaping (Result<[Case], Error>) -> Void)
    func createCase(title: String, desc: String, resultHandler: @escaping (Result<Case, Error>) -> Void)
}
