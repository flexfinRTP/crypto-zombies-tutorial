pragma solidity >=0.5.0 <0.6.0;

contract Notes {
    function sayHiToVitalik(string memory _name) public returns (string memory)
    {
        // Compares if _name equals "Vitalik". Throws an error and exits if not true.
        // (Side note: Solidity doesn't have native string comparison, so we
        // compare their keccak256 hashes to see if the strings are equal)
        require(
            keccak256(abi.encodePacked(_name)) == keccak256(abi.encodePacked("Vitalik"))
        );
        // If it's true, proceed with the function:
        return "Hi!";
    }

contract SandwichFactory {
    struct Sandwich {
        string name;
        string status;
    }

    Sandwich[] sandwiches;

    function eatSandwich(uint _index) public {
        // Sandwich mySandwich = sandwiches[_index];

        // ^ Seems pretty straightforward, but solidity will give you a warning
        // telling you that you should explicitly declare `storage` or `memory` here.

        // So instead, you should declare with the `storage` keyword, like:
        Sandwich storage mySandwich = sandwiches[_index];
        // ...in which case `mySandwich` is a pointer to `sandwiches[_index]`
        // in storage, and...
        mySandwich.status = "Eaten!";
        // ...this will permanently change `sandwiches[_index]` on the blockchain.

        // If you just want a copy, you can use `memory`:
        Sandwich memory anotherSandwich = sandwiches[_index + 1];
        // ...in which case `anotherSandwich` will simply be a copy of the 
        // data in memory, and...
        anotherSandwich.status = "Eaten!";
        // ...will just modify the temporary variable and have no effect 
        // on `sandwiches[_index + 1]`. But you can do this:
        sandwiches[_index + 1] = anotherSandwich;
        // ...if you want to copy the changes back into blockchain storage.
        }
    }
}
