Class {
	#name : 'LLMDebuggerPresenter',
	#superclass : 'SpPresenter',
	#traits : 'TStDebuggerExtension',
	#classTraits : 'TStDebuggerExtension classTrait',
	#instVars : [
		'debugger',
		'chat'
	],
	#category : 'AI4Debugger',
	#package : 'AI4Debugger'
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

	^ SpBoxLayout newTopToBottom
		  add: #chat;
		  yourself
]

{ #category : 'initialization' }
LLMDebuggerPresenter >> initializePresenters [
	"Called automatically by the Spec framework. This method describes how the widgets are initialized"

	"There are no widget for the moment."

	| message |
	chat := LLMAPISpecChat new.
	
	message := String streamContents: [ :stream |
			stream
			<<
			'You are a smalltalk debugging assistant. Give me all pertinent information that I need to debug the error reported below. I give the the error name, then the code of the methods in the stack trace separated by ---.	Error Name: '.
			stream
			<<
			 debugger debuggerActionModel statusStringForContext.
			stream << String lf.
			stream << String lf.
			stream << '---'.
			stream << String lf.
			self relativeStackElements
				do: [ :stack | stream << stack sourceCode ]
				separatedBy: [
						stream << String lf.
						stream << String lf.
						stream << '---'.
						stream << String lf ].
			stream << String lf.
			stream << String lf.
			stream << '---'.
			stream << String lf.
			stream << String lf.
			stream
			<<
			'Help the user to fix the bug answering question with the given bug context' ].
	chat history addMessage: (LLMAPIChatObjectMessage
			 role: 'system'
			 content: message)
]

{ #category : 'prompting' }
LLMDebuggerPresenter >> relativeStackElements [

	| stack doitIndex |
	stack := debugger debuggerActionModel session
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
