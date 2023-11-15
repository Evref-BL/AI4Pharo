Class {
	#name : #LLMPromptBuilder,
	#superclass : #Object,
	#instVars : [
		'history',
		'task',
		'context',
		'role'
	],
	#category : #LLMDebugger
}

{ #category : #accessing }
LLMPromptBuilder >> buildPrompt [

	^ (String streamContents: [ :str |
		   str << self role.
		   str << String crlf.
		   self context ifNotNil: [
			   str << '========='.
			   str << String crlf.
			   str << 'Context:'.
			   str << String crlf.
			   str << self context.
			   str << String crlf ].
		   str << '========='.
		   str << String crlf.
		   str << 'History:'.
		   str << String crlf.

		   self history messageStack do: [ :message |
			   str
				   << '[';
				   << message user;
				   << ']';
				   << ':'.
			   str << message text.
			   str << String crlf ].
		   str << '========='.
		   str << String crlf.
		   str << self task ]) recordInfo
]

{ #category : #accessing }
LLMPromptBuilder >> context [

	^ context
]

{ #category : #accessing }
LLMPromptBuilder >> context: anObject [

	context := anObject
]

{ #category : #accessing }
LLMPromptBuilder >> history [

	^ history
]

{ #category : #accessing }
LLMPromptBuilder >> history: anObject [

	history := anObject
]

{ #category : #accessing }
LLMPromptBuilder >> initialize [

	super initialize.
	task := 'Now, you are asking to answer the latest question of [USER]. Generate a response:'
]

{ #category : #accessing }
LLMPromptBuilder >> role [

	^ role
]

{ #category : #accessing }
LLMPromptBuilder >> role: anObject [

	role := anObject
]

{ #category : #accessing }
LLMPromptBuilder >> task [

	^ task
]

{ #category : #accessing }
LLMPromptBuilder >> task: anObject [

	task := anObject
]
