Class {
	#name : 'BaselineOfAI4Pharo',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfAI4Pharo',
	#package : 'BaselineOfAI4Pharo'
}

{ #category : 'baselines' }
BaselineOfAI4Pharo >> baseline: spec [

	<baseline>
	spec for: #common do: [
		self defineDependencies: spec.
		self definePackages: spec.
		self defineGroups: spec ]
]

{ #category : 'baselines' }
BaselineOfAI4Pharo >> defineDependencies: spec [

	spec
		baseline: 'LLMAPI'
		with: [
		spec repository: 'github://Evref-BL/Pharo-LLMAPI:main/src' ]
]

{ #category : 'baselines' }
BaselineOfAI4Pharo >> defineGroups: spec [
]

{ #category : 'baselines' }
BaselineOfAI4Pharo >> definePackages: spec [

	spec package: 'LLMDebugger' with: [
		spec requires:
			#( 'LLMAPI' ) ].
	spec
		package: 'AI4Iceberg'
		with: [ spec requires: #( 'LLMAPI' ) ].
	spec package: 'LLMCommentor'.
	spec package: 'LLMCode'
]
