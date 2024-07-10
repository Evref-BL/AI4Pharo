Extension { #name : 'StDebuggerToolbarCommandTreeBuilder' }

{ #category : '*LLMDebugger' }
StDebuggerToolbarCommandTreeBuilder >> contextControlCommandClasses [
	^ {StDefineMissingEntityCommand . StLLMDefineMethodCommand}
]
