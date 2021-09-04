pragma solidity >=0.5.0 <0.6.0;

contract ZombieFactory {

    event NewZombie(uint zombieId, string name, uint dna); // declare the event 

    uint256 dnaDigits = 16;
    uint256 dnaModulus = 10**dnaDigits;

    struct Zombie {
        // struct = object holding many data types
        string name;
        uint256 dna;
    }

    Zombie[] public zombies; // dynamic array of Zombie structs, called zombies

    // **functions** - all reference types, arrays, structs, mappings, strings must be stored in memory
    //  pass arg into function, by value - creates new copy of parameter's value, modify value without changing init parameter,
    //  by reference - changes value of the variable it recieves AND the original value gets modified
    //  function params convention, put underscore _ before parameter variable name
    function _createZombie(string memory _name, uint256 _dna) private {
        // private functions have underscore _ before function name as convention, all functions should be declared as private by default
        
        // zombies.push(Zombie(_name, _dna)); //create new Zombie and push to zombies array using function args

        uint id = zombies.push(Zombie(_name, _dna)) - 1; // new zombie id var to be pushed to eventHandler, at index -1 to get zombie that was just added
        emit NewZombie(id, _name, _dna); // fire an event to let the app know the func was called with new id param, and function args
    }

    function _generateRandomDna(string memory _str) private view returns (uint256)
    { // use returns keyword when returning the function var, view=only viewing data not modifying, pure=not accessing or modifying any data in the app
        
        uint256 rand = uint256(keccak256(abi.encodePacked(_str))); // keccack 256=unsecure random gen, takes in abi.encodePacked(var)
        return rand % dnaModulus; // %=returns only remainder of var , in this case 16digits from above delcared vars
    }

    function createRandomZombie(string memory _name) public {
        uint256 randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }
}
