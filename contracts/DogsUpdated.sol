pragma solidity 0.5.16;

//YOU CAN NEVER HAVE STATE VARIABLES IN FUNCTIONAL CONTRACTS
//****except for what is shared in storage****
  //If the variable in the functional contract is changed but that variable does not exist in the proxy contracts scope
  //then data within the proxy contract WILL BE OVERWRITTEN. This can have devistating effects on your contract


import "./Storage.sol";

  //inherits storage contract
contract DogsUpdated is Storage {

    //modifier to restrict access
  modifier onlyOwner(){
    require(msg.sender == owner);
    _;
  }

    //constructor to execute initialize function and change owner address
  constructor() public {
    initialize(msg.sender);
  }

    //function to change owner that was set by the constructor at contract launch to new updated contract address
    //executed in constructor above so right at launch which means we can not put onlyOwner modifier on function since we are not the owner until function executes
  function initialize(address _owner) public {
      //_initialized must be false
    require(!_initialized);
      //set new owner
    owner = _owner;
      //change to true so function cannot be run again after running once
    _initialized = true;
  }

    //simple get function
  function getNumberOfDogs() public view returns (uint256) {
    return _uintStorage["Dogs"];
  }

    // simple set function
  function setNumberOfDogs(uint256 toSet) public onlyOwner {
    _uintStorage["Dogs"] = toSet;
  }

}
