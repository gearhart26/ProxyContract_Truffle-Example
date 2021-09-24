pragma solidity 0.5.16;

contract Storage {

    //Through mappings we have unlimited options for possible variables in the future
    //Much better than trying to figure out every single veriable you could ever need for the entire life of the contract right from day 1
    //This leaves us alot of room when upgrading the contract and adding functionality in the future
  mapping (string => uint256) _uintStorage;
  mapping (string => address) _addressStorage;
  mapping (string => bool) _boolStorage;
  mapping (string => string) _stringStorage;
  mapping (string => bytes4) _byte4Storage;
  address public owner;
  bool public _initialized;
}
