"
An AI4ChatClassCommentToolTest is a test class for testing the behavior of AI4ChatClassCommentTool
"
Class {
	#name : 'AI4ChatClassCommentToolTest',
	#superclass : 'TestCase',
	#instVars : [
		'tool'
	],
	#category : 'AI4Chat-Tests-Tools',
	#package : 'AI4Chat-Tests',
	#tag : 'Tools'
}

{ #category : 'running' }
AI4ChatClassCommentToolTest >> setUp [
	super setUp.

	tool := AI4ChatClassCommentTool new
]

{ #category : 'tests' }
AI4ChatClassCommentToolTest >> testCommentOfClass [

	self assert: (tool commentOfClass: 'Object') equals: Object comment
]

{ #category : 'tests' }
AI4ChatClassCommentToolTest >> testCommentOfClassNotExist [

	self assert: (tool commentOfClass: 'XYZ') equals: 'class does not exist'
]
