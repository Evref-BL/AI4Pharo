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
	"Construct and return the prompt, including role, context, history, and current task."

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
		   str << self task ])
]

{ #category : #accessing }
LLMPromptBuilder >> context [
	"Answer the context currently in use."

	^ context
]

{ #category : #accessing }
LLMPromptBuilder >> context: anObject [
	"Sets the context to the provided object."

	context := anObject
]

{ #category : #accessing }
LLMPromptBuilder >> history [
	"Answer the receiver's history object."

	^ history
]

{ #category : #accessing }
LLMPromptBuilder >> history: anObject [
	"Set the value of history to the provided object."

	history := anObject
]

{ #category : #accessing }
LLMPromptBuilder >> initialize [
	"Initialize the instance variables and call superclass's #initialize method."

	super initialize.
	history := LLMHistory new.
	task := 'Now, you are asking to answer the latest question of [USER]. Generate a response:'
]

{ #category : #accessing }
LLMPromptBuilder >> role [
	"Returns the role of an object."

	^ role
]

{ #category : #accessing }
LLMPromptBuilder >> role: anObject [
	"Sets the receiver's role to be the provided object, anObject."

	role := anObject
]

{ #category : #accessing }
LLMPromptBuilder >> task [
	"Returns the current task"

	^ task
]

{ #category : #accessing }
LLMPromptBuilder >> task: anObject [
	"Set the task to the provided object."

	task := anObject
]
