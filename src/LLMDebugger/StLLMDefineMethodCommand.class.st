Class {
	#name : #StLLMDefineMethodCommand,
	#superclass : #StDefineMissingEntityCommand,
	#category : #LLMDebugger
}

{ #category : #accessing }
StLLMDefineMethodCommand class >> defaultDescription [
    ^ 'Create and generate'
]

{ #category : #accessing }
StLLMDefineMethodCommand class >> defaultIconName [

	^ #debuggerDefineEntity
]

{ #category : #accessing }
StLLMDefineMethodCommand class >> defaultName [
	^ 'Create and Generate'
]

{ #category : #accessing }
StLLMDefineMethodCommand class >> defaultShortcut [
	^ nil
]

{ #category : #testing }
StLLMDefineMethodCommand >> appliesTo: aDebugger [

	^ aDebugger canExecuteCreateMissingMethodCommand
]

{ #category : #executing }
StLLMDefineMethodCommand >> execute [
	self debugger createMissingMethodAndGenerate
]
