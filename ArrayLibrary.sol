library ArrayUtilities {
	
 // internal functions can be used in internal library functions because
 // they will be part of the same code context
 
 function map(uint[] memory self, function (uint) returns (uint) f)
 internal
 returns (uint[] memory r)
 {
 r = new uint[](self.length);
 for (uint i = 0; i < self.length; i++) {
 r = f(self);
 }
 }
 function reduction(
 uint[] memory self,
 function (uint, uint) returns (uint) f
 )
 internal
 returns (uint r)
 {
 r = self[0];
 for (uint i = 1; i < self.length; i++) {
 r = f(r, self);
 }
 }
 function rangeTo(uint length) internal returns (uint[] memory r) {
 r = new uint[](length);
 for (uint i = 0; i < r.length; i++) {
 r = i;
 }
 }
}
contract Pyramid {
 using ArrayUtilities for *;
 function pyramid(uint l) returns (uint) {
 return ArrayUtilities.range(l).map(square).reduce(sum);
 }
 function squareResult(uint a) internal returns (uint) {
 return a * a;
 }
 function sumResult(uint a, uint b) internal returns (uint) {
 return a + b;
 }
}