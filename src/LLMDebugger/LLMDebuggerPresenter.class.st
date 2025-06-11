Class {
	#name : 'LLMDebuggerPresenter',
	#superclass : 'SpPresenter',
	#traits : 'TStDebuggerExtension',
	#classTraits : 'TStDebuggerExtension classTrait',
	#instVars : [
		'debugger',
		'chat'
	],
	#category : 'LLMDebugger',
	#package : 'LLMDebugger'
}

{ #category : 'initialization' }
LLMDebuggerPresenter >> currentStDebuggerContext [
   "A 'shortcut' to get the same currentContext of the StDebugger"
   ^ debugger stDebugger currentContext
]

{ #category : 'debugger extension' }
LLMDebuggerPresenter >> debuggerExtensionToolName [
	
	^ 'LLM Debugger'
]

{ #category : 'layout' }
LLMDebuggerPresenter >> defaultLayout [
	"An empty vertical box layout, for the moment"

	^ SpPanedLayout newTopToBottom
		  add: #chat;
		  yourself
]

{ #category : 'initialization' }
LLMDebuggerPresenter >> initializePresenters [
	"Called automatically by the Spec framework. This method describes how the widgets are initialized"

	"There are no widget for the moment."

	chat := LLMAPISpecChat new
]

{ #category : 'prompting' }
LLMDebuggerPresenter >> relativeStackElements [

	| stack doitIndex |
	stack := self debugger stDebugger debuggerActionModel session
		         stackOfSize: 5.
	doitIndex := stack
		             detectIndex: [ :el | el method isDoIt ]
		             ifNone: [ ^ stack reverse ].
	^ (stack copyFrom: 2 to: doitIndex) reverse
]

{ #category : 'accessing - model' }
LLMDebuggerPresenter >> setModelBeforeInitialization: aDebugger [

	debugger := aDebugger
]

{ #category : 'initialization' }
LLMDebuggerPresenter >> updatePresenter [
   "Called automatically when the debugger updates its state after stepping"
   "Your widgets should be updated here."
   super updatePresenter
]
