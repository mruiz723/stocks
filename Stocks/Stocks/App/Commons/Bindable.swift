//
//  Bindable.swift
//  Stocks
//
//  Created by Marlon David Ruiz Arroyave on 17/10/21.
//

import Foundation

/// This class allows us to implement a data binding mechanism
/// (Connection between UI and Business logic (data changes))
class Bindable<T> {

    // MARK: - Properties

    typealias Listener = (T) -> Void

    /// A listener property is a closure that recieves a new value, and return nil
    private var listener: Listener?

    /// Contain the current value and in its didSet property observer calls listener closure passing the value
    var value: T {
        didSet {
            listener?(value)
        }
    }

    // MARK: - Init

    /**
        Create a Bindable object.
        - Parameter value: the init value for the bindable object.
        - Returns: A Bindable object with a init value.
     */
    init(_ value: T) {
        self.value = value
    }

    // MARK: - Public Methods

    /**
        Assign a listener closure to the bindable object
        - Parameter listener: A listener property is a closure that recieves a new value, and return nil.
     */
    func bind(listener: Listener?) {
        self.listener = listener
    }

    ///  Assign a listener closure to the bindable object and call the closure
    ///
    /// - Parameters:
    ///     - listener:A listener property is a closure that recieves a new value, and return nil.
    func bindAndFire(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }

}
