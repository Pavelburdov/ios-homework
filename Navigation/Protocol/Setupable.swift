//
//  Setupable.swift
//  Navigation
//
//  Created by Pavel on 08.04.2022.
//

import Foundation

protocol ViewModelProtocol {}

protocol Setupable {
    func setup(with viewModel: ViewModelProtocol)
}
