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

	spec package: 'AI4Debugger' with: [ spec requires: #( 'LLMAPI' ) ].
	spec package: 'AI4Iceberg' with: [ spec requires: #( 'LLMAPI' ) ].
	spec package: 'AI4Chat' with: [ spec requires: #( 'LLMAPI' ) ].
	spec package: 'AI4Chat-Tests' with: [ spec requires: #( 'AI4Chat' ) ].
	spec package: 'AI4Commentor'.
	spec package: 'AI4Code'
]
