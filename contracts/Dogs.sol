pragma solidity 0.5.16;

//YOU CAN NEVER HAVE STATE VARIABLES IN FUNCTIONAL CONTRACTS
//****except for what is shared in storage****
  //If the variable in the functional contract is changed but that variable does not exist in the proxy contracts scope
  //then data within the proxy contract WILL BE OVERWRITTEN. This can have devistating effects on your contract

import "./Storage.sol";

  //inherit storage contract
contract Dogs is Storage {

    //modifier to restrict access
  modifier onlyOwner(){
    require(msg.sender == owner);
    _;
  }

    //constructor to set owner
  constructor() public {
    owner = msg.sender;
  }

    //simple get function
  function getNumberOfDogs() public view returns (uint256) {
    return _uintStorage["Dogs"];
  }

    //simple set function
  function setNumberOfDogs(uint256 toSet) public {
    _uintStorage["Dogs"] = toSet;
  }

}
