Class {
	#name : 'SycOpenLLMMenuCommand',
	#superclass : 'SycOpenContextMenuCommand',
	#category : 'AI4Code',
	#package : 'AI4Code'
}

{ #category : 'as yet unclassified' }
SycOpenLLMMenuCommand class >> methodEditorShortcutActivation [
	<classAnnotation>

	^CmdShortcutActivation by: $a meta shift for: ClySourceCodeContext
]

{ #category : 'as yet unclassified' }
SycOpenLLMMenuCommand class >> sourceCodeMenuActivation [
	<classAnnotation>

	^CmdContextMenuActivation byRootGroupItemOrder: 0.9 for: ClySourceCodeContext
]

{ #category : 'execution' }
SycOpenLLMMenuCommand >> activationStrategy [

	^ SycLLMMenuActivation
]

{ #category : 'context menu' }
SycOpenLLMMenuCommand >> cmCommandClass [

	^ SycSourceCodeCmCommand
]

{ #category : 'accessing' }
SycOpenLLMMenuCommand >> defaultMenuItemName [

	^ 'AI Menu'
]
