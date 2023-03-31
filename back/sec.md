Summary
 - [controlled-delegatecall](#controlled-delegatecall) (1 results) (High)
 - [shadowing-state](#shadowing-state) (1 results) (High)
 - [reentrancy-no-eth](#reentrancy-no-eth) (4 results) (Medium)
 - [unchecked-lowlevel](#unchecked-lowlevel) (5 results) (Medium)
 - [uninitialized-local](#uninitialized-local) (8 results) (Medium)
 - [unused-return](#unused-return) (2 results) (Medium)
 - [incorrect-modifier](#incorrect-modifier) (2 results) (Low)
 - [variable-scope](#variable-scope) (3 results) (Low)
 - [reentrancy-benign](#reentrancy-benign) (13 results) (Low)
 - [reentrancy-events](#reentrancy-events) (12 results) (Low)
 - [assembly](#assembly) (16 results) (Informational)
 - [pragma](#pragma) (1 results) (Informational)
 - [solc-version](#solc-version) (29 results) (Informational)
 - [low-level-calls](#low-level-calls) (14 results) (Informational)
 - [naming-convention](#naming-convention) (86 results) (Informational)
 - [redundant-statements](#redundant-statements) (3 results) (Informational)
 - [similar-names](#similar-names) (22 results) (Informational)
 - [unused-state](#unused-state) (14 results) (Informational)
 - [constable-states](#constable-states) (1 results) (Optimization)
## controlled-delegatecall
Impact: High
Confidence: Medium
 - [ ] ID-0
[DiamondCut.diamondCut(IDiamondCut.FacetCut[],address,bytes)](src/diamond/Diamond.Cut.sol#L58-L103) uses delegatecall to a input-controlled function id
	- [(success) = _constructor.delegatecall(_calldata)](src/diamond/Diamond.Cut.sol#L95)

src/diamond/Diamond.Cut.sol#L58-L103


## shadowing-state
Impact: High
Confidence: High
 - [ ] ID-1
[StdCheats.vm](lib/forge-std/src/StdCheats.sol#L480) shadows:
	- [StdCheatsSafe.vm](lib/forge-std/src/StdCheats.sol#L10)

lib/forge-std/src/StdCheats.sol#L480


## reentrancy-no-eth
Impact: Medium
Confidence: Medium
 - [ ] ID-2
Reentrancy in [CounterFacetTest.testCounter()](test/Counter.t.sol#L14-L35):
	External calls:
	- [(None,result) = address(diamond).call(abi.encodeWithSelector(0x8ada066e))](test/Counter.t.sol#L16)
	- [assertEq(value,0,Initial value should be 0)](test/Counter.t.sol#L18)
		- [(status) = HEVM_ADDRESS.call(abi.encodePacked(bytes4(keccak256(bytes)(store(address,bytes32,bytes32))),abi.encode(HEVM_ADDRESS,bytes32(failed),bytes32(uint256(0x01)))))](lib/forge-std/lib/ds-test/src/test.sol#L67-L72)
	- [address(diamond).call(abi.encodeWithSelector(0xd09de08a))](test/Counter.t.sol#L21)
	- [address(diamond).call(abi.encodeWithSelector(0xd09de08a))](test/Counter.t.sol#L23)
	- [(None,result) = address(diamond).call(abi.encodeWithSelector(0x8ada066e))](test/Counter.t.sol#L25)
	- [assertEq(value,2,Double incremented value should be 2)](test/Counter.t.sol#L27)
		- [(status) = HEVM_ADDRESS.call(abi.encodePacked(bytes4(keccak256(bytes)(store(address,bytes32,bytes32))),abi.encode(HEVM_ADDRESS,bytes32(failed),bytes32(uint256(0x01)))))](lib/forge-std/lib/ds-test/src/test.sol#L67-L72)
	- [address(diamond).call(abi.encodeWithSelector(0x2baeceb7))](test/Counter.t.sol#L30)
	- [(None,result) = address(diamond).call(abi.encodeWithSelector(0x8ada066e))](test/Counter.t.sol#L32)
	State variables written after the call(s):
	- [(None,result) = address(diamond).call(abi.encodeWithSelector(0x8ada066e))](test/Counter.t.sol#L32)
	[CounterFacetTest.result](test/Counter.t.sol#L7) can be used in cross function reentrancies:
	- [CounterFacetTest.testCounter()](test/Counter.t.sol#L14-L35)
	- [value = abi.decode(result,(uint256))](test/Counter.t.sol#L33)
	[CounterFacetTest.value](test/Counter.t.sol#L8) can be used in cross function reentrancies:
	- [CounterFacetTest.testCounter()](test/Counter.t.sol#L14-L35)

test/Counter.t.sol#L14-L35


 - [ ] ID-3
Reentrancy in [CounterFacetTest.testCounter()](test/Counter.t.sol#L14-L35):
	External calls:
	- [(None,result) = address(diamond).call(abi.encodeWithSelector(0x8ada066e))](test/Counter.t.sol#L16)
	- [assertEq(value,0,Initial value should be 0)](test/Counter.t.sol#L18)
		- [(status) = HEVM_ADDRESS.call(abi.encodePacked(bytes4(keccak256(bytes)(store(address,bytes32,bytes32))),abi.encode(HEVM_ADDRESS,bytes32(failed),bytes32(uint256(0x01)))))](lib/forge-std/lib/ds-test/src/test.sol#L67-L72)
	- [address(diamond).call(abi.encodeWithSelector(0xd09de08a))](test/Counter.t.sol#L21)
	- [address(diamond).call(abi.encodeWithSelector(0xd09de08a))](test/Counter.t.sol#L23)
	- [(None,result) = address(diamond).call(abi.encodeWithSelector(0x8ada066e))](test/Counter.t.sol#L25)
	State variables written after the call(s):
	- [(None,result) = address(diamond).call(abi.encodeWithSelector(0x8ada066e))](test/Counter.t.sol#L25)
	[CounterFacetTest.result](test/Counter.t.sol#L7) can be used in cross function reentrancies:
	- [CounterFacetTest.testCounter()](test/Counter.t.sol#L14-L35)
	- [value = abi.decode(result,(uint256))](test/Counter.t.sol#L26)
	[CounterFacetTest.value](test/Counter.t.sol#L8) can be used in cross function reentrancies:
	- [CounterFacetTest.testCounter()](test/Counter.t.sol#L14-L35)

test/Counter.t.sol#L14-L35


 - [ ] ID-4
Reentrancy in [FlipperFacetTest.testFlip()](test/Flipper.t.sol#L13-L32):
	External calls:
	- [(None,result) = address(diamond).call(abi.encodeWithSelector(0x6d4ce63c))](test/Flipper.t.sol#L15)
	- [assertEq(value,false,Initial value should be false)](test/Flipper.t.sol#L17)
		- [(status) = HEVM_ADDRESS.call(abi.encodePacked(bytes4(keccak256(bytes)(store(address,bytes32,bytes32))),abi.encode(HEVM_ADDRESS,bytes32(failed),bytes32(uint256(0x01)))))](lib/forge-std/lib/ds-test/src/test.sol#L67-L72)
	- [address(diamond).call(abi.encodeWithSelector(0xcde4efa9))](test/Flipper.t.sol#L20)
	- [(None,result) = address(diamond).call(abi.encodeWithSelector(0x6d4ce63c))](test/Flipper.t.sol#L22)
	- [assertEq(value2,true,Value should be true after flip)](test/Flipper.t.sol#L24)
		- [(status) = HEVM_ADDRESS.call(abi.encodePacked(bytes4(keccak256(bytes)(store(address,bytes32,bytes32))),abi.encode(HEVM_ADDRESS,bytes32(failed),bytes32(uint256(0x01)))))](lib/forge-std/lib/ds-test/src/test.sol#L67-L72)
	- [address(diamond).call(abi.encodeWithSelector(0xcde4efa9))](test/Flipper.t.sol#L27)
	- [(None,result) = address(diamond).call(abi.encodeWithSelector(0x6d4ce63c))](test/Flipper.t.sol#L29)
	State variables written after the call(s):
	- [(None,result) = address(diamond).call(abi.encodeWithSelector(0x6d4ce63c))](test/Flipper.t.sol#L29)
	[FlipperFacetTest.result](test/Flipper.t.sol#L7) can be used in cross function reentrancies:
	- [FlipperFacetTest.testFlip()](test/Flipper.t.sol#L13-L32)

test/Flipper.t.sol#L13-L32


 - [ ] ID-5
Reentrancy in [FlipperFacetTest.testFlip()](test/Flipper.t.sol#L13-L32):
	External calls:
	- [(None,result) = address(diamond).call(abi.encodeWithSelector(0x6d4ce63c))](test/Flipper.t.sol#L15)
	- [assertEq(value,false,Initial value should be false)](test/Flipper.t.sol#L17)
		- [(status) = HEVM_ADDRESS.call(abi.encodePacked(bytes4(keccak256(bytes)(store(address,bytes32,bytes32))),abi.encode(HEVM_ADDRESS,bytes32(failed),bytes32(uint256(0x01)))))](lib/forge-std/lib/ds-test/src/test.sol#L67-L72)
	- [address(diamond).call(abi.encodeWithSelector(0xcde4efa9))](test/Flipper.t.sol#L20)
	- [(None,result) = address(diamond).call(abi.encodeWithSelector(0x6d4ce63c))](test/Flipper.t.sol#L22)
	State variables written after the call(s):
	- [(None,result) = address(diamond).call(abi.encodeWithSelector(0x6d4ce63c))](test/Flipper.t.sol#L22)
	[FlipperFacetTest.result](test/Flipper.t.sol#L7) can be used in cross function reentrancies:
	- [FlipperFacetTest.testFlip()](test/Flipper.t.sol#L13-L32)

test/Flipper.t.sol#L13-L32


## unchecked-lowlevel
Impact: Medium
Confidence: Medium
 - [ ] ID-6
[CounterFacetTest.testCounter()](test/Counter.t.sol#L14-L35) ignores return value by [address(diamond).call(abi.encodeWithSelector(0x2baeceb7))](test/Counter.t.sol#L30)

test/Counter.t.sol#L14-L35


 - [ ] ID-7
[CounterFacetTest.testCounter()](test/Counter.t.sol#L14-L35) ignores return value by [address(diamond).call(abi.encodeWithSelector(0xd09de08a))](test/Counter.t.sol#L23)

test/Counter.t.sol#L14-L35


 - [ ] ID-8
[CounterFacetTest.testCounter()](test/Counter.t.sol#L14-L35) ignores return value by [address(diamond).call(abi.encodeWithSelector(0xd09de08a))](test/Counter.t.sol#L21)

test/Counter.t.sol#L14-L35


 - [ ] ID-9
[FlipperFacetTest.testFlip()](test/Flipper.t.sol#L13-L32) ignores return value by [address(diamond).call(abi.encodeWithSelector(0xcde4efa9))](test/Flipper.t.sol#L27)

test/Flipper.t.sol#L13-L32


 - [ ] ID-10
[FlipperFacetTest.testFlip()](test/Flipper.t.sol#L13-L32) ignores return value by [address(diamond).call(abi.encodeWithSelector(0xcde4efa9))](test/Flipper.t.sol#L20)

test/Flipper.t.sol#L13-L32


## uninitialized-local
Impact: Medium
Confidence: Medium
 - [ ] ID-11
[StdCheatsSafe.rawToConvertedEIPTx1559(StdCheatsSafe.RawTx1559).transaction](lib/forge-std/src/StdCheats.sol#L252) is a local variable never initialized

lib/forge-std/src/StdCheats.sol#L252


 - [ ] ID-12
[StdCheatsSafe.readEIP1559ScriptArtifact(string).artifact](lib/forge-std/src/StdCheats.sol#L232) is a local variable never initialized

lib/forge-std/src/StdCheats.sol#L232


 - [ ] ID-13
[StdCheatsSafe.rawToConvertedEIP1559Detail(StdCheatsSafe.RawTx1559Detail).txDetail](lib/forge-std/src/StdCheats.sol#L268) is a local variable never initialized

lib/forge-std/src/StdCheats.sol#L268


 - [ ] ID-14
[StdCheatsSafe.rawToConvertedEIPTx1559s(StdCheatsSafe.RawTx1559[]).i](lib/forge-std/src/StdCheats.sol#L245) is a local variable never initialized

lib/forge-std/src/StdCheats.sol#L245


 - [ ] ID-15
[DiamondCut.removeSelector(bytes4).selectorIndex](src/diamond/Diamond.Cut.sol#L38) is a local variable never initialized

src/diamond/Diamond.Cut.sol#L38


 - [ ] ID-16
[StdCheatsSafe.rawToConvertedReceiptLogs(StdCheatsSafe.RawReceiptLog[]).i](lib/forge-std/src/StdCheats.sol#L344) is a local variable never initialized

lib/forge-std/src/StdCheats.sol#L344


 - [ ] ID-17
[StdCheatsSafe.rawToConvertedReceipts(StdCheatsSafe.RawReceipt[]).i](lib/forge-std/src/StdCheats.sol#L313) is a local variable never initialized

lib/forge-std/src/StdCheats.sol#L313


 - [ ] ID-18
[StdCheatsSafe.rawToConvertedReceipt(StdCheatsSafe.RawReceipt).receipt](lib/forge-std/src/StdCheats.sol#L320) is a local variable never initialized

lib/forge-std/src/StdCheats.sol#L320


## unused-return
Impact: Medium
Confidence: Medium
 - [ ] ID-19
[StdCheatsSafe.isFork()](lib/forge-std/src/StdCheats.sol#L428-L432) ignores return value by [vm.activeFork()](lib/forge-std/src/StdCheats.sol#L429-L431)

lib/forge-std/src/StdCheats.sol#L428-L432


 - [ ] ID-20
[StdChains.getChainWithUpdatedRpcUrl(string,StdChains.Chain)](lib/forge-std/src/StdChains.sol#L155-L178) ignores return value by [vm.rpcUrl(chainAlias)](lib/forge-std/src/StdChains.sol#L157-L175)

lib/forge-std/src/StdChains.sol#L155-L178


## incorrect-modifier
Impact: Low
Confidence: High
 - [ ] ID-21
Modifier [StdCheatsSafe.skipWhenForking()](lib/forge-std/src/StdCheats.sol#L434-L438) does not always execute _; or revert
lib/forge-std/src/StdCheats.sol#L434-L438


 - [ ] ID-22
Modifier [StdCheatsSafe.skipWhenNotForking()](lib/forge-std/src/StdCheats.sol#L440-L444) does not always execute _; or revert
lib/forge-std/src/StdCheats.sol#L440-L444


## variable-scope
Impact: Low
Confidence: High
 - [ ] ID-23
Variable '[StdChains.getChainWithUpdatedRpcUrl(string,StdChains.Chain).configRpcUrl](lib/forge-std/src/StdChains.sol#L157)' in [StdChains.getChainWithUpdatedRpcUrl(string,StdChains.Chain)](lib/forge-std/src/StdChains.sol#L155-L178) potentially used before declaration: [chain.rpcUrl = configRpcUrl](lib/forge-std/src/StdChains.sol#L158)

lib/forge-std/src/StdChains.sol#L157


 - [ ] ID-24
Variable '[StdChains.getChainWithUpdatedRpcUrl(string,StdChains.Chain).err](lib/forge-std/src/StdChains.sol#L159)' in [StdChains.getChainWithUpdatedRpcUrl(string,StdChains.Chain)](lib/forge-std/src/StdChains.sol#L155-L178) potentially used before declaration: [revert(uint256,uint256)(32 + err,mload(uint256)(err))](lib/forge-std/src/StdChains.sol#L172)

lib/forge-std/src/StdChains.sol#L159


 - [ ] ID-25
Variable '[StdChains.getChainWithUpdatedRpcUrl(string,StdChains.Chain).err](lib/forge-std/src/StdChains.sol#L159)' in [StdChains.getChainWithUpdatedRpcUrl(string,StdChains.Chain)](lib/forge-std/src/StdChains.sol#L155-L178) potentially used before declaration: [keccak256(bytes)(notFoundError) != keccak256(bytes)(err) || bytes(chain.rpcUrl).length == 0](lib/forge-std/src/StdChains.sol#L169)

lib/forge-std/src/StdChains.sol#L159


## reentrancy-benign
Impact: Low
Confidence: Medium
 - [ ] ID-26
Reentrancy in [StdCheatsSafe.noGasMetering()](lib/forge-std/src/StdCheats.sol#L446-L465):
	External calls:
	- [vm.pauseGasMetering()](lib/forge-std/src/StdCheats.sol#L447)
	State variables written after the call(s):
	- [gasMeteringOff = true](lib/forge-std/src/StdCheats.sol#L456)
	- [gasMeteringOff = false](lib/forge-std/src/StdCheats.sol#L462)

lib/forge-std/src/StdCheats.sol#L446-L465


 - [ ] ID-27
Reentrancy in [StdAssertions.assertEqCall(address,bytes,address,bytes,bool)](lib/forge-std/src/StdAssertions.sol#L344-L375):
	External calls:
	- [(successA,returnDataA) = address(targetA).call(callDataA)](lib/forge-std/src/StdAssertions.sol#L351)
	- [(successB,returnDataB) = address(targetB).call(callDataB)](lib/forge-std/src/StdAssertions.sol#L352)
	- [assertEq(returnDataA,returnDataB,Call return data does not match)](lib/forge-std/src/StdAssertions.sol#L355)
		- [(status) = HEVM_ADDRESS.call(abi.encodePacked(bytes4(keccak256(bytes)(store(address,bytes32,bytes32))),abi.encode(HEVM_ADDRESS,bytes32(failed),bytes32(uint256(0x01)))))](lib/forge-std/lib/ds-test/src/test.sol#L67-L72)
	- [assertEq(returnDataA,returnDataB,Call revert data does not match)](lib/forge-std/src/StdAssertions.sol#L359)
		- [(status) = HEVM_ADDRESS.call(abi.encodePacked(bytes4(keccak256(bytes)(store(address,bytes32,bytes32))),abi.encode(HEVM_ADDRESS,bytes32(failed),bytes32(uint256(0x01)))))](lib/forge-std/lib/ds-test/src/test.sol#L67-L72)
	- [fail()](lib/forge-std/src/StdAssertions.sol#L366)
		- [(status) = HEVM_ADDRESS.call(abi.encodePacked(bytes4(keccak256(bytes)(store(address,bytes32,bytes32))),abi.encode(HEVM_ADDRESS,bytes32(failed),bytes32(uint256(0x01)))))](lib/forge-std/lib/ds-test/src/test.sol#L67-L72)
	State variables written after the call(s):
	- [fail()](lib/forge-std/src/StdAssertions.sol#L366)
		- [_failed = true](lib/forge-std/lib/ds-test/src/test.sol#L75)

lib/forge-std/src/StdAssertions.sol#L344-L375


 - [ ] ID-28
Reentrancy in [CounterFacetTest.testCounter()](test/Counter.t.sol#L14-L35):
	External calls:
	- [(None,result) = address(diamond).call(abi.encodeWithSelector(0x8ada066e))](test/Counter.t.sol#L16)
	- [assertEq(value,0,Initial value should be 0)](test/Counter.t.sol#L18)
		- [(status) = HEVM_ADDRESS.call(abi.encodePacked(bytes4(keccak256(bytes)(store(address,bytes32,bytes32))),abi.encode(HEVM_ADDRESS,bytes32(failed),bytes32(uint256(0x01)))))](lib/forge-std/lib/ds-test/src/test.sol#L67-L72)
	- [address(diamond).call(abi.encodeWithSelector(0xd09de08a))](test/Counter.t.sol#L21)
	- [address(diamond).call(abi.encodeWithSelector(0xd09de08a))](test/Counter.t.sol#L23)
	- [(None,result) = address(diamond).call(abi.encodeWithSelector(0x8ada066e))](test/Counter.t.sol#L25)
	- [assertEq(value,2,Double incremented value should be 2)](test/Counter.t.sol#L27)
		- [(status) = HEVM_ADDRESS.call(abi.encodePacked(bytes4(keccak256(bytes)(store(address,bytes32,bytes32))),abi.encode(HEVM_ADDRESS,bytes32(failed),bytes32(uint256(0x01)))))](lib/forge-std/lib/ds-test/src/test.sol#L67-L72)
	- [address(diamond).call(abi.encodeWithSelector(0x2baeceb7))](test/Counter.t.sol#L30)
	- [(None,result) = address(diamond).call(abi.encodeWithSelector(0x8ada066e))](test/Counter.t.sol#L32)
	- [assertEq(value,1,Decremented value should be 1)](test/Counter.t.sol#L34)
		- [(status) = HEVM_ADDRESS.call(abi.encodePacked(bytes4(keccak256(bytes)(store(address,bytes32,bytes32))),abi.encode(HEVM_ADDRESS,bytes32(failed),bytes32(uint256(0x01)))))](lib/forge-std/lib/ds-test/src/test.sol#L67-L72)
	State variables written after the call(s):
	- [assertEq(value,1,Decremented value should be 1)](test/Counter.t.sol#L34)
		- [_failed = true](lib/forge-std/lib/ds-test/src/test.sol#L75)

test/Counter.t.sol#L14-L35


 - [ ] ID-29
Reentrancy in [DSTest.fail()](lib/forge-std/lib/ds-test/src/test.sol#L65-L76):
	External calls:
	- [(status) = HEVM_ADDRESS.call(abi.encodePacked(bytes4(keccak256(bytes)(store(address,bytes32,bytes32))),abi.encode(HEVM_ADDRESS,bytes32(failed),bytes32(uint256(0x01)))))](lib/forge-std/lib/ds-test/src/test.sol#L67-L72)
	State variables written after the call(s):
	- [_failed = true](lib/forge-std/lib/ds-test/src/test.sol#L75)

lib/forge-std/lib/ds-test/src/test.sol#L65-L76


 - [ ] ID-30
Reentrancy in [StdAssertions.assertEqCall(address,bytes,address,bytes,bool)](lib/forge-std/src/StdAssertions.sol#L344-L375):
	External calls:
	- [(successA,returnDataA) = address(targetA).call(callDataA)](lib/forge-std/src/StdAssertions.sol#L351)
	- [(successB,returnDataB) = address(targetB).call(callDataB)](lib/forge-std/src/StdAssertions.sol#L352)
	- [assertEq(returnDataA,returnDataB,Call return data does not match)](lib/forge-std/src/StdAssertions.sol#L355)
		- [(status) = HEVM_ADDRESS.call(abi.encodePacked(bytes4(keccak256(bytes)(store(address,bytes32,bytes32))),abi.encode(HEVM_ADDRESS,bytes32(failed),bytes32(uint256(0x01)))))](lib/forge-std/lib/ds-test/src/test.sol#L67-L72)
	- [assertEq(returnDataA,returnDataB,Call revert data does not match)](lib/forge-std/src/StdAssertions.sol#L359)
		- [(status) = HEVM_ADDRESS.call(abi.encodePacked(bytes4(keccak256(bytes)(store(address,bytes32,bytes32))),abi.encode(HEVM_ADDRESS,bytes32(failed),bytes32(uint256(0x01)))))](lib/forge-std/lib/ds-test/src/test.sol#L67-L72)
	- [fail()](lib/forge-std/src/StdAssertions.sol#L366)
		- [(status) = HEVM_ADDRESS.call(abi.encodePacked(bytes4(keccak256(bytes)(store(address,bytes32,bytes32))),abi.encode(HEVM_ADDRESS,bytes32(failed),bytes32(uint256(0x01)))))](lib/forge-std/lib/ds-test/src/test.sol#L67-L72)
	- [fail()](lib/forge-std/src/StdAssertions.sol#L373)
		- [(status) = HEVM_ADDRESS.call(abi.encodePacked(bytes4(keccak256(bytes)(store(address,bytes32,bytes32))),abi.encode(HEVM_ADDRESS,bytes32(failed),bytes32(uint256(0x01)))))](lib/forge-std/lib/ds-test/src/test.sol#L67-L72)
	State variables written after the call(s):
	- [fail()](lib/forge-std/src/StdAssertions.sol#L373)
		- [_failed = true](lib/forge-std/lib/ds-test/src/test.sol#L75)

lib/forge-std/src/StdAssertions.sol#L344-L375


 - [ ] ID-31
Reentrancy in [StdAssertions.assertEqCall(address,bytes,address,bytes,bool)](lib/forge-std/src/StdAssertions.sol#L344-L375):
	External calls:
	- [(successA,returnDataA) = address(targetA).call(callDataA)](lib/forge-std/src/StdAssertions.sol#L351)
	- [(successB,returnDataB) = address(targetB).call(callDataB)](lib/forge-std/src/StdAssertions.sol#L352)
	- [assertEq(returnDataA,returnDataB,Call return data does not match)](lib/forge-std/src/StdAssertions.sol#L355)
		- [(status) = HEVM_ADDRESS.call(abi.encodePacked(bytes4(keccak256(bytes)(store(address,bytes32,bytes32))),abi.encode(HEVM_ADDRESS,bytes32(failed),bytes32(uint256(0x01)))))](lib/forge-std/lib/ds-test/src/test.sol#L67-L72)
	State variables written after the call(s):
	- [assertEq(returnDataA,returnDataB,Call return data does not match)](lib/forge-std/src/StdAssertions.sol#L355)
		- [_failed = true](lib/forge-std/lib/ds-test/src/test.sol#L75)

lib/forge-std/src/StdAssertions.sol#L344-L375


 - [ ] ID-32
Reentrancy in [StdAssertions.assertEqCall(address,bytes,address,bytes,bool)](lib/forge-std/src/StdAssertions.sol#L344-L375):
	External calls:
	- [(successA,returnDataA) = address(targetA).call(callDataA)](lib/forge-std/src/StdAssertions.sol#L351)
	- [(successB,returnDataB) = address(targetB).call(callDataB)](lib/forge-std/src/StdAssertions.sol#L352)
	- [assertEq(returnDataA,returnDataB,Call return data does not match)](lib/forge-std/src/StdAssertions.sol#L355)
		- [(status) = HEVM_ADDRESS.call(abi.encodePacked(bytes4(keccak256(bytes)(store(address,bytes32,bytes32))),abi.encode(HEVM_ADDRESS,bytes32(failed),bytes32(uint256(0x01)))))](lib/forge-std/lib/ds-test/src/test.sol#L67-L72)
	- [assertEq(returnDataA,returnDataB,Call revert data does not match)](lib/forge-std/src/StdAssertions.sol#L359)
		- [(status) = HEVM_ADDRESS.call(abi.encodePacked(bytes4(keccak256(bytes)(store(address,bytes32,bytes32))),abi.encode(HEVM_ADDRESS,bytes32(failed),bytes32(uint256(0x01)))))](lib/forge-std/lib/ds-test/src/test.sol#L67-L72)
	State variables written after the call(s):
	- [assertEq(returnDataA,returnDataB,Call revert data does not match)](lib/forge-std/src/StdAssertions.sol#L359)
		- [_failed = true](lib/forge-std/lib/ds-test/src/test.sol#L75)

lib/forge-std/src/StdAssertions.sol#L344-L375


 - [ ] ID-33
Reentrancy in [FlipperFacetTest.testFlip()](test/Flipper.t.sol#L13-L32):
	External calls:
	- [(None,result) = address(diamond).call(abi.encodeWithSelector(0x6d4ce63c))](test/Flipper.t.sol#L15)
	- [assertEq(value,false,Initial value should be false)](test/Flipper.t.sol#L17)
		- [(status) = HEVM_ADDRESS.call(abi.encodePacked(bytes4(keccak256(bytes)(store(address,bytes32,bytes32))),abi.encode(HEVM_ADDRESS,bytes32(failed),bytes32(uint256(0x01)))))](lib/forge-std/lib/ds-test/src/test.sol#L67-L72)
	- [address(diamond).call(abi.encodeWithSelector(0xcde4efa9))](test/Flipper.t.sol#L20)
	- [(None,result) = address(diamond).call(abi.encodeWithSelector(0x6d4ce63c))](test/Flipper.t.sol#L22)
	- [assertEq(value2,true,Value should be true after flip)](test/Flipper.t.sol#L24)
		- [(status) = HEVM_ADDRESS.call(abi.encodePacked(bytes4(keccak256(bytes)(store(address,bytes32,bytes32))),abi.encode(HEVM_ADDRESS,bytes32(failed),bytes32(uint256(0x01)))))](lib/forge-std/lib/ds-test/src/test.sol#L67-L72)
	State variables written after the call(s):
	- [assertEq(value2,true,Value should be true after flip)](test/Flipper.t.sol#L24)
		- [_failed = true](lib/forge-std/lib/ds-test/src/test.sol#L75)

test/Flipper.t.sol#L13-L32


 - [ ] ID-34
Reentrancy in [CounterFacetTest.testCounter()](test/Counter.t.sol#L14-L35):
	External calls:
	- [(None,result) = address(diamond).call(abi.encodeWithSelector(0x8ada066e))](test/Counter.t.sol#L16)
	- [assertEq(value,0,Initial value should be 0)](test/Counter.t.sol#L18)
		- [(status) = HEVM_ADDRESS.call(abi.encodePacked(bytes4(keccak256(bytes)(store(address,bytes32,bytes32))),abi.encode(HEVM_ADDRESS,bytes32(failed),bytes32(uint256(0x01)))))](lib/forge-std/lib/ds-test/src/test.sol#L67-L72)
	- [address(diamond).call(abi.encodeWithSelector(0xd09de08a))](test/Counter.t.sol#L21)
	- [address(diamond).call(abi.encodeWithSelector(0xd09de08a))](test/Counter.t.sol#L23)
	- [(None,result) = address(diamond).call(abi.encodeWithSelector(0x8ada066e))](test/Counter.t.sol#L25)
	- [assertEq(value,2,Double incremented value should be 2)](test/Counter.t.sol#L27)
		- [(status) = HEVM_ADDRESS.call(abi.encodePacked(bytes4(keccak256(bytes)(store(address,bytes32,bytes32))),abi.encode(HEVM_ADDRESS,bytes32(failed),bytes32(uint256(0x01)))))](lib/forge-std/lib/ds-test/src/test.sol#L67-L72)
	State variables written after the call(s):
	- [assertEq(value,2,Double incremented value should be 2)](test/Counter.t.sol#L27)
		- [_failed = true](lib/forge-std/lib/ds-test/src/test.sol#L75)

test/Counter.t.sol#L14-L35


 - [ ] ID-35
Reentrancy in [CounterFacetTest.testCounter()](test/Counter.t.sol#L14-L35):
	External calls:
	- [(None,result) = address(diamond).call(abi.encodeWithSelector(0x8ada066e))](test/Counter.t.sol#L16)
	- [assertEq(value,0,Initial value should be 0)](test/Counter.t.sol#L18)
		- [(status) = HEVM_ADDRESS.call(abi.encodePacked(bytes4(keccak256(bytes)(store(address,bytes32,bytes32))),abi.encode(HEVM_ADDRESS,bytes32(failed),bytes32(uint256(0x01)))))](lib/forge-std/lib/ds-test/src/test.sol#L67-L72)
	State variables written after the call(s):
	- [assertEq(value,0,Initial value should be 0)](test/Counter.t.sol#L18)
		- [_failed = true](lib/forge-std/lib/ds-test/src/test.sol#L75)

test/Counter.t.sol#L14-L35


 - [ ] ID-36
Reentrancy in [FlipperFacetTest.testFlip()](test/Flipper.t.sol#L13-L32):
	External calls:
	- [(None,result) = address(diamond).call(abi.encodeWithSelector(0x6d4ce63c))](test/Flipper.t.sol#L15)
	- [assertEq(value,false,Initial value should be false)](test/Flipper.t.sol#L17)
		- [(status) = HEVM_ADDRESS.call(abi.encodePacked(bytes4(keccak256(bytes)(store(address,bytes32,bytes32))),abi.encode(HEVM_ADDRESS,bytes32(failed),bytes32(uint256(0x01)))))](lib/forge-std/lib/ds-test/src/test.sol#L67-L72)
	- [address(diamond).call(abi.encodeWithSelector(0xcde4efa9))](test/Flipper.t.sol#L20)
	- [(None,result) = address(diamond).call(abi.encodeWithSelector(0x6d4ce63c))](test/Flipper.t.sol#L22)
	- [assertEq(value2,true,Value should be true after flip)](test/Flipper.t.sol#L24)
		- [(status) = HEVM_ADDRESS.call(abi.encodePacked(bytes4(keccak256(bytes)(store(address,bytes32,bytes32))),abi.encode(HEVM_ADDRESS,bytes32(failed),bytes32(uint256(0x01)))))](lib/forge-std/lib/ds-test/src/test.sol#L67-L72)
	- [address(diamond).call(abi.encodeWithSelector(0xcde4efa9))](test/Flipper.t.sol#L27)
	- [(None,result) = address(diamond).call(abi.encodeWithSelector(0x6d4ce63c))](test/Flipper.t.sol#L29)
	- [assertEq(value3,false,Value should be false after flip)](test/Flipper.t.sol#L31)
		- [(status) = HEVM_ADDRESS.call(abi.encodePacked(bytes4(keccak256(bytes)(store(address,bytes32,bytes32))),abi.encode(HEVM_ADDRESS,bytes32(failed),bytes32(uint256(0x01)))))](lib/forge-std/lib/ds-test/src/test.sol#L67-L72)
	State variables written after the call(s):
	- [assertEq(value3,false,Value should be false after flip)](test/Flipper.t.sol#L31)
		- [_failed = true](lib/forge-std/lib/ds-test/src/test.sol#L75)

test/Flipper.t.sol#L13-L32


 - [ ] ID-37
Reentrancy in [FlipperFacetTest.testFlip()](test/Flipper.t.sol#L13-L32):
	External calls:
	- [(None,result) = address(diamond).call(abi.encodeWithSelector(0x6d4ce63c))](test/Flipper.t.sol#L15)
	- [assertEq(value,false,Initial value should be false)](test/Flipper.t.sol#L17)
		- [(status) = HEVM_ADDRESS.call(abi.encodePacked(bytes4(keccak256(bytes)(store(address,bytes32,bytes32))),abi.encode(HEVM_ADDRESS,bytes32(failed),bytes32(uint256(0x01)))))](lib/forge-std/lib/ds-test/src/test.sol#L67-L72)
	State variables written after the call(s):
	- [assertEq(value,false,Initial value should be false)](test/Flipper.t.sol#L17)
		- [_failed = true](lib/forge-std/lib/ds-test/src/test.sol#L75)

test/Flipper.t.sol#L13-L32


 - [ ] ID-38
Reentrancy in [CounterFacetTest.testCounter()](test/Counter.t.sol#L14-L35):
	External calls:
	- [(None,result) = address(diamond).call(abi.encodeWithSelector(0x8ada066e))](test/Counter.t.sol#L16)
	State variables written after the call(s):
	- [value = abi.decode(result,(uint256))](test/Counter.t.sol#L17)

test/Counter.t.sol#L14-L35


## reentrancy-events
Impact: Low
Confidence: Medium
 - [ ] ID-39
Reentrancy in [stdStorageSafe.find(StdStorage)](lib/forge-std/src/StdStorage.sol#L32-L105):
	External calls:
	- [vm.record()](lib/forge-std/src/StdStorage.sol#L43)
	- [(reads) = vm.accesses(address(who))](lib/forge-std/src/StdStorage.sol#L50)
	Event emitted after the call(s):
	- [SlotFound(who,fsig,keccak256(bytes)(abi.encodePacked(ins,field_depth)),uint256(reads[0]))](lib/forge-std/src/StdStorage.sol#L62)
	- [WARNING_UninitedSlot(who,uint256(reads[0]))](lib/forge-std/src/StdStorage.sol#L54)

lib/forge-std/src/StdStorage.sol#L32-L105


 - [ ] ID-40
Reentrancy in [CounterFacetTest.testCounter()](test/Counter.t.sol#L14-L35):
	External calls:
	- [(None,result) = address(diamond).call(abi.encodeWithSelector(0x8ada066e))](test/Counter.t.sol#L16)
	- [assertEq(value,0,Initial value should be 0)](test/Counter.t.sol#L18)
		- [(status) = HEVM_ADDRESS.call(abi.encodePacked(bytes4(keccak256(bytes)(store(address,bytes32,bytes32))),abi.encode(HEVM_ADDRESS,bytes32(failed),bytes32(uint256(0x01)))))](lib/forge-std/lib/ds-test/src/test.sol#L67-L72)
	- [address(diamond).call(abi.encodeWithSelector(0xd09de08a))](test/Counter.t.sol#L21)
	- [address(diamond).call(abi.encodeWithSelector(0xd09de08a))](test/Counter.t.sol#L23)
	- [(None,result) = address(diamond).call(abi.encodeWithSelector(0x8ada066e))](test/Counter.t.sol#L25)
	- [assertEq(value,2,Double incremented value should be 2)](test/Counter.t.sol#L27)
		- [(status) = HEVM_ADDRESS.call(abi.encodePacked(bytes4(keccak256(bytes)(store(address,bytes32,bytes32))),abi.encode(HEVM_ADDRESS,bytes32(failed),bytes32(uint256(0x01)))))](lib/forge-std/lib/ds-test/src/test.sol#L67-L72)
	Event emitted after the call(s):
	- [log(Error: a == b not satisfied [uint])](lib/forge-std/lib/ds-test/src/test.sol#L159)
		- [assertEq(value,2,Double incremented value should be 2)](test/Counter.t.sol#L27)
	- [log_named_string(Error,err)](lib/forge-std/lib/ds-test/src/test.sol#L167)
		- [assertEq(value,2,Double incremented value should be 2)](test/Counter.t.sol#L27)
	- [log_named_uint(      Left,a)](lib/forge-std/lib/ds-test/src/test.sol#L160)
		- [assertEq(value,2,Double incremented value should be 2)](test/Counter.t.sol#L27)
	- [log_named_uint(     Right,b)](lib/forge-std/lib/ds-test/src/test.sol#L161)
		- [assertEq(value,2,Double incremented value should be 2)](test/Counter.t.sol#L27)

test/Counter.t.sol#L14-L35


 - [ ] ID-41
Reentrancy in [stdStorageSafe.find(StdStorage)](lib/forge-std/src/StdStorage.sol#L32-L105):
	External calls:
	- [vm.record()](lib/forge-std/src/StdStorage.sol#L43)
	- [(reads) = vm.accesses(address(who))](lib/forge-std/src/StdStorage.sol#L50)
	- [vm.store(who,reads[i],bytes32(7))](lib/forge-std/src/StdStorage.sol#L72)
	- [vm.store(who,reads[i],prev)](lib/forge-std/src/StdStorage.sol#L88)
	Event emitted after the call(s):
	- [SlotFound(who,fsig,keccak256(bytes)(abi.encodePacked(ins,field_depth)),uint256(reads[i]))](lib/forge-std/src/StdStorage.sol#L82)
	- [WARNING_UninitedSlot(who,uint256(reads[i]))](lib/forge-std/src/StdStorage.sol#L69)

lib/forge-std/src/StdStorage.sol#L32-L105


 - [ ] ID-42
Reentrancy in [DiamondCut.diamondCut(IDiamondCut.FacetCut[],address,bytes)](src/diamond/Diamond.Cut.sol#L58-L103):
	External calls:
	- [(success) = _constructor.delegatecall(_calldata)](src/diamond/Diamond.Cut.sol#L95)
	Event emitted after the call(s):
	- [DiamondCuted(facetCutsToBytes(_diamondCut),_constructor,_calldata)](src/diamond/Diamond.Cut.sol#L102)

src/diamond/Diamond.Cut.sol#L58-L103


 - [ ] ID-43
Reentrancy in [StdAssertions.assertEqCall(address,bytes,address,bytes,bool)](lib/forge-std/src/StdAssertions.sol#L344-L375):
	External calls:
	- [(successA,returnDataA) = address(targetA).call(callDataA)](lib/forge-std/src/StdAssertions.sol#L351)
	- [(successB,returnDataB) = address(targetB).call(callDataB)](lib/forge-std/src/StdAssertions.sol#L352)
	- [assertEq(returnDataA,returnDataB,Call return data does not match)](lib/forge-std/src/StdAssertions.sol#L355)
		- [(status) = HEVM_ADDRESS.call(abi.encodePacked(bytes4(keccak256(bytes)(store(address,bytes32,bytes32))),abi.encode(HEVM_ADDRESS,bytes32(failed),bytes32(uint256(0x01)))))](lib/forge-std/lib/ds-test/src/test.sol#L67-L72)
	Event emitted after the call(s):
	- [log(Error: a == b not satisfied [bytes])](lib/forge-std/lib/ds-test/src/test.sol#L457)
		- [assertEq(returnDataA,returnDataB,Call return data does not match)](lib/forge-std/src/StdAssertions.sol#L355)
	- [log_named_bytes(      Left,a)](lib/forge-std/lib/ds-test/src/test.sol#L458)
		- [assertEq(returnDataA,returnDataB,Call return data does not match)](lib/forge-std/src/StdAssertions.sol#L355)
	- [log_named_bytes(     Right,b)](lib/forge-std/lib/ds-test/src/test.sol#L459)
		- [assertEq(returnDataA,returnDataB,Call return data does not match)](lib/forge-std/src/StdAssertions.sol#L355)
	- [log_named_string(Error,err)](lib/forge-std/lib/ds-test/src/test.sol#L465)
		- [assertEq(returnDataA,returnDataB,Call return data does not match)](lib/forge-std/src/StdAssertions.sol#L355)

lib/forge-std/src/StdAssertions.sol#L344-L375


 - [ ] ID-44
Reentrancy in [FlipperFacetTest.testFlip()](test/Flipper.t.sol#L13-L32):
	External calls:
	- [(None,result) = address(diamond).call(abi.encodeWithSelector(0x6d4ce63c))](test/Flipper.t.sol#L15)
	- [assertEq(value,false,Initial value should be false)](test/Flipper.t.sol#L17)
		- [(status) = HEVM_ADDRESS.call(abi.encodePacked(bytes4(keccak256(bytes)(store(address,bytes32,bytes32))),abi.encode(HEVM_ADDRESS,bytes32(failed),bytes32(uint256(0x01)))))](lib/forge-std/lib/ds-test/src/test.sol#L67-L72)
	Event emitted after the call(s):
	- [log(Error: a == b not satisfied [bool])](lib/forge-std/src/StdAssertions.sol#L30)
		- [assertEq(value,false,Initial value should be false)](test/Flipper.t.sol#L17)
	- [log_named_string(Error,err)](lib/forge-std/src/StdAssertions.sol#L39)
		- [assertEq(value,false,Initial value should be false)](test/Flipper.t.sol#L17)
	- [log_named_string(      Left,true)](lib/forge-std/src/StdAssertions.sol#L31)
		- [assertEq(value,false,Initial value should be false)](test/Flipper.t.sol#L17)
	- [log_named_string(      Left,false)](lib/forge-std/src/StdAssertions.sol#L31)
		- [assertEq(value,false,Initial value should be false)](test/Flipper.t.sol#L17)
	- [log_named_string(     Right,true)](lib/forge-std/src/StdAssertions.sol#L32)
		- [assertEq(value,false,Initial value should be false)](test/Flipper.t.sol#L17)
	- [log_named_string(     Right,false)](lib/forge-std/src/StdAssertions.sol#L32)
		- [assertEq(value,false,Initial value should be false)](test/Flipper.t.sol#L17)

test/Flipper.t.sol#L13-L32


 - [ ] ID-45
Reentrancy in [CounterFacetTest.testCounter()](test/Counter.t.sol#L14-L35):
	External calls:
	- [(None,result) = address(diamond).call(abi.encodeWithSelector(0x8ada066e))](test/Counter.t.sol#L16)
	- [assertEq(value,0,Initial value should be 0)](test/Counter.t.sol#L18)
		- [(status) = HEVM_ADDRESS.call(abi.encodePacked(bytes4(keccak256(bytes)(store(address,bytes32,bytes32))),abi.encode(HEVM_ADDRESS,bytes32(failed),bytes32(uint256(0x01)))))](lib/forge-std/lib/ds-test/src/test.sol#L67-L72)
	- [address(diamond).call(abi.encodeWithSelector(0xd09de08a))](test/Counter.t.sol#L21)
	- [address(diamond).call(abi.encodeWithSelector(0xd09de08a))](test/Counter.t.sol#L23)
	- [(None,result) = address(diamond).call(abi.encodeWithSelector(0x8ada066e))](test/Counter.t.sol#L25)
	- [assertEq(value,2,Double incremented value should be 2)](test/Counter.t.sol#L27)
		- [(status) = HEVM_ADDRESS.call(abi.encodePacked(bytes4(keccak256(bytes)(store(address,bytes32,bytes32))),abi.encode(HEVM_ADDRESS,bytes32(failed),bytes32(uint256(0x01)))))](lib/forge-std/lib/ds-test/src/test.sol#L67-L72)
	- [address(diamond).call(abi.encodeWithSelector(0x2baeceb7))](test/Counter.t.sol#L30)
	- [(None,result) = address(diamond).call(abi.encodeWithSelector(0x8ada066e))](test/Counter.t.sol#L32)
	- [assertEq(value,1,Decremented value should be 1)](test/Counter.t.sol#L34)
		- [(status) = HEVM_ADDRESS.call(abi.encodePacked(bytes4(keccak256(bytes)(store(address,bytes32,bytes32))),abi.encode(HEVM_ADDRESS,bytes32(failed),bytes32(uint256(0x01)))))](lib/forge-std/lib/ds-test/src/test.sol#L67-L72)
	Event emitted after the call(s):
	- [log(Error: a == b not satisfied [uint])](lib/forge-std/lib/ds-test/src/test.sol#L159)
		- [assertEq(value,1,Decremented value should be 1)](test/Counter.t.sol#L34)
	- [log_named_string(Error,err)](lib/forge-std/lib/ds-test/src/test.sol#L167)
		- [assertEq(value,1,Decremented value should be 1)](test/Counter.t.sol#L34)
	- [log_named_uint(      Left,a)](lib/forge-std/lib/ds-test/src/test.sol#L160)
		- [assertEq(value,1,Decremented value should be 1)](test/Counter.t.sol#L34)
	- [log_named_uint(     Right,b)](lib/forge-std/lib/ds-test/src/test.sol#L161)
		- [assertEq(value,1,Decremented value should be 1)](test/Counter.t.sol#L34)

test/Counter.t.sol#L14-L35


 - [ ] ID-46
Reentrancy in [CounterFacetTest.testCounter()](test/Counter.t.sol#L14-L35):
	External calls:
	- [(None,result) = address(diamond).call(abi.encodeWithSelector(0x8ada066e))](test/Counter.t.sol#L16)
	- [assertEq(value,0,Initial value should be 0)](test/Counter.t.sol#L18)
		- [(status) = HEVM_ADDRESS.call(abi.encodePacked(bytes4(keccak256(bytes)(store(address,bytes32,bytes32))),abi.encode(HEVM_ADDRESS,bytes32(failed),bytes32(uint256(0x01)))))](lib/forge-std/lib/ds-test/src/test.sol#L67-L72)
	Event emitted after the call(s):
	- [log(Error: a == b not satisfied [uint])](lib/forge-std/lib/ds-test/src/test.sol#L159)
		- [assertEq(value,0,Initial value should be 0)](test/Counter.t.sol#L18)
	- [log_named_string(Error,err)](lib/forge-std/lib/ds-test/src/test.sol#L167)
		- [assertEq(value,0,Initial value should be 0)](test/Counter.t.sol#L18)
	- [log_named_uint(      Left,a)](lib/forge-std/lib/ds-test/src/test.sol#L160)
		- [assertEq(value,0,Initial value should be 0)](test/Counter.t.sol#L18)
	- [log_named_uint(     Right,b)](lib/forge-std/lib/ds-test/src/test.sol#L161)
		- [assertEq(value,0,Initial value should be 0)](test/Counter.t.sol#L18)

test/Counter.t.sol#L14-L35


 - [ ] ID-47
Reentrancy in [FlipperFacetTest.testFlip()](test/Flipper.t.sol#L13-L32):
	External calls:
	- [(None,result) = address(diamond).call(abi.encodeWithSelector(0x6d4ce63c))](test/Flipper.t.sol#L15)
	- [assertEq(value,false,Initial value should be false)](test/Flipper.t.sol#L17)
		- [(status) = HEVM_ADDRESS.call(abi.encodePacked(bytes4(keccak256(bytes)(store(address,bytes32,bytes32))),abi.encode(HEVM_ADDRESS,bytes32(failed),bytes32(uint256(0x01)))))](lib/forge-std/lib/ds-test/src/test.sol#L67-L72)
	- [address(diamond).call(abi.encodeWithSelector(0xcde4efa9))](test/Flipper.t.sol#L20)
	- [(None,result) = address(diamond).call(abi.encodeWithSelector(0x6d4ce63c))](test/Flipper.t.sol#L22)
	- [assertEq(value2,true,Value should be true after flip)](test/Flipper.t.sol#L24)
		- [(status) = HEVM_ADDRESS.call(abi.encodePacked(bytes4(keccak256(bytes)(store(address,bytes32,bytes32))),abi.encode(HEVM_ADDRESS,bytes32(failed),bytes32(uint256(0x01)))))](lib/forge-std/lib/ds-test/src/test.sol#L67-L72)
	Event emitted after the call(s):
	- [log(Error: a == b not satisfied [bool])](lib/forge-std/src/StdAssertions.sol#L30)
		- [assertEq(value2,true,Value should be true after flip)](test/Flipper.t.sol#L24)
	- [log_named_string(Error,err)](lib/forge-std/src/StdAssertions.sol#L39)
		- [assertEq(value2,true,Value should be true after flip)](test/Flipper.t.sol#L24)
	- [log_named_string(      Left,true)](lib/forge-std/src/StdAssertions.sol#L31)
		- [assertEq(value2,true,Value should be true after flip)](test/Flipper.t.sol#L24)
	- [log_named_string(      Left,false)](lib/forge-std/src/StdAssertions.sol#L31)
		- [assertEq(value2,true,Value should be true after flip)](test/Flipper.t.sol#L24)
	- [log_named_string(     Right,true)](lib/forge-std/src/StdAssertions.sol#L32)
		- [assertEq(value2,true,Value should be true after flip)](test/Flipper.t.sol#L24)
	- [log_named_string(     Right,false)](lib/forge-std/src/StdAssertions.sol#L32)
		- [assertEq(value2,true,Value should be true after flip)](test/Flipper.t.sol#L24)

test/Flipper.t.sol#L13-L32


 - [ ] ID-48
Reentrancy in [FlipperFacetTest.testFlip()](test/Flipper.t.sol#L13-L32):
	External calls:
	- [(None,result) = address(diamond).call(abi.encodeWithSelector(0x6d4ce63c))](test/Flipper.t.sol#L15)
	- [assertEq(value,false,Initial value should be false)](test/Flipper.t.sol#L17)
		- [(status) = HEVM_ADDRESS.call(abi.encodePacked(bytes4(keccak256(bytes)(store(address,bytes32,bytes32))),abi.encode(HEVM_ADDRESS,bytes32(failed),bytes32(uint256(0x01)))))](lib/forge-std/lib/ds-test/src/test.sol#L67-L72)
	- [address(diamond).call(abi.encodeWithSelector(0xcde4efa9))](test/Flipper.t.sol#L20)
	- [(None,result) = address(diamond).call(abi.encodeWithSelector(0x6d4ce63c))](test/Flipper.t.sol#L22)
	- [assertEq(value2,true,Value should be true after flip)](test/Flipper.t.sol#L24)
		- [(status) = HEVM_ADDRESS.call(abi.encodePacked(bytes4(keccak256(bytes)(store(address,bytes32,bytes32))),abi.encode(HEVM_ADDRESS,bytes32(failed),bytes32(uint256(0x01)))))](lib/forge-std/lib/ds-test/src/test.sol#L67-L72)
	- [address(diamond).call(abi.encodeWithSelector(0xcde4efa9))](test/Flipper.t.sol#L27)
	- [(None,result) = address(diamond).call(abi.encodeWithSelector(0x6d4ce63c))](test/Flipper.t.sol#L29)
	- [assertEq(value3,false,Value should be false after flip)](test/Flipper.t.sol#L31)
		- [(status) = HEVM_ADDRESS.call(abi.encodePacked(bytes4(keccak256(bytes)(store(address,bytes32,bytes32))),abi.encode(HEVM_ADDRESS,bytes32(failed),bytes32(uint256(0x01)))))](lib/forge-std/lib/ds-test/src/test.sol#L67-L72)
	Event emitted after the call(s):
	- [log(Error: a == b not satisfied [bool])](lib/forge-std/src/StdAssertions.sol#L30)
		- [assertEq(value3,false,Value should be false after flip)](test/Flipper.t.sol#L31)
	- [log_named_string(Error,err)](lib/forge-std/src/StdAssertions.sol#L39)
		- [assertEq(value3,false,Value should be false after flip)](test/Flipper.t.sol#L31)
	- [log_named_string(      Left,true)](lib/forge-std/src/StdAssertions.sol#L31)
		- [assertEq(value3,false,Value should be false after flip)](test/Flipper.t.sol#L31)
	- [log_named_string(      Left,false)](lib/forge-std/src/StdAssertions.sol#L31)
		- [assertEq(value3,false,Value should be false after flip)](test/Flipper.t.sol#L31)
	- [log_named_string(     Right,true)](lib/forge-std/src/StdAssertions.sol#L32)
		- [assertEq(value3,false,Value should be false after flip)](test/Flipper.t.sol#L31)
	- [log_named_string(     Right,false)](lib/forge-std/src/StdAssertions.sol#L32)
		- [assertEq(value3,false,Value should be false after flip)](test/Flipper.t.sol#L31)

test/Flipper.t.sol#L13-L32


 - [ ] ID-49
Reentrancy in [StdAssertions.assertEqCall(address,bytes,address,bytes,bool)](lib/forge-std/src/StdAssertions.sol#L344-L375):
	External calls:
	- [(successA,returnDataA) = address(targetA).call(callDataA)](lib/forge-std/src/StdAssertions.sol#L351)
	- [(successB,returnDataB) = address(targetB).call(callDataB)](lib/forge-std/src/StdAssertions.sol#L352)
	- [assertEq(returnDataA,returnDataB,Call return data does not match)](lib/forge-std/src/StdAssertions.sol#L355)
		- [(status) = HEVM_ADDRESS.call(abi.encodePacked(bytes4(keccak256(bytes)(store(address,bytes32,bytes32))),abi.encode(HEVM_ADDRESS,bytes32(failed),bytes32(uint256(0x01)))))](lib/forge-std/lib/ds-test/src/test.sol#L67-L72)
	- [assertEq(returnDataA,returnDataB,Call revert data does not match)](lib/forge-std/src/StdAssertions.sol#L359)
		- [(status) = HEVM_ADDRESS.call(abi.encodePacked(bytes4(keccak256(bytes)(store(address,bytes32,bytes32))),abi.encode(HEVM_ADDRESS,bytes32(failed),bytes32(uint256(0x01)))))](lib/forge-std/lib/ds-test/src/test.sol#L67-L72)
	- [fail()](lib/forge-std/src/StdAssertions.sol#L366)
		- [(status) = HEVM_ADDRESS.call(abi.encodePacked(bytes4(keccak256(bytes)(store(address,bytes32,bytes32))),abi.encode(HEVM_ADDRESS,bytes32(failed),bytes32(uint256(0x01)))))](lib/forge-std/lib/ds-test/src/test.sol#L67-L72)
	Event emitted after the call(s):
	- [log(Error: Calls were not equal)](lib/forge-std/src/StdAssertions.sol#L370)
	- [log_named_bytes(  Left call return data,returnDataA)](lib/forge-std/src/StdAssertions.sol#L371)
	- [log_named_bytes( Right call revert data,returnDataB)](lib/forge-std/src/StdAssertions.sol#L372)

lib/forge-std/src/StdAssertions.sol#L344-L375


 - [ ] ID-50
Reentrancy in [StdAssertions.assertEqCall(address,bytes,address,bytes,bool)](lib/forge-std/src/StdAssertions.sol#L344-L375):
	External calls:
	- [(successA,returnDataA) = address(targetA).call(callDataA)](lib/forge-std/src/StdAssertions.sol#L351)
	- [(successB,returnDataB) = address(targetB).call(callDataB)](lib/forge-std/src/StdAssertions.sol#L352)
	- [assertEq(returnDataA,returnDataB,Call return data does not match)](lib/forge-std/src/StdAssertions.sol#L355)
		- [(status) = HEVM_ADDRESS.call(abi.encodePacked(bytes4(keccak256(bytes)(store(address,bytes32,bytes32))),abi.encode(HEVM_ADDRESS,bytes32(failed),bytes32(uint256(0x01)))))](lib/forge-std/lib/ds-test/src/test.sol#L67-L72)
	- [assertEq(returnDataA,returnDataB,Call revert data does not match)](lib/forge-std/src/StdAssertions.sol#L359)
		- [(status) = HEVM_ADDRESS.call(abi.encodePacked(bytes4(keccak256(bytes)(store(address,bytes32,bytes32))),abi.encode(HEVM_ADDRESS,bytes32(failed),bytes32(uint256(0x01)))))](lib/forge-std/lib/ds-test/src/test.sol#L67-L72)
	Event emitted after the call(s):
	- [log(Error: a == b not satisfied [bytes])](lib/forge-std/lib/ds-test/src/test.sol#L457)
		- [assertEq(returnDataA,returnDataB,Call revert data does not match)](lib/forge-std/src/StdAssertions.sol#L359)
	- [log(Error: Calls were not equal)](lib/forge-std/src/StdAssertions.sol#L363)
	- [log_named_bytes(      Left,a)](lib/forge-std/lib/ds-test/src/test.sol#L458)
		- [assertEq(returnDataA,returnDataB,Call revert data does not match)](lib/forge-std/src/StdAssertions.sol#L359)
	- [log_named_bytes(     Right,b)](lib/forge-std/lib/ds-test/src/test.sol#L459)
		- [assertEq(returnDataA,returnDataB,Call revert data does not match)](lib/forge-std/src/StdAssertions.sol#L359)
	- [log_named_bytes(  Left call revert data,returnDataA)](lib/forge-std/src/StdAssertions.sol#L364)
	- [log_named_bytes( Right call return data,returnDataB)](lib/forge-std/src/StdAssertions.sol#L365)
	- [log_named_string(Error,err)](lib/forge-std/lib/ds-test/src/test.sol#L465)
		- [assertEq(returnDataA,returnDataB,Call revert data does not match)](lib/forge-std/src/StdAssertions.sol#L359)

lib/forge-std/src/StdAssertions.sol#L344-L375


## assembly
Impact: Informational
Confidence: High
 - [ ] ID-51
[StdCheatsSafe.assumeNoPrecompiles(address)](lib/forge-std/src/StdCheats.sol#L191-L198) uses assembly
	- [INLINE ASM](lib/forge-std/src/StdCheats.sol#L194-L196)

lib/forge-std/src/StdCheats.sol#L191-L198


 - [ ] ID-52
[StdCheatsSafe.deployCode(string,bytes)](lib/forge-std/src/StdCheats.sol#L361-L369) uses assembly
	- [INLINE ASM](lib/forge-std/src/StdCheats.sol#L364-L366)

lib/forge-std/src/StdCheats.sol#L361-L369


 - [ ] ID-53
[DSTest.hasHEVMContext()](lib/forge-std/lib/ds-test/src/test.sol#L78-L84) uses assembly
	- [INLINE ASM](lib/forge-std/lib/ds-test/src/test.sol#L80-L82)

lib/forge-std/lib/ds-test/src/test.sol#L78-L84


 - [ ] ID-54
[DiamondStorageLib.getDiamondStorage()](src/diamond/Diamond.Storage.Lib.sol#L16-L21) uses assembly
	- [INLINE ASM](src/diamond/Diamond.Storage.Lib.sol#L18-L20)

src/diamond/Diamond.Storage.Lib.sol#L16-L21


 - [ ] ID-55
[Diamond.fallback()](src/diamond/Diamond.sol#L10-L33) uses assembly
	- [INLINE ASM](src/diamond/Diamond.sol#L18-L32)

src/diamond/Diamond.sol#L10-L33


 - [ ] ID-56
[console2._sendLogPayload(bytes)](lib/forge-std/src/console2.sol#L12-L20) uses assembly
	- [INLINE ASM](lib/forge-std/src/console2.sol#L16-L19)

lib/forge-std/src/console2.sol#L12-L20


 - [ ] ID-57
[DiamondLoupe.facetFunctionSelectors(address)](src/diamond/Diamond.Loupe.sol#L20-L42) uses assembly
	- [INLINE ASM](src/diamond/Diamond.Loupe.sol#L39-L41)

src/diamond/Diamond.Loupe.sol#L20-L42


 - [ ] ID-58
[console._sendLogPayload(bytes)](lib/forge-std/src/console.sol#L7-L15) uses assembly
	- [INLINE ASM](lib/forge-std/src/console.sol#L11-L14)

lib/forge-std/src/console.sol#L7-L15


 - [ ] ID-59
[StdCheatsSafe.deployCode(string)](lib/forge-std/src/StdCheats.sol#L371-L379) uses assembly
	- [INLINE ASM](lib/forge-std/src/StdCheats.sol#L374-L376)

lib/forge-std/src/StdCheats.sol#L371-L379


 - [ ] ID-60
[StdUtils.getTokenBalances(address,address[])](lib/forge-std/src/StdUtils.sol#L141-L168) uses assembly
	- [INLINE ASM](lib/forge-std/src/StdUtils.sol#L147-L149)

lib/forge-std/src/StdUtils.sol#L141-L168


 - [ ] ID-61
[stdStorage.checked_write(StdStorage,bool)](lib/forge-std/src/StdStorage.sol#L242-L249) uses assembly
	- [INLINE ASM](lib/forge-std/src/StdStorage.sol#L245-L247)

lib/forge-std/src/StdStorage.sol#L242-L249


 - [ ] ID-62
[StdCheatsSafe.deployCode(string,uint256)](lib/forge-std/src/StdCheats.sol#L392-L400) uses assembly
	- [INLINE ASM](lib/forge-std/src/StdCheats.sol#L395-L397)

lib/forge-std/src/StdCheats.sol#L392-L400


 - [ ] ID-63
[StdCheatsSafe.deployCode(string,bytes,uint256)](lib/forge-std/src/StdCheats.sol#L382-L390) uses assembly
	- [INLINE ASM](lib/forge-std/src/StdCheats.sol#L385-L387)

lib/forge-std/src/StdCheats.sol#L382-L390


 - [ ] ID-64
[stdStorage.flatten(bytes32[])](lib/forge-std/src/StdStorage.sol#L315-L326) uses assembly
	- [INLINE ASM](lib/forge-std/src/StdStorage.sol#L320-L322)

lib/forge-std/src/StdStorage.sol#L315-L326


 - [ ] ID-65
[StdChains.getChainWithUpdatedRpcUrl(string,StdChains.Chain)](lib/forge-std/src/StdChains.sol#L155-L178) uses assembly
	- [INLINE ASM](lib/forge-std/src/StdChains.sol#L171-L173)

lib/forge-std/src/StdChains.sol#L155-L178


 - [ ] ID-66
[stdStorageSafe.flatten(bytes32[])](lib/forge-std/src/StdStorage.sol#L181-L192) uses assembly
	- [INLINE ASM](lib/forge-std/src/StdStorage.sol#L186-L188)

lib/forge-std/src/StdStorage.sol#L181-L192


## pragma
Impact: Informational
Confidence: High
 - [ ] ID-67
Different versions of Solidity are used:
	- Version used: ['>=0.4.22<0.9.0', '>=0.5.0', '>=0.6.0<0.9.0', '>=0.6.2<0.9.0', '^0.8.18', '^0.8.19']
	- [>=0.4.22<0.9.0](lib/forge-std/src/StdStyle.sol#L2)
	- [>=0.4.22<0.9.0](lib/forge-std/src/console.sol#L2)
	- [>=0.4.22<0.9.0](lib/forge-std/src/console2.sol#L2)
	- [>=0.5.0](lib/forge-std/lib/ds-test/src/test.sol#L16)
	- [>=0.6.0<0.9.0](lib/forge-std/src/StdJson.sol#L2)
	- [>=0.6.2<0.9.0](lib/forge-std/src/Base.sol#L2)
	- [>=0.6.2<0.9.0](lib/forge-std/src/StdAssertions.sol#L2)
	- [>=0.6.2<0.9.0](lib/forge-std/src/StdChains.sol#L2)
	- [>=0.6.2<0.9.0](lib/forge-std/src/StdCheats.sol#L2)
	- [>=0.6.2<0.9.0](lib/forge-std/src/StdError.sol#L3)
	- [>=0.6.2<0.9.0](lib/forge-std/src/StdInvariant.sol#L2)
	- [>=0.6.2<0.9.0](lib/forge-std/src/StdMath.sol#L2)
	- [>=0.6.2<0.9.0](lib/forge-std/src/StdStorage.sol#L2)
	- [>=0.6.2<0.9.0](lib/forge-std/src/StdUtils.sol#L2)
	- [>=0.6.2<0.9.0](lib/forge-std/src/Test.sol#L2)
	- [>=0.6.2<0.9.0](lib/forge-std/src/Vm.sol#L2)
	- [>=0.6.2<0.9.0](lib/forge-std/src/interfaces/IMulticall3.sol#L2)
	- [ABIEncoderV2](lib/forge-std/src/StdChains.sol#L4)
	- [ABIEncoderV2](lib/forge-std/src/StdCheats.sol#L4)
	- [ABIEncoderV2](lib/forge-std/src/StdInvariant.sol#L4)
	- [ABIEncoderV2](lib/forge-std/src/StdJson.sol#L4)
	- [ABIEncoderV2](lib/forge-std/src/StdUtils.sol#L4)
	- [ABIEncoderV2](lib/forge-std/src/Test.sol#L4)
	- [ABIEncoderV2](lib/forge-std/src/Vm.sol#L4)
	- [ABIEncoderV2](lib/forge-std/src/interfaces/IMulticall3.sol#L4)
	- [^0.8.18](src/facet/Counter.Facet.sol#L2)
	- [^0.8.18](src/facet/Flipper.Facet.sol#L2)
	- [^0.8.18](test/BaseSetup.sol#L2)
	- [^0.8.18](test/Counter.t.sol#L2)
	- [^0.8.18](test/Flipper.t.sol#L2)
	- [^0.8.19](src/diamond/Diamond.Cut.sol#L2)
	- [^0.8.19](src/diamond/Diamond.Loupe.sol#L2)
	- [^0.8.19](src/diamond/Diamond.Storage.Lib.sol#L2)
	- [^0.8.19](src/diamond/Diamond.sol#L2)
	- [^0.8.19](src/diamond/interfaces/IDiamond.Cut.sol#L2)
	- [^0.8.19](src/diamond/interfaces/IDiamond.Loupe.sol#L2)

lib/forge-std/src/StdStyle.sol#L2


## solc-version
Impact: Informational
Confidence: High
 - [ ] ID-68
Pragma version[>=0.6.2<0.9.0](lib/forge-std/src/StdChains.sol#L2) is too complex

lib/forge-std/src/StdChains.sol#L2


 - [ ] ID-69
Pragma version[>=0.6.2<0.9.0](lib/forge-std/src/Test.sol#L2) is too complex

lib/forge-std/src/Test.sol#L2


 - [ ] ID-70
Pragma version[>=0.6.2<0.9.0](lib/forge-std/src/StdCheats.sol#L2) is too complex

lib/forge-std/src/StdCheats.sol#L2


 - [ ] ID-71
Pragma version[^0.8.19](src/diamond/Diamond.Cut.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.6.12/0.7.6/0.8.16

src/diamond/Diamond.Cut.sol#L2


 - [ ] ID-72
Pragma version[^0.8.19](src/diamond/interfaces/IDiamond.Cut.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.6.12/0.7.6/0.8.16

src/diamond/interfaces/IDiamond.Cut.sol#L2


 - [ ] ID-73
Pragma version[^0.8.19](src/diamond/Diamond.Loupe.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.6.12/0.7.6/0.8.16

src/diamond/Diamond.Loupe.sol#L2


 - [ ] ID-74
Pragma version[^0.8.19](src/diamond/interfaces/IDiamond.Loupe.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.6.12/0.7.6/0.8.16

src/diamond/interfaces/IDiamond.Loupe.sol#L2


 - [ ] ID-75
Pragma version[>=0.6.2<0.9.0](lib/forge-std/src/StdMath.sol#L2) is too complex

lib/forge-std/src/StdMath.sol#L2


 - [ ] ID-76
Pragma version[>=0.6.2<0.9.0](lib/forge-std/src/StdAssertions.sol#L2) is too complex

lib/forge-std/src/StdAssertions.sol#L2


 - [ ] ID-77
Pragma version[^0.8.18](test/Counter.t.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.6.12/0.7.6/0.8.16

test/Counter.t.sol#L2


 - [ ] ID-78
Pragma version[>=0.6.2<0.9.0](lib/forge-std/src/Vm.sol#L2) is too complex

lib/forge-std/src/Vm.sol#L2


 - [ ] ID-79
Pragma version[^0.8.18](test/BaseSetup.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.6.12/0.7.6/0.8.16

test/BaseSetup.sol#L2


 - [ ] ID-80
Pragma version[>=0.4.22<0.9.0](lib/forge-std/src/StdStyle.sol#L2) is too complex

lib/forge-std/src/StdStyle.sol#L2


 - [ ] ID-81
Pragma version[>=0.6.2<0.9.0](lib/forge-std/src/StdUtils.sol#L2) is too complex

lib/forge-std/src/StdUtils.sol#L2


 - [ ] ID-82
Pragma version[>=0.4.22<0.9.0](lib/forge-std/src/console.sol#L2) is too complex

lib/forge-std/src/console.sol#L2


 - [ ] ID-83
Pragma version[>=0.6.0<0.9.0](lib/forge-std/src/StdJson.sol#L2) is too complex

lib/forge-std/src/StdJson.sol#L2


 - [ ] ID-84
Pragma version[^0.8.18](src/facet/Flipper.Facet.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.6.12/0.7.6/0.8.16

src/facet/Flipper.Facet.sol#L2


 - [ ] ID-85
Pragma version[>=0.4.22<0.9.0](lib/forge-std/src/console2.sol#L2) is too complex

lib/forge-std/src/console2.sol#L2


 - [ ] ID-86
Pragma version[>=0.6.2<0.9.0](lib/forge-std/src/interfaces/IMulticall3.sol#L2) is too complex

lib/forge-std/src/interfaces/IMulticall3.sol#L2


 - [ ] ID-87
solc-0.8.19 is not recommended for deployment

 - [ ] ID-88
Pragma version[>=0.6.2<0.9.0](lib/forge-std/src/Base.sol#L2) is too complex

lib/forge-std/src/Base.sol#L2


 - [ ] ID-89
Pragma version[^0.8.18](test/Flipper.t.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.6.12/0.7.6/0.8.16

test/Flipper.t.sol#L2


 - [ ] ID-90
Pragma version[>=0.5.0](lib/forge-std/lib/ds-test/src/test.sol#L16) allows old versions

lib/forge-std/lib/ds-test/src/test.sol#L16


 - [ ] ID-91
Pragma version[^0.8.19](src/diamond/Diamond.Storage.Lib.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.6.12/0.7.6/0.8.16

src/diamond/Diamond.Storage.Lib.sol#L2


 - [ ] ID-92
Pragma version[^0.8.19](src/diamond/Diamond.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.6.12/0.7.6/0.8.16

src/diamond/Diamond.sol#L2


 - [ ] ID-93
Pragma version[^0.8.18](src/facet/Counter.Facet.sol#L2) necessitates a version too recent to be trusted. Consider deploying with 0.6.12/0.7.6/0.8.16

src/facet/Counter.Facet.sol#L2


 - [ ] ID-94
Pragma version[>=0.6.2<0.9.0](lib/forge-std/src/StdError.sol#L3) is too complex

lib/forge-std/src/StdError.sol#L3


 - [ ] ID-95
Pragma version[>=0.6.2<0.9.0](lib/forge-std/src/StdStorage.sol#L2) is too complex

lib/forge-std/src/StdStorage.sol#L2


 - [ ] ID-96
Pragma version[>=0.6.2<0.9.0](lib/forge-std/src/StdInvariant.sol#L2) is too complex

lib/forge-std/src/StdInvariant.sol#L2


## low-level-calls
Impact: Informational
Confidence: High
 - [ ] ID-97
Low level call in [StdUtils.console2_log(string,uint256)](lib/forge-std/src/StdUtils.sol#L180-L183):
	- [(status) = address(CONSOLE2_ADDRESS).staticcall(abi.encodeWithSignature(log(string,uint256),p0,p1))](lib/forge-std/src/StdUtils.sol#L181)

lib/forge-std/src/StdUtils.sol#L180-L183


 - [ ] ID-98
Low level call in [StdAssertions.assertEqCall(address,bytes,address,bytes,bool)](lib/forge-std/src/StdAssertions.sol#L344-L375):
	- [(successA,returnDataA) = address(targetA).call(callDataA)](lib/forge-std/src/StdAssertions.sol#L351)
	- [(successB,returnDataB) = address(targetB).call(callDataB)](lib/forge-std/src/StdAssertions.sol#L352)

lib/forge-std/src/StdAssertions.sol#L344-L375


 - [ ] ID-99
Low level call in [stdStorageSafe.find(StdStorage)](lib/forge-std/src/StdStorage.sol#L32-L105):
	- [(rdat) = who.staticcall(cald)](lib/forge-std/src/StdStorage.sol#L46)
	- [(success,rdat_scope_0) = who.staticcall(cald)](lib/forge-std/src/StdStorage.sol#L76)

lib/forge-std/src/StdStorage.sol#L32-L105


 - [ ] ID-100
Low level call in [DSTest.fail()](lib/forge-std/lib/ds-test/src/test.sol#L65-L76):
	- [(status) = HEVM_ADDRESS.call(abi.encodePacked(bytes4(keccak256(bytes)(store(address,bytes32,bytes32))),abi.encode(HEVM_ADDRESS,bytes32(failed),bytes32(uint256(0x01)))))](lib/forge-std/lib/ds-test/src/test.sol#L67-L72)

lib/forge-std/lib/ds-test/src/test.sol#L65-L76


 - [ ] ID-101
Low level call in [StdCheats.deal(address,address,uint256,bool)](lib/forge-std/src/StdCheats.sol#L563-L582):
	- [(balData) = token.call(abi.encodeWithSelector(0x70a08231,to))](lib/forge-std/src/StdCheats.sol#L565)
	- [(totSupData) = token.call(abi.encodeWithSelector(0x18160ddd))](lib/forge-std/src/StdCheats.sol#L573)

lib/forge-std/src/StdCheats.sol#L563-L582


 - [ ] ID-102
Low level call in [StdCheats.dealERC721(address,address,uint256)](lib/forge-std/src/StdCheats.sol#L609-L628):
	- [(successMinted,ownerData) = token.staticcall(abi.encodeWithSelector(0x6352211e,id))](lib/forge-std/src/StdCheats.sol#L611)
	- [(fromBalData) = token.call(abi.encodeWithSelector(0x70a08231,abi.decode(ownerData,(address))))](lib/forge-std/src/StdCheats.sol#L615)
	- [(toBalData) = token.call(abi.encodeWithSelector(0x70a08231,to))](lib/forge-std/src/StdCheats.sol#L619)

lib/forge-std/src/StdCheats.sol#L609-L628


 - [ ] ID-103
Low level call in [StdCheatsSafe.assumePayable(address)](lib/forge-std/src/StdCheats.sol#L469-L472):
	- [(success) = address(addr).call{value: 0}()](lib/forge-std/src/StdCheats.sol#L470)

lib/forge-std/src/StdCheats.sol#L469-L472


 - [ ] ID-104
Low level call in [CounterFacetTest.testCounter()](test/Counter.t.sol#L14-L35):
	- [(None,result) = address(diamond).call(abi.encodeWithSelector(0x8ada066e))](test/Counter.t.sol#L16)
	- [address(diamond).call(abi.encodeWithSelector(0xd09de08a))](test/Counter.t.sol#L21)
	- [address(diamond).call(abi.encodeWithSelector(0xd09de08a))](test/Counter.t.sol#L23)
	- [(None,result) = address(diamond).call(abi.encodeWithSelector(0x8ada066e))](test/Counter.t.sol#L25)
	- [address(diamond).call(abi.encodeWithSelector(0x2baeceb7))](test/Counter.t.sol#L30)
	- [(None,result) = address(diamond).call(abi.encodeWithSelector(0x8ada066e))](test/Counter.t.sol#L32)

test/Counter.t.sol#L14-L35


 - [ ] ID-105
Low level call in [StdCheats.dealERC1155(address,address,uint256,uint256,bool)](lib/forge-std/src/StdCheats.sol#L584-L607):
	- [(balData) = token.call(abi.encodeWithSelector(0x00fdd58e,to,id))](lib/forge-std/src/StdCheats.sol#L586)
	- [(totSupData) = token.call(abi.encodeWithSelector(0xbd85b039,id))](lib/forge-std/src/StdCheats.sol#L594)

lib/forge-std/src/StdCheats.sol#L584-L607


 - [ ] ID-106
Low level call in [DSTest.failed()](lib/forge-std/lib/ds-test/src/test.sol#L47-L63):
	- [(retdata) = HEVM_ADDRESS.call(abi.encodePacked(bytes4(keccak256(bytes)(load(address,bytes32))),abi.encode(HEVM_ADDRESS,bytes32(failed))))](lib/forge-std/lib/ds-test/src/test.sol#L53-L58)

lib/forge-std/lib/ds-test/src/test.sol#L47-L63


 - [ ] ID-107
Low level call in [FlipperFacetTest.testFlip()](test/Flipper.t.sol#L13-L32):
	- [(None,result) = address(diamond).call(abi.encodeWithSelector(0x6d4ce63c))](test/Flipper.t.sol#L15)
	- [address(diamond).call(abi.encodeWithSelector(0xcde4efa9))](test/Flipper.t.sol#L20)
	- [(None,result) = address(diamond).call(abi.encodeWithSelector(0x6d4ce63c))](test/Flipper.t.sol#L22)
	- [address(diamond).call(abi.encodeWithSelector(0xcde4efa9))](test/Flipper.t.sol#L27)
	- [(None,result) = address(diamond).call(abi.encodeWithSelector(0x6d4ce63c))](test/Flipper.t.sol#L29)

test/Flipper.t.sol#L13-L32


 - [ ] ID-108
Low level call in [stdStorage.checked_write(StdStorage,bytes32)](lib/forge-std/src/StdStorage.sol#L251-L281):
	- [(rdat) = who.staticcall(cald)](lib/forge-std/src/StdStorage.sol#L265)

lib/forge-std/src/StdStorage.sol#L251-L281


 - [ ] ID-109
Low level call in [StdUtils.console2_log(string,string)](lib/forge-std/src/StdUtils.sol#L185-L188):
	- [(status) = address(CONSOLE2_ADDRESS).staticcall(abi.encodeWithSignature(log(string,string),p0,p1))](lib/forge-std/src/StdUtils.sol#L186)

lib/forge-std/src/StdUtils.sol#L185-L188


 - [ ] ID-110
Low level call in [DiamondCut.diamondCut(IDiamondCut.FacetCut[],address,bytes)](src/diamond/Diamond.Cut.sol#L58-L103):
	- [(success) = _constructor.delegatecall(_calldata)](src/diamond/Diamond.Cut.sol#L95)

src/diamond/Diamond.Cut.sol#L58-L103


## naming-convention
Impact: Informational
Confidence: High
 - [ ] ID-111
Parameter [stdStorage.sig(StdStorage,string)._sig](lib/forge-std/src/StdStorage.sol#L214) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L214


 - [ ] ID-112
Function [stdStorageSafe.read_uint(StdStorage)](lib/forge-std/src/StdStorage.sol#L163-L165) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L163-L165


 - [ ] ID-113
Event [DSTestlog_named_int(string,int256)](lib/forge-std/lib/ds-test/src/test.sol#L33) is not in CapWords

lib/forge-std/lib/ds-test/src/test.sol#L33


 - [ ] ID-114
Parameter [stdStorage.target(StdStorage,address)._target](lib/forge-std/src/StdStorage.sol#L206) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L206


 - [ ] ID-115
Function [stdStorageSafe.read_int(StdStorage)](lib/forge-std/src/StdStorage.sol#L167-L169) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L167-L169


 - [ ] ID-116
Parameter [stdStorageSafe.sig(StdStorage,bytes4)._sig](lib/forge-std/src/StdStorage.sol#L112) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L112


 - [ ] ID-117
Function [stdStorage.checked_write(StdStorage,bytes32)](lib/forge-std/src/StdStorage.sol#L251-L281) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L251-L281


 - [ ] ID-118
Function [StdUtils.console2_log(string,string)](lib/forge-std/src/StdUtils.sol#L185-L188) is not in mixedCase

lib/forge-std/src/StdUtils.sol#L185-L188


 - [ ] ID-119
Constant [StdUtils.multicall](lib/forge-std/src/StdUtils.sol#L15) is not in UPPER_CASE_WITH_UNDERSCORES

lib/forge-std/src/StdUtils.sol#L15


 - [ ] ID-120
Parameter [stdStorage.sig(StdStorage,bytes4)._sig](lib/forge-std/src/StdStorage.sol#L210) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L210


 - [ ] ID-121
Constant [stdError.enumConversionError](lib/forge-std/src/StdError.sol#L9) is not in UPPER_CASE_WITH_UNDERSCORES

lib/forge-std/src/StdError.sol#L9


 - [ ] ID-122
Parameter [DiamondCut.diamondCut(IDiamondCut.FacetCut[],address,bytes)._diamondCut](src/diamond/Diamond.Cut.sol#L58) is not in mixedCase

src/diamond/Diamond.Cut.sol#L58


 - [ ] ID-123
Event [StdAssertionslog_named_array(string,int256[])](lib/forge-std/src/StdAssertions.sol#L12) is not in CapWords

lib/forge-std/src/StdAssertions.sol#L12


 - [ ] ID-124
Constant [stdJson.vm](lib/forge-std/src/StdJson.sol#L30) is not in UPPER_CASE_WITH_UNDERSCORES

lib/forge-std/src/StdJson.sol#L30


 - [ ] ID-125
Contract [console2](lib/forge-std/src/console2.sol#L9-L1547) is not in CapWords

lib/forge-std/src/console2.sol#L9-L1547


 - [ ] ID-126
Event [DSTestlog_string(string)](lib/forge-std/lib/ds-test/src/test.sol#L27) is not in CapWords

lib/forge-std/lib/ds-test/src/test.sol#L27


 - [ ] ID-127
Event [DSTestlog_named_bytes32(string,bytes32)](lib/forge-std/lib/ds-test/src/test.sol#L30) is not in CapWords

lib/forge-std/lib/ds-test/src/test.sol#L30


 - [ ] ID-128
Constant [StdCheatsSafe.vm](lib/forge-std/src/StdCheats.sol#L10) is not in UPPER_CASE_WITH_UNDERSCORES

lib/forge-std/src/StdCheats.sol#L10


 - [ ] ID-129
Function [stdStorage.checked_write(StdStorage,bool)](lib/forge-std/src/StdStorage.sol#L242-L249) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L242-L249


 - [ ] ID-130
Constant [stdError.divisionError](lib/forge-std/src/StdError.sol#L8) is not in UPPER_CASE_WITH_UNDERSCORES

lib/forge-std/src/StdError.sol#L8


 - [ ] ID-131
Event [DSTestlog_bytes32(bytes32)](lib/forge-std/lib/ds-test/src/test.sol#L23) is not in CapWords

lib/forge-std/lib/ds-test/src/test.sol#L23


 - [ ] ID-132
Parameter [DiamondCut.diamondCut(IDiamondCut.FacetCut[],address,bytes)._constructor](src/diamond/Diamond.Cut.sol#L58) is not in mixedCase

src/diamond/Diamond.Cut.sol#L58


 - [ ] ID-133
Function [stdStorageSafe.read_bytes32(StdStorage)](lib/forge-std/src/StdStorage.sol#L148-L150) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L148-L150


 - [ ] ID-134
Function [stdStorage.with_key(StdStorage,bytes32)](lib/forge-std/src/StdStorage.sol#L226-L228) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L226-L228


 - [ ] ID-135
Function [stdStorage.read_uint(StdStorage)](lib/forge-std/src/StdStorage.sol#L295-L297) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L295-L297


 - [ ] ID-136
Constant [StdCheats.vm](lib/forge-std/src/StdCheats.sol#L480) is not in UPPER_CASE_WITH_UNDERSCORES

lib/forge-std/src/StdCheats.sol#L480


 - [ ] ID-137
Event [DSTestlog_named_string(string,string)](lib/forge-std/lib/ds-test/src/test.sol#L36) is not in CapWords

lib/forge-std/lib/ds-test/src/test.sol#L36


 - [ ] ID-138
Event [DSTestlog_named_address(string,address)](lib/forge-std/lib/ds-test/src/test.sol#L29) is not in CapWords

lib/forge-std/lib/ds-test/src/test.sol#L29


 - [ ] ID-139
Event [DSTestlog_address(address)](lib/forge-std/lib/ds-test/src/test.sol#L22) is not in CapWords

lib/forge-std/lib/ds-test/src/test.sol#L22


 - [ ] ID-140
Function [stdStorageSafe.read_address(StdStorage)](lib/forge-std/src/StdStorage.sol#L159-L161) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L159-L161


 - [ ] ID-141
Parameter [stdStorage.depth(StdStorage,uint256)._depth](lib/forge-std/src/StdStorage.sol#L230) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L230


 - [ ] ID-142
Event [StdAssertionslog_array(uint256[])](lib/forge-std/src/StdAssertions.sol#L8) is not in CapWords

lib/forge-std/src/StdAssertions.sol#L8


 - [ ] ID-143
Contract [console](lib/forge-std/src/console.sol#L4-L1534) is not in CapWords

lib/forge-std/src/console.sol#L4-L1534


 - [ ] ID-144
Function [stdStorage.read_int(StdStorage)](lib/forge-std/src/StdStorage.sol#L299-L301) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L299-L301


 - [ ] ID-145
Constant [stdError.encodeStorageError](lib/forge-std/src/StdError.sol#L10) is not in UPPER_CASE_WITH_UNDERSCORES

lib/forge-std/src/StdError.sol#L10


 - [ ] ID-146
Constant [StdChains.vm](lib/forge-std/src/StdChains.sol#L39) is not in UPPER_CASE_WITH_UNDERSCORES

lib/forge-std/src/StdChains.sol#L39


 - [ ] ID-147
Event [DSTestlog_named_decimal_uint(string,uint256,uint256)](lib/forge-std/lib/ds-test/src/test.sol#L32) is not in CapWords

lib/forge-std/lib/ds-test/src/test.sol#L32


 - [ ] ID-148
Parameter [DiamondCut.facetCutsToBytes(IDiamondCut.FacetCut[])._diamondCut](src/diamond/Diamond.Cut.sol#L10) is not in mixedCase

src/diamond/Diamond.Cut.sol#L10


 - [ ] ID-149
Event [StdAssertionslog_named_array(string,uint256[])](lib/forge-std/src/StdAssertions.sol#L11) is not in CapWords

lib/forge-std/src/StdAssertions.sol#L11


 - [ ] ID-150
Function [stdStorage.checked_write(StdStorage,address)](lib/forge-std/src/StdStorage.sol#L234-L236) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L234-L236


 - [ ] ID-151
Function [stdStorage.read_bool(StdStorage)](lib/forge-std/src/StdStorage.sol#L287-L289) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L287-L289


 - [ ] ID-152
Contract [stdStorage](lib/forge-std/src/StdStorage.sol#L195-L327) is not in CapWords

lib/forge-std/src/StdStorage.sol#L195-L327


 - [ ] ID-153
Contract [stdJson](lib/forge-std/src/StdJson.sol#L29-L179) is not in CapWords

lib/forge-std/src/StdJson.sol#L29-L179


 - [ ] ID-154
Constant [stdStorageSafe.vm](lib/forge-std/src/StdStorage.sol#L20) is not in UPPER_CASE_WITH_UNDERSCORES

lib/forge-std/src/StdStorage.sol#L20


 - [ ] ID-155
Event [DSTestlog_named_uint(string,uint256)](lib/forge-std/lib/ds-test/src/test.sol#L34) is not in CapWords

lib/forge-std/lib/ds-test/src/test.sol#L34


 - [ ] ID-156
Constant [StdStyle.vm](lib/forge-std/src/StdStyle.sol#L7) is not in UPPER_CASE_WITH_UNDERSCORES

lib/forge-std/src/StdStyle.sol#L7


 - [ ] ID-157
Constant [stdStorage.vm](lib/forge-std/src/StdStorage.sol#L196) is not in UPPER_CASE_WITH_UNDERSCORES

lib/forge-std/src/StdStorage.sol#L196


 - [ ] ID-158
Constant [ScriptBase.vmSafe](lib/forge-std/src/Base.sol#L32) is not in UPPER_CASE_WITH_UNDERSCORES

lib/forge-std/src/Base.sol#L32


 - [ ] ID-159
Function [stdStorage.with_key(StdStorage,address)](lib/forge-std/src/StdStorage.sol#L218-L220) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L218-L220


 - [ ] ID-160
Function [stdStorage.checked_write(StdStorage,uint256)](lib/forge-std/src/StdStorage.sol#L238-L240) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L238-L240


 - [ ] ID-161
Contract [stdStorageSafe](lib/forge-std/src/StdStorage.sol#L16-L193) is not in CapWords

lib/forge-std/src/StdStorage.sol#L16-L193


 - [ ] ID-162
Event [DSTestlog(string)](lib/forge-std/lib/ds-test/src/test.sol#L19) is not in CapWords

lib/forge-std/lib/ds-test/src/test.sol#L19


 - [ ] ID-163
Function [stdStorageSafe.with_key(StdStorage,address)](lib/forge-std/src/StdStorage.sol#L122-L125) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L122-L125


 - [ ] ID-164
Contract [stdMath](lib/forge-std/src/StdMath.sol#L4-L43) is not in CapWords

lib/forge-std/src/StdMath.sol#L4-L43


 - [ ] ID-165
Event [StdAssertionslog_array(int256[])](lib/forge-std/src/StdAssertions.sol#L9) is not in CapWords

lib/forge-std/src/StdAssertions.sol#L9


 - [ ] ID-166
Contract [stdError](lib/forge-std/src/StdError.sol#L5-L15) is not in CapWords

lib/forge-std/src/StdError.sol#L5-L15


 - [ ] ID-167
Event [StdAssertionslog_array(address[])](lib/forge-std/src/StdAssertions.sol#L10) is not in CapWords

lib/forge-std/src/StdAssertions.sol#L10


 - [ ] ID-168
Parameter [stdStorageSafe.depth(StdStorage,uint256)._depth](lib/forge-std/src/StdStorage.sol#L137) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L137


 - [ ] ID-169
Function [stdStorage.read_address(StdStorage)](lib/forge-std/src/StdStorage.sol#L291-L293) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L291-L293


 - [ ] ID-170
Event [DSTestlog_int(int256)](lib/forge-std/lib/ds-test/src/test.sol#L24) is not in CapWords

lib/forge-std/lib/ds-test/src/test.sol#L24


 - [ ] ID-171
Event [stdStorageSafeWARNING_UninitedSlot(address,uint256)](lib/forge-std/src/StdStorage.sol#L18) is not in CapWords

lib/forge-std/src/StdStorage.sol#L18


 - [ ] ID-172
Parameter [stdStorageSafe.target(StdStorage,address)._target](lib/forge-std/src/StdStorage.sol#L107) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L107


 - [ ] ID-173
Constant [stdError.zeroVarError](lib/forge-std/src/StdError.sol#L14) is not in UPPER_CASE_WITH_UNDERSCORES

lib/forge-std/src/StdError.sol#L14


 - [ ] ID-174
Constant [stdError.assertionError](lib/forge-std/src/StdError.sol#L6) is not in UPPER_CASE_WITH_UNDERSCORES

lib/forge-std/src/StdError.sol#L6


 - [ ] ID-175
Constant [StdUtils.vm](lib/forge-std/src/StdUtils.sol#L16) is not in UPPER_CASE_WITH_UNDERSCORES

lib/forge-std/src/StdUtils.sol#L16


 - [ ] ID-176
Function [stdStorageSafe.with_key(StdStorage,uint256)](lib/forge-std/src/StdStorage.sol#L127-L130) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L127-L130


 - [ ] ID-177
Parameter [DiamondCut.diamondCut(IDiamondCut.FacetCut[],address,bytes)._calldata](src/diamond/Diamond.Cut.sol#L58) is not in mixedCase

src/diamond/Diamond.Cut.sol#L58


 - [ ] ID-178
Event [DSTestlogs(bytes)](lib/forge-std/lib/ds-test/src/test.sol#L20) is not in CapWords

lib/forge-std/lib/ds-test/src/test.sol#L20


 - [ ] ID-179
Parameter [stdStorageSafe.sig(StdStorage,string)._sig](lib/forge-std/src/StdStorage.sol#L117) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L117


 - [ ] ID-180
Function [stdStorageSafe.read_bool(StdStorage)](lib/forge-std/src/StdStorage.sol#L152-L157) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L152-L157


 - [ ] ID-181
Event [DSTestlog_uint(uint256)](lib/forge-std/lib/ds-test/src/test.sol#L25) is not in CapWords

lib/forge-std/lib/ds-test/src/test.sol#L25


 - [ ] ID-182
Constant [stdError.popError](lib/forge-std/src/StdError.sol#L11) is not in UPPER_CASE_WITH_UNDERSCORES

lib/forge-std/src/StdError.sol#L11


 - [ ] ID-183
Function [stdStorageSafe.with_key(StdStorage,bytes32)](lib/forge-std/src/StdStorage.sol#L132-L135) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L132-L135


 - [ ] ID-184
Constant [stdError.memOverflowError](lib/forge-std/src/StdError.sol#L13) is not in UPPER_CASE_WITH_UNDERSCORES

lib/forge-std/src/StdError.sol#L13


 - [ ] ID-185
Constant [stdError.arithmeticError](lib/forge-std/src/StdError.sol#L7) is not in UPPER_CASE_WITH_UNDERSCORES

lib/forge-std/src/StdError.sol#L7


 - [ ] ID-186
Constant [stdError.indexOOBError](lib/forge-std/src/StdError.sol#L12) is not in UPPER_CASE_WITH_UNDERSCORES

lib/forge-std/src/StdError.sol#L12


 - [ ] ID-187
Constant [CommonBase.vm](lib/forge-std/src/Base.sol#L22) is not in UPPER_CASE_WITH_UNDERSCORES

lib/forge-std/src/Base.sol#L22


 - [ ] ID-188
Modifier [DSTest.logs_gas()](lib/forge-std/lib/ds-test/src/test.sol#L86-L91) is not in mixedCase

lib/forge-std/lib/ds-test/src/test.sol#L86-L91


 - [ ] ID-189
Variable [DSTest.IS_TEST](lib/forge-std/lib/ds-test/src/test.sol#L38) is not in mixedCase

lib/forge-std/lib/ds-test/src/test.sol#L38


 - [ ] ID-190
Function [StdUtils.console2_log(string,uint256)](lib/forge-std/src/StdUtils.sol#L180-L183) is not in mixedCase

lib/forge-std/src/StdUtils.sol#L180-L183


 - [ ] ID-191
Event [DSTestlog_named_decimal_int(string,int256,uint256)](lib/forge-std/lib/ds-test/src/test.sol#L31) is not in CapWords

lib/forge-std/lib/ds-test/src/test.sol#L31


 - [ ] ID-192
Event [DSTestlog_bytes(bytes)](lib/forge-std/lib/ds-test/src/test.sol#L26) is not in CapWords

lib/forge-std/lib/ds-test/src/test.sol#L26


 - [ ] ID-193
Function [stdStorage.with_key(StdStorage,uint256)](lib/forge-std/src/StdStorage.sol#L222-L224) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L222-L224


 - [ ] ID-194
Function [stdStorage.read_bytes32(StdStorage)](lib/forge-std/src/StdStorage.sol#L283-L285) is not in mixedCase

lib/forge-std/src/StdStorage.sol#L283-L285


 - [ ] ID-195
Event [StdAssertionslog_named_array(string,address[])](lib/forge-std/src/StdAssertions.sol#L13) is not in CapWords

lib/forge-std/src/StdAssertions.sol#L13


 - [ ] ID-196
Event [DSTestlog_named_bytes(string,bytes)](lib/forge-std/lib/ds-test/src/test.sol#L35) is not in CapWords

lib/forge-std/lib/ds-test/src/test.sol#L35


## redundant-statements
Impact: Informational
Confidence: High
 - [ ] ID-197
Redundant expression "[status](lib/forge-std/src/StdUtils.sol#L187)" in[StdUtils](lib/forge-std/src/StdUtils.sol#L10-L189)

lib/forge-std/src/StdUtils.sol#L187


 - [ ] ID-198
Redundant expression "[status](lib/forge-std/lib/ds-test/src/test.sol#L73)" in[DSTest](lib/forge-std/lib/ds-test/src/test.sol#L18-L469)

lib/forge-std/lib/ds-test/src/test.sol#L73


 - [ ] ID-199
Redundant expression "[status](lib/forge-std/src/StdUtils.sol#L182)" in[StdUtils](lib/forge-std/src/StdUtils.sol#L10-L189)

lib/forge-std/src/StdUtils.sol#L182


## similar-names
Impact: Informational
Confidence: Medium
 - [ ] ID-200
Variable [Vm.expectEmit(bool,bool,bool,bool).checkTopic1](lib/forge-std/src/Vm.sol#L341) is too similar to [Vm.expectEmit(bool,bool,bool,bool).checkTopic3](lib/forge-std/src/Vm.sol#L341)

lib/forge-std/src/Vm.sol#L341


 - [ ] ID-201
Variable [Vm.expectEmit(bool,bool,bool,bool).checkTopic2](lib/forge-std/src/Vm.sol#L341) is too similar to [Vm.expectEmit(bool,bool,bool,bool).checkTopic3](lib/forge-std/src/Vm.sol#L341)

lib/forge-std/src/Vm.sol#L341


 - [ ] ID-202
Variable [StdInvariant._excludedSenders](lib/forge-std/src/StdInvariant.sol#L13) is too similar to [StdInvariant.excludeSenders().excludedSenders_](lib/forge-std/src/StdInvariant.sol#L69)

lib/forge-std/src/StdInvariant.sol#L13


 - [ ] ID-203
Variable [Vm.expectEmit(bool,bool,bool,bool,address).checkTopic1](lib/forge-std/src/Vm.sol#L342) is too similar to [Vm.expectEmit(bool,bool,bool,bool,address).checkTopic2](lib/forge-std/src/Vm.sol#L342)

lib/forge-std/src/Vm.sol#L342


 - [ ] ID-204
Variable [StdInvariant._targetedContracts](lib/forge-std/src/StdInvariant.sol#L14) is too similar to [StdInvariant.targetContracts().targetedContracts_](lib/forge-std/src/StdInvariant.sol#L81)

lib/forge-std/src/StdInvariant.sol#L14


 - [ ] ID-205
Variable [StdInvariant._targetedArtifacts](lib/forge-std/src/StdInvariant.sol#L18) is too similar to [StdInvariant.targetArtifacts().targetedArtifacts_](lib/forge-std/src/StdInvariant.sol#L73)

lib/forge-std/src/StdInvariant.sol#L18


 - [ ] ID-206
Variable [StdInvariant._targetedSenders](lib/forge-std/src/StdInvariant.sol#L15) is too similar to [StdInvariant.targetSenders().targetedSenders_](lib/forge-std/src/StdInvariant.sol#L89)

lib/forge-std/src/StdInvariant.sol#L15


 - [ ] ID-207
Variable [Vm.expectEmit(bool,bool,bool,bool,address).checkTopic1](lib/forge-std/src/Vm.sol#L342) is too similar to [Vm.expectEmit(bool,bool,bool,bool,address).checkTopic3](lib/forge-std/src/Vm.sol#L342)

lib/forge-std/src/Vm.sol#L342


 - [ ] ID-208
Variable [IDiamondLoupe.facetAddress(bytes4)._functionSelector](src/diamond/interfaces/IDiamond.Loupe.sol#L19) is too similar to [DiamondCut.diamondCut(IDiamondCut.FacetCut[],address,bytes).functionSelectors](src/diamond/Diamond.Cut.sol#L68)

src/diamond/interfaces/IDiamond.Loupe.sol#L19


 - [ ] ID-209
Variable [Vm.expectEmit(bool,bool,bool,bool).checkTopic2](lib/forge-std/src/Vm.sol#L341) is too similar to [Vm.expectEmit(bool,bool,bool,bool,address).checkTopic3](lib/forge-std/src/Vm.sol#L342)

lib/forge-std/src/Vm.sol#L341


 - [ ] ID-210
Variable [StdAssertions.assertEqCall(address,bytes,address,bytes,bool).returnDataA](lib/forge-std/src/StdAssertions.sol#L351) is too similar to [StdAssertions.assertEqCall(address,bytes,address,bytes,bool).returnDataB](lib/forge-std/src/StdAssertions.sol#L352)

lib/forge-std/src/StdAssertions.sol#L351


 - [ ] ID-211
Variable [StdInvariant._excludedContracts](lib/forge-std/src/StdInvariant.sol#L12) is too similar to [StdInvariant.excludeContracts().excludedContracts_](lib/forge-std/src/StdInvariant.sol#L65)

lib/forge-std/src/StdInvariant.sol#L12


 - [ ] ID-212
Variable [Vm.expectEmit(bool,bool,bool,bool).checkTopic1](lib/forge-std/src/Vm.sol#L341) is too similar to [Vm.expectEmit(bool,bool,bool,bool,address).checkTopic3](lib/forge-std/src/Vm.sol#L342)

lib/forge-std/src/Vm.sol#L341


 - [ ] ID-213
Variable [Vm.expectEmit(bool,bool,bool,bool).checkTopic1](lib/forge-std/src/Vm.sol#L341) is too similar to [Vm.expectEmit(bool,bool,bool,bool).checkTopic2](lib/forge-std/src/Vm.sol#L341)

lib/forge-std/src/Vm.sol#L341


 - [ ] ID-214
Variable [Vm.expectEmit(bool,bool,bool,bool,address).checkTopic1](lib/forge-std/src/Vm.sol#L342) is too similar to [Vm.expectEmit(bool,bool,bool,bool).checkTopic2](lib/forge-std/src/Vm.sol#L341)

lib/forge-std/src/Vm.sol#L342


 - [ ] ID-215
Variable [Vm.expectEmit(bool,bool,bool,bool,address).checkTopic1](lib/forge-std/src/Vm.sol#L342) is too similar to [Vm.expectEmit(bool,bool,bool,bool).checkTopic3](lib/forge-std/src/Vm.sol#L341)

lib/forge-std/src/Vm.sol#L342


 - [ ] ID-216
Variable [Vm.expectEmit(bool,bool,bool,bool,address).checkTopic2](lib/forge-std/src/Vm.sol#L342) is too similar to [Vm.expectEmit(bool,bool,bool,bool,address).checkTopic3](lib/forge-std/src/Vm.sol#L342)

lib/forge-std/src/Vm.sol#L342


 - [ ] ID-217
Variable [StdInvariant._targetedArtifactSelectors](lib/forge-std/src/StdInvariant.sol#L20) is too similar to [StdInvariant.targetArtifactSelectors().targetedArtifactSelectors_](lib/forge-std/src/StdInvariant.sol#L77)

lib/forge-std/src/StdInvariant.sol#L20


 - [ ] ID-218
Variable [StdInvariant._excludedArtifacts](lib/forge-std/src/StdInvariant.sol#L17) is too similar to [StdInvariant.excludeArtifacts().excludedArtifacts_](lib/forge-std/src/StdInvariant.sol#L61)

lib/forge-std/src/StdInvariant.sol#L17


 - [ ] ID-219
Variable [Vm.expectEmit(bool,bool,bool,bool).checkTopic1](lib/forge-std/src/Vm.sol#L341) is too similar to [Vm.expectEmit(bool,bool,bool,bool,address).checkTopic2](lib/forge-std/src/Vm.sol#L342)

lib/forge-std/src/Vm.sol#L341


 - [ ] ID-220
Variable [StdInvariant._targetedSelectors](lib/forge-std/src/StdInvariant.sol#L21) is too similar to [StdInvariant.targetSelectors().targetedSelectors_](lib/forge-std/src/StdInvariant.sol#L85)

lib/forge-std/src/StdInvariant.sol#L21


 - [ ] ID-221
Variable [Vm.expectEmit(bool,bool,bool,bool,address).checkTopic2](lib/forge-std/src/Vm.sol#L342) is too similar to [Vm.expectEmit(bool,bool,bool,bool).checkTopic3](lib/forge-std/src/Vm.sol#L341)

lib/forge-std/src/Vm.sol#L342


## unused-state
Impact: Informational
Confidence: High
 - [ ] ID-222
[CommonBase.DEFAULT_SENDER](lib/forge-std/src/Base.sol#L13) is never used in [FlipperFacetTest](test/Flipper.t.sol#L6-L33)

lib/forge-std/src/Base.sol#L13


 - [ ] ID-223
[CommonBase.CONSOLE](lib/forge-std/src/Base.sol#L11) is never used in [FlipperFacetTest](test/Flipper.t.sol#L6-L33)

lib/forge-std/src/Base.sol#L11


 - [ ] ID-224
[CommonBase.stdstore](lib/forge-std/src/Base.sol#L23) is never used in [FlipperFacetTest](test/Flipper.t.sol#L6-L33)

lib/forge-std/src/Base.sol#L23


 - [ ] ID-225
[CommonBase.UINT256_MAX](lib/forge-std/src/Base.sol#L19-L20) is never used in [CounterFacetTest](test/Counter.t.sol#L6-L36)

lib/forge-std/src/Base.sol#L19-L20


 - [ ] ID-226
[CommonBase.DEFAULT_TEST_CONTRACT](lib/forge-std/src/Base.sol#L15) is never used in [CounterFacetTest](test/Counter.t.sol#L6-L36)

lib/forge-std/src/Base.sol#L15


 - [ ] ID-227
[CommonBase.MULTICALL3_ADDRESS](lib/forge-std/src/Base.sol#L17) is never used in [CounterFacetTest](test/Counter.t.sol#L6-L36)

lib/forge-std/src/Base.sol#L17


 - [ ] ID-228
[CommonBase.stdstore](lib/forge-std/src/Base.sol#L23) is never used in [CounterFacetTest](test/Counter.t.sol#L6-L36)

lib/forge-std/src/Base.sol#L23


 - [ ] ID-229
[CommonBase.CONSOLE](lib/forge-std/src/Base.sol#L11) is never used in [CounterFacetTest](test/Counter.t.sol#L6-L36)

lib/forge-std/src/Base.sol#L11


 - [ ] ID-230
[CommonBase.DEFAULT_TEST_CONTRACT](lib/forge-std/src/Base.sol#L15) is never used in [FlipperFacetTest](test/Flipper.t.sol#L6-L33)

lib/forge-std/src/Base.sol#L15


 - [ ] ID-231
[CommonBase.DEFAULT_SENDER](lib/forge-std/src/Base.sol#L13) is never used in [CounterFacetTest](test/Counter.t.sol#L6-L36)

lib/forge-std/src/Base.sol#L13


 - [ ] ID-232
[CommonBase.vm](lib/forge-std/src/Base.sol#L22) is never used in [CounterFacetTest](test/Counter.t.sol#L6-L36)

lib/forge-std/src/Base.sol#L22


 - [ ] ID-233
[CommonBase.MULTICALL3_ADDRESS](lib/forge-std/src/Base.sol#L17) is never used in [FlipperFacetTest](test/Flipper.t.sol#L6-L33)

lib/forge-std/src/Base.sol#L17


 - [ ] ID-234
[CommonBase.vm](lib/forge-std/src/Base.sol#L22) is never used in [FlipperFacetTest](test/Flipper.t.sol#L6-L33)

lib/forge-std/src/Base.sol#L22


 - [ ] ID-235
[CommonBase.UINT256_MAX](lib/forge-std/src/Base.sol#L19-L20) is never used in [FlipperFacetTest](test/Flipper.t.sol#L6-L33)

lib/forge-std/src/Base.sol#L19-L20


## constable-states
Impact: Optimization
Confidence: High
 - [ ] ID-236
[DSTest.IS_TEST](lib/forge-std/lib/ds-test/src/test.sol#L38) should be constant 

lib/forge-std/lib/ds-test/src/test.sol#L38


