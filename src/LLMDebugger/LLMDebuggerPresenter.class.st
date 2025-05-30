Class {
	#name : 'LLMDebuggerPresenter',
	#superclass : 'SpPresenter',
	#traits : 'TStDebuggerExtension',
	#classTraits : 'TStDebuggerExtension classTrait',
	#instVars : [
		'debugger',
		'prompt',
		'explainButton',
		'promptButton',
		'result',
		'rawResult',
		'solveButton',
		'promptMethodList'
	],
	#category : 'LLMDebugger',
	#package : 'LLMDebugger'
}

{ #category : 'debugger extension' }
LLMDebuggerPresenter >> appendResultText: aString [

	rawResult ifNil: [ rawResult := '' ].
	rawResult := rawResult , aString.


	SystemVersion current major <= 10
		ifTrue: [ result text: rawResult ]
		ifFalse: [ result document: (Microdown parse: rawResult) ]
]

{ #category : 'prompting' }
LLMDebuggerPresenter >> createExplainPrompt [
	"Creates a prompt for the user to provide a detailed explanation of an error they encountered, including the error name and relevant code snippets from the stack trace."

	self debugger addUserSaid: (String streamContents: [ :stream |
			 stream
			 <<
			 'You are a smalltalk debugging assistant. Give me all pertinent information that I need to debug the error reported below. I give the the error name, then the code of the methods in the stack trace separated by ---.	Error Name: '.
			 stream
			 <<
			 self debugger stDebugger debuggerActionModel
				 statusStringForContext.
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
			 stream << 'Finally propose the code that solves the bug' ])
]

{ #category : 'prompting' }
LLMDebuggerPresenter >> createPrompt [
	"
	1. Je cronstruit le nouveau text que je veux faire
	2. J'ajoute le nouveau text dans mon history
	"

	self debugger addUserSaid: prompt text
]

{ #category : 'prompting' }
LLMDebuggerPresenter >> createSolvePrompt [

	self debugger addUserSaid: (String streamContents: [ :stream |
			 stream
			 << 'You are a inline suggestion for code completion in an IDE.
I have this error: '.
			 stream
			 <<
			 self debugger stDebugger debuggerActionModel
				 statusStringForContext.
			 stream << String lf.
			 stream << 'This is the trace context in between ---'.
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
			 stream << '---'.
			 stream << String lf.
			 stream
			 <<
			 'Do not provide any comment. Generate only the code to solve this issue!' ])
]

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
		  positionOfSlider: 20 percent;
		  add: #prompt;
		  add: (SpBoxLayout newTopToBottom
				   add: #promptMethodList
				   withConstraints: [ :constraints |
					   constraints height: self class toolbarHeight ];
				   add: (SpBoxLayout newLeftToRight
						    add: #promptButton;
						    add: #explainButton;
						    add: #solveButton;
						    yourself)
				   withConstraints: [ :constraints |
				   constraints height: self class toolbarHeight ];
				   add: #result;
				   yourself);
		  yourself
]

{ #category : 'initialization' }
LLMDebuggerPresenter >> initializePresenters [
	"Called automatically by the Spec framework. This method describes how the widgets are initialized"

	"There are no widget for the moment."

	prompt := self newText.
	prompt text: 'Explain the bug'.
	promptButton := self newButton.
	promptButton label: 'Prompt!'.
	promptButton action: [
		self resetResultText.
		self createPrompt.
		self perform: promptMethodList selectedItem ].
	explainButton := self newButton.
	explainButton label: 'Explain!'.
	explainButton action: [
		self resetResultText.
		self createExplainPrompt.
		self perform: promptMethodList selectedItem ].
	solveButton := self newButton.
	solveButton label: 'Solve!'.
	solveButton action: [
		self resetResultText.
		self createSolvePrompt.
		self perform: promptMethodList selectedItem ].
	(SystemVersion current major) <= 10 ifTrue: [ result := self newText. 
		 ] ifFalse: [ result := self instantiate: MicrodownPresenter   ]
	
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

{ #category : 'debugger extension' }
LLMDebuggerPresenter >> resetResultText [

	self updateResultText: ''
]

{ #category : 'accessing - model' }
LLMDebuggerPresenter >> setModelBeforeInitialization: aDebugger [

	debugger := LLMDebugger new.
	debugger stDebugger: aDebugger
]

{ #category : 'initialization' }
LLMDebuggerPresenter >> updatePresenter [
   "Called automatically when the debugger updates its state after stepping"
   "Your widgets should be updated here."
   super updatePresenter
]

{ #category : 'debugger extension' }
LLMDebuggerPresenter >> updateResultText: aString [

	rawResult := aString.
	(SystemVersion current major) <= 10 ifTrue: [ 
		result text: (rawResult ).
		 ] ifFalse: [ result document: (Microdown parse: rawResult) ].
	
]
