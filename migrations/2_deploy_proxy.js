//importing contracts for truffle to launch
//need to put CONTRACT names for truffle to understand, not file name
const Dogs = artifacts.require('Dogs');
const DogsUpdated = artifacts.require('DogsUpdated');
const Proxy = artifacts.require('Proxy');

//more truffle comands to set our deployment logic
module.exports = async function(deployer, network, accounts){

    //deploying an instance of Dogs contract
    //await tells truffle to wait until this is completed before moving to next line since we need this contracts' address before moving on
  const dogs = await Dogs.new();

    //deploying an instance of Proxy contract
    //since ther is a constructor in Proxy that requires the address of our functional contract,
    //we have to include that address when launching our proxt contract which we tell truffle to do here
    const proxy = await Proxy.new(dogs.address);

    //tricking truffle into thinking Dog contract is Proxy contract because truffle cant recognize that on it's own
    //this allows us to call functions in the dog contract from the proxy contract through truffle for testing and debugging

    //takes Dogs source code and uses .at to tell truffle to create an instance of the Dogs contract but do that through an existing contract Proxy
    //Basically tells truffle the Dog contract is located at the Proxy contract's address
    var proxyDog = await Dogs.at(proxy.address);

      //does not work on its own. We have to trick truffle in the code above ^^ first
      //setting number of dogs through proxy contract to Dogs contract
    await proxyDog.setNumberOfDogs(10);

      //testing
    var nrOfDogs = await proxyDog.getNumberOfDogs();
      //with truffle can use console.log() again to act as checkpoints to test contracts
    console.log("Before Update: " + nrOfDogs.toNumber());

//***
      //deploying updated dogs contract
    const dogsUpdated = await DogsUpdated.new();
      //since upgrade function is only on proxy contract we call that contract.
      //using proxyDog wouldnt work because we convinced truffle that was the Dogs contract and upgrade is not on that contract
    proxy.upgrade(dogsUpdated.address);

      //settiing new functional address for tricking truffle into thinking DogsUpdated is at Proxy's address like we did before
    proxyDog = await DogsUpdated.at(proxy.address);
      //initialize proxy state and using the address for account 0 that truffle provided us
    proxyDog.initialize(accounts[0]);

      //checking to make sure our storage is still there after the upgrade
    nrOfDogs = await proxyDog.getNumberOfDogs();
    console.log("After Update: " + nrOfDogs.toNumber());

      //set number of dogs stored on proxy contract through NEW FUNCTIONAL CONTRACT
    await proxyDog.setNumberOfDogs(30);

      //checking that we actually set number of dogs stored on proxy contract
    nrOfDogs = await proxyDog.getNumberOfDogs();
    console.log("After Update, New Number: " + nrOfDogs.toNumber());

}
