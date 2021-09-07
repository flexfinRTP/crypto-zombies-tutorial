pragma solidity >=0.5.0 <0.6.0;

import "./ZombieFactory.sol";

contract KittyInterface { // Interface a contract the address does not own; use contract syntax that returns function you want to use with no func body
    function getKitty(uint256 _id) external view returns(
    bool isGestating,
    bool isReady,
    uint256 cooldownIndex,
    uint256 nextActionAt,
    uint256 siringWithId,
    uint256 birthTime,
    uint256 matronId,
    uint256 sireId,
    uint256 generation,
    uint256 genes
    );
}

contract ZombieFeeding is ZombieFactory {

      address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d; // cryptokitties contract address
      KittyInterface kittyContract = KittyInterface(ckAddress); // call kittyInterface is called var kittyContarct, init ckaddress

    function feedAndMultiply(uint _zombieId, uint _targetDna, string memory _species) public { 

        require(msg.sender == zombieToOwner[_zombieId]); // checks address is owner of that zombieId
        Zombie storage myZombie = zombies[_zombieId]; // creates new zombie in zombies array, get zombieId

        _targetDna = _targetDna % dnaModulus; // targetDna is equal to 16 digits
    
        uint newDna = (myZombie.dna + _targetDna) / 2; // dna of new zombie is avg of owner's dna and target's(to feed on) dna

        if (keccak256(abi.encodePacked(_species)) == keccak256(abi.encodePacked("kitty"))) { // if _species="kitty"
        newDna = newDna - newDna % 100 + 99; // then last 2 digits of newDna of new zombie from above is replaced with 99
        }

        _createZombie("NoName", newDna); // create new Zombie after "feed" with newDna and new name
    }

    function feedOnKitty(uint _zombieId, uint _kittyId) public {
        uint kittyDna;
        (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId); // call getKitty func from kittyConract with _kittyId param, get genes from getKitty set kittyDna
        feedAndMultiply(_zombieId, kittyDna, "kitty"); // call feedandmultiply, with the zombieId and targetDna=kittyDna(gene), species=kitty
    }

}
