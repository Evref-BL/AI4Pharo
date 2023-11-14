Class {
	#name : #BaselineOfLLMDebugger,
	#superclass : #BaselineOf,
	#category : #BaselineOfLLMDebugger
}

{ #category : #baselines }
BaselineOfLLMDebugger >> baseline: spec [

	<baseline>
	spec for: #common do: [
		self defineDependencies: spec.
		self definePackages: spec.
		self defineGroups: spec ]
]

{ #category : #baselines }
BaselineOfLLMDebugger >> defineDependencies: spec [

	spec
		baseline: 'PharoHuggingFace'
		with: [
		spec repository: 'github://Evref-BL/Pharo-HuggingFace:main/src' ]
]

{ #category : #baselines }
BaselineOfLLMDebugger >> defineGroups: spec [
]

{ #category : #baselines }
BaselineOfLLMDebugger >> definePackages: spec [

	spec
		package: 'LLMDebugger'
		with: [ spec requires: #( 'PharoHuggingFace' ) ]
]