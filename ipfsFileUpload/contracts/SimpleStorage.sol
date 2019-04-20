pragma solidity 0.5.0;

contract SimpleStorage {
  string ipfshash;

  function set(string memory x) public {
    ipfshash = x;
  }

  function get() public view returns (string memory) {
    return ipfshash;
  }
}
