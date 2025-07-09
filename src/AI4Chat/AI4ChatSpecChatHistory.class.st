"
Maintains and displays the history of chat messages.

•	from:: Factory method to create a history panel from a collection of messages.
•	addMessage:: Adds a message to the history and updates the display.
•	defaultLayout: Defines the scrolling layout for the history.
•	initializePresenters: Initializes the panel that will hold the chat bubbles.
"
Class {
	#name : 'AI4ChatSpecChatHistory',
	#superclass : 'SpPresenterWithModel',
	#instVars : [
		'panel'
	],
	#category : 'AI4Chat-Spec',
	#package : 'AI4Chat',
	#tag : 'Spec'
}

{ #category : 'instance creation' }
AI4ChatSpecChatHistory class >> from: messages [

	^ self basicNew
		setModelBeforeInitialization: messages;
		initialize;
		yourself
]

{ #category : 'initialization' }
AI4ChatSpecChatHistory >> addMessage: aMessage [

	self model add: aMessage.
	aMessage role = 'system' ifFalse: [
		panel addPresenter: (AI4ChatSpecChatBubble from: aMessage) ]
]

{ #category : 'layout' }
AI4ChatSpecChatHistory >> defaultLayout [

	| scrollPane |
	scrollPane := SpBoxLayout new
		              add: panel;
		              yourself.
	^ scrollPane
]

{ #category : 'initialization' }
AI4ChatSpecChatHistory >> initializePresenters [

	panel := SpComponentListPresenter new.

	self model do: [ :message |
			message role = 'system' ifFalse: [
				panel addPresenter: (AI4ChatSpecChatBubble from: message) ] ]
]
