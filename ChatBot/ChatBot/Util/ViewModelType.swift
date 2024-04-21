//
//  ViewModelType.swift
//  ChatBot
//
//  Created by nayeon  on 4/15/24.
//

protocol ViewModelType {

    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}
