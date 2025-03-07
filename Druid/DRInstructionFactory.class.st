Class {
	#name : #DRInstructionFactory,
	#superclass : #Object,
	#instVars : [
		'nextAvailableRegister'
	],
	#category : #'Druid-IR'
}

{ #category : #factory }
DRInstructionFactory >> add: operand1 to: operand2 [

	^ DRAdd
		  operands: { operand1 asDRValue. operand2 asDRValue }
		  result: self allocateTemporaryRegister
]

{ #category : #factory }
DRInstructionFactory >> allocateTemporaryRegister [
	
	| allocatedRegisterId |
	allocatedRegisterId := nextAvailableRegister.
	nextAvailableRegister := nextAvailableRegister + 1.
	^ DRSSARegister name: allocatedRegisterId
]

{ #category : #factory }
DRInstructionFactory >> and: operand1 with: operand2 [

	^ DRAnd
		  operands: { operand1 asDRValue. operand2 asDRValue }
		  result: self allocateTemporaryRegister
]

{ #category : #factory }
DRInstructionFactory >> anyMask: operand1 with: operand2 [

	^ self getConditionCodeOf: DRTestMask new operands: { 
			operand1 asDRValue.
			operand2 asDRValue }
]

{ #category : #factory }
DRInstructionFactory >> bitAnd: operand1 with: operand2 [

	^ DRBitAnd
		  operands: { operand1 asDRValue. operand2 asDRValue }
		  result: self allocateTemporaryRegister
]

{ #category : #factory }
DRInstructionFactory >> copy: aValue [

	^ DRCopy
		  operands: { aValue asDRValue }
		  result: self allocateTemporaryRegister
]

{ #category : #factory }
DRInstructionFactory >> divide: aValue by: anotherValue [

	^ DRDivision
		  operands: { aValue asDRValue. anotherValue asDRValue }
		  result: self allocateTemporaryRegister
]

{ #category : #factory }
DRInstructionFactory >> equals: operand1 to: operand2 [

	^ self getConditionCodeOf: DREqualsThanComparison new operands: { 
			  operand1 asDRValue.
			  operand2 asDRValue }
]

{ #category : #factory }
DRInstructionFactory >> flushStack [

	^ DRFlushStack operands: #(  ) result: DRNoRegister new
]

{ #category : #factory }
DRInstructionFactory >> frameReturn: aValue [

	^ DRFrameReturn operands: { aValue asDRValue } result: self allocateTemporaryRegister
]

{ #category : #factory }
DRInstructionFactory >> getConditionCodeOf: aCondition operands: aCollection [ 

	^ DRGetConditionCode new
		operands: { aCondition }, aCollection;
		result: self allocateTemporaryRegister;
		yourself
]

{ #category : #factory }
DRInstructionFactory >> greater: operand1 than: operand2 [

	^ self getConditionCodeOf: DRGreaterThanComparison new operands: { 
			operand1 asDRValue.
			operand2 asDRValue }
]

{ #category : #factory }
DRInstructionFactory >> initialize [

	super initialize.
	nextAvailableRegister := 0
]

{ #category : #factory }
DRInstructionFactory >> intToFloat: operand1 [

	^ DRIntToFloat
		  operands: { operand1 asDRValue. }
		  result: self allocateTemporaryRegister
]

{ #category : #factory }
DRInstructionFactory >> jitCompileTimeExpression: aString [

	^ DRInterpreterReference reference: aString
]

{ #category : #factory }
DRInstructionFactory >> jitCompileTimeVariable: aString [ 

	^ DRInterpreterReference reference: aString
]

{ #category : #factory }
DRInstructionFactory >> jumpIf: aBoolean [

	^ DRBranchIfCondition operands: {
			  DREqualsThanComparison new.
			  aBoolean asDRValue.
			  true asDRValue }
]

{ #category : #factory }
DRInstructionFactory >> jumpIf: aCondition trueTarget: trueTarget falseTarget: falseTarget [

	^ (self jumpIf: aCondition)
		  trueBranch: trueTarget;
		  falseBranch: falseTarget;
		  yourself
]

{ #category : #factory }
DRInstructionFactory >> lessOrEquals: operand1 than: operand2 [

	^ self getConditionCodeOf: DRLessOrEqualsThanComparison new operands: { 
			  operand1 asDRValue.
			  operand2 asDRValue }
]

{ #category : #factory }
DRInstructionFactory >> load: anAdress [

	^ self loadSInt64: anAdress
]

{ #category : #factory }
DRInstructionFactory >> loadArgument: index [

	^ DRLoadArgument
		  operands: { index }
		  result: self allocateTemporaryRegister
]

{ #category : #factory }
DRInstructionFactory >> loadFramePointer [

	^ DRLoadFramePointer result: self allocateTemporaryRegister
]

{ #category : #factory }
DRInstructionFactory >> loadReceiver [

	^ DRLoadReceiver result: self allocateTemporaryRegister
]

{ #category : #factory }
DRInstructionFactory >> loadSInt64: operand [

	^ DRLoad
		  operands: { 
				  DRSignedIntegerType size: 8.
				  operand asDRValue }
		  result: self allocateTemporaryRegister
]

{ #category : #factory }
DRInstructionFactory >> messageSend: selector withOperands: operands [

	^ DRMessageSend
		  operands: operands
		  result: self allocateTemporaryRegister
]

{ #category : #factory }
DRInstructionFactory >> modulo: aValue by: anotherValue [

	^ DRMod
		  operands: { aValue asDRValue. anotherValue asDRValue }
		  result: self allocateTemporaryRegister
]

{ #category : #factory }
DRInstructionFactory >> multiply: aValue by: anotherValue [

	^ DRMultiply
		  operands: { aValue asDRValue. anotherValue asDRValue }
		  result: self allocateTemporaryRegister
]

{ #category : #factory }
DRInstructionFactory >> or: operand1 with: operand2 [

	^ DROr
		  operands: { operand1 asDRValue. operand2 asDRValue }
		  result: self allocateTemporaryRegister
]

{ #category : #factory }
DRInstructionFactory >> phiWith: value1 [

	^ self phiWithVariables: { value1 asDRValue }
]

{ #category : #factory }
DRInstructionFactory >> phiWith: value1 with: value2 [

	^ self phiWithVariables: { 
			  value1 asDRValue.
			  value2 asDRValue }
]

{ #category : #factory }
DRInstructionFactory >> phiWithVariables: variables [

	^ (DRPhiFunction joinedVariables: variables)
		  result: self allocateTemporaryRegister;
		  yourself
]

{ #category : #factory }
DRInstructionFactory >> push: operand [

	^ DRPush
		  operands: { operand asDRValue }
		  result: self allocateTemporaryRegister
]

{ #category : #factory }
DRInstructionFactory >> pushBase: base offset: offset [

	^ DRPush
		  operands: { (DRBaseOffsetMemoryAddress new
				   base: base;
				   offset: offset;
				   yourself) }
		  result: self allocateTemporaryRegister
]

{ #category : #factory }
DRInstructionFactory >> setReturnValue: aValue [ 
	
	^ DRCopy
		  operands: { aValue asDRValue }
		  result: (DRPhysicalGeneralPurposeRegister name: 'ReceiverResultReg')
]

{ #category : #factory }
DRInstructionFactory >> storeSInt64: operand at: address [

	^ DRStore
		  operands: {
				  8 asDRValue.
				  operand asDRValue.
				  address asDRValue }
		  result: DRNoRegister new
]

{ #category : #factory }
DRInstructionFactory >> strongCopyForInlining: aValue [

	^ DRStrongCopyForInlining
		  operands: { aValue asDRValue }
		  result: self allocateTemporaryRegister
]

{ #category : #factory }
DRInstructionFactory >> sub: operand1 from: operand2 [

	^ DRSubtract 
		  operands: { operand1 asDRValue. operand2 asDRValue }
		  result: self allocateTemporaryRegister
]

{ #category : #factory }
DRInstructionFactory >> subtract: subtrahend from: minuend [

	^ DRSubtract
		  operands: { minuend asDRValue. subtrahend asDRValue }
		  result: self allocateTemporaryRegister
]
