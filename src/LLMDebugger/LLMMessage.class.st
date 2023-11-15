Class {
	#name : #LLMMessage,
	#superclass : #Object,
	#instVars : [
		'user',
		'text'
	],
	#category : #LLMDebugger
}

{ #category : #'as yet unclassified' }
LLMMessage class >> iSaid: aPrompt [

	^ self new
		  user: 'User';
		  text: aPrompt;
		  yourself
]

{ #category : #'as yet unclassified' }
LLMMessage class >> llmSaid: aPrompt [

	^ self new
		  user: 'Chatbot';
		  text: aPrompt;
		  yourself
]

{ #category : #accessing }
LLMMessage >> text [

	^ text
]

{ #category : #accessing }
LLMMessage >> text: anObject [

	text := anObject
]

{ #category : #accessing }
LLMMessage >> user [

	^ user
]

{ #category : #accessing }
LLMMessage >> user: anObject [

	user := anObject
]
