//
//  File.swift
//  
//
//  Created by Eric Silverberg on 12/21/22.
//

public struct DialogUiState {
    public let title: LocalizedString
    public let messages: [LocalizedString]
    public let positiveAction: DialogAction?
    public let negativeAction: DialogAction?

    public init(title: LocalizedString,
                messages: [LocalizedString],
                positiveAction: DialogAction? = nil,
                negativeAction: DialogAction? = nil) {
        self.title = title
        self.messages = messages
        self.positiveAction = positiveAction
        self.negativeAction = negativeAction
    }
}

