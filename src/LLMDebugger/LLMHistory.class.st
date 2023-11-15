Class {
	#name : #LLMHistory,
	#superclass : #Object,
	#instVars : [
		'messageStack'
	],
	#category : #LLMDebugger
}

{ #category : #adding }
LLMHistory class >> addMessage: aLLMMessage [ 
	self shouldBeImplemented.
]

{ #category : #initialization }
LLMHistory >> addMessage: aMessage [

	self messageStack add: aMessage
]

{ #category : #initialization }
LLMHistory >> initialize [

	super initialize.
	messageStack := Stack new
]

{ #category : #accessing }
LLMHistory >> messageStack [

	^ messageStack
]

{ #category : #accessing }
LLMHistory >> messageStack: anObject [

	messageStack := anObject
]
