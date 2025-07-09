"
Visual presentation for individual chat messages as bubbles.

•	from: Factory method to create a chat bubble from a message.
•	defaultLayout: Arranges the content within the bubble.
•	initializePresenters: Sets up the text display inside the bubble.
"
Class {
	#name : 'AI4ChatSpecChatBubble',
	#superclass : 'SpPresenterWithModel',
	#instVars : [
		'roleText',
		'contentArea'
	],
	#category : 'AI4Chat-Spec',
	#package : 'AI4Chat',
	#tag : 'Spec'
}

{ #category : 'instance creation' }
AI4ChatSpecChatBubble class >> from: aMessage [

	^ self basicNew
		setModelBeforeInitialization: aMessage;
		initialize;
		yourself
]

{ #category : 'initialization' }
AI4ChatSpecChatBubble >> contentArea [

	^ contentArea
]

{ #category : 'layout' }
AI4ChatSpecChatBubble >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  beNotHomogeneous;
		  add: self model role expand: false;
		  add: contentArea withConstraints: [ :constraints |
				  self contentArea build.
				  constraints
					  height:
						  ((self contentArea text lineHeightsWrappingAtWidth:
								   self extent x) sum) + (self class inputTextHeight * 1.5) ];
		  yourself
]

{ #category : 'initialization' }
AI4ChatSpecChatBubble >> initializePresenters [
	"roleText := self newText .
	roleText text: self model role.
	roleText editable: false."

	contentArea := MicrodownPresenter new.
	contentArea document: (Microdown parse: self model content)
]
