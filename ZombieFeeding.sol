pragma solidity >=0.5.0 <0.6.0;

import "./ZombieFactory.sol";

contract ZombieFeeding is ZombieFactory {

    function feedAndMultiply(uint _zombieId, uint _targetDna) public {

        require(msg.sender == zombieToOwner[_zombieId]); // checks address is owner of that zombieId
        Zombie storage myZombie = zombies[_zombieId]; // creates new zombie in zombies array, get zombieId

        _targetDna = _targetDna % dnaModulus; // targetDna is equal to 16 digits
    
        uint newDna = (myZombie.dna + _targetDna) / 2; // dna of new zombie is avg of owner's dna and target's(to feed on) dna

        _createZombie("NoName", newDna); // create new Zombie after "feed" with newDna and new name
    }

}
