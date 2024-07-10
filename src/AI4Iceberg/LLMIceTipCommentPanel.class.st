Class {
	#name : 'LLMIceTipCommentPanel',
	#superclass : 'IceTipCommentPanel',
	#category : 'AI4Iceberg',
	#package : 'AI4Iceberg'
}

{ #category : 'accessing' }
LLMIceTipCommentPanel >> appendResultText: message [

	commentText text: commentText text , message
]

{ #category : 'accessing' }
LLMIceTipCommentPanel >> buildPrompt [

	| context |
	context := String streamContents: [ :stream |
		           self repositoryModel workingCopyDiff treeRoots collect: [
			           :root |
			           root allChildrenDo: [ :child |
				           child value printOnLLMQuery: stream.
				           stream << String lf.
				           stream << '---' ] ] ].
	^ LLMPromptBuilder new
		  role:
			  'You are a good developer. Based on the context code diff. Write a commit message. No additionnal comment. Only commit message.';
		  context: context;
		  task: 'Write a less than 200 characters commit message for the context';
		  buildPrompt

]

{ #category : 'accessing' }
LLMIceTipCommentPanel >> generateCommitMessage [
	"Generates a commit message using the Ollama API and displays it in the commentText."

	| prompt answer api reader |
	prompt := self buildPrompt.
	api := OllamaAPI new.
	api temperature: 0.7.
	api top_p: 0.9.
	api stream: true.
	answer := api query: prompt.
	reader := NeoJSONReader on: (ZnCharacterReadStream on: answer).
	[
	[ reader atEnd ] whileFalse: [
		| val |
		val := reader next.
		self appendResultText: (val at: #response).
		(val at: #done) ifTrue: [ answer close ] ] ] forkAt:
		Processor lowIOPriority
]

{ #category : 'initialization' }
LLMIceTipCommentPanel >> initializePresenters [

	super initializePresenters.
	optionsButton add: (self newToolbarButton
			 icon: (self application iconNamed: #smallLeftFlush);
			 label: 'Generate commit message';
			 help: 'Generate the commit message based on the work';
			 action: [ self generateCommitMessage ];
			 yourself)
]
