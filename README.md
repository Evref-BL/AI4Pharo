# LLMDebugger

This is an extension of the Pharo Debugger to query an LLM using the [Pharo HuggingFace API](https://github.com/Evref-BL/Pharo-HuggingFace) to do what ever we want.

## Installation

Execute the following in a Pharo Playground

```st
Metacello new
  githubUser: 'Evref-BL' project: 'AI4Pharo' commitish: 'main' path: 'src';
  baseline: 'AI4Pharo';
  load
```

Then, in Settings > Tools > Debugging > DebuggerExtension > LLMDebugger > Activate the extension.

Also, set the [API key for hugging face](https://github.com/Evref-BL/Pharo-HuggingFace)


## Usage

When the debugger popup, you have a right panel that allows you to prompt the LLM
