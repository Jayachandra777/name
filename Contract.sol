pragma solidity ^0.8.0;

contract PersistentChalkboard {

    

    mapping(address => string) private names;

    address private contractOwner;

    

    constructor() {

        contractOwner = msg.sender;

    }

    

    function addName(string calldata name) external {

        require(bytes(name).length > 0, "Name can't be blank");

        require(bytes(name).length < 14, "Name must be less than 14 characters");

        names[msg.sender] = name;

    }

    

    function getNames() external view returns (string[] memory) {

        uint count = 0;

        string[] memory result = new string[](getCount());

        for (uint i = 0; i < result.length; i++) {

            if (bytes(names[getAccountAtIndex(i)]).length > 0) {

                result[count] = names[getAccountAtIndex(i)];

                count++;

            }

        }

        return result;

    }

    

    function getAccountId() external view returns (address[] memory) {

        uint count = 0;

        address[] memory result = new address[](getCount());

        for (uint i = 0; i < result.length; i++) {

            if (bytes(names[getAccountAtIndex(i)]).length > 0) {

                result[count] = getAccountAtIndex(i);

                count++;

            }

        }

        return result;

    }

    

    function clear() external {

        require(msg.sender == contractOwner, "Can only be called by contractOwner");

        for (uint i = 0; i < getCount(); i++) {

            delete names[getAccountAtIndex(i)];

        }

    }

    

    function getCount() private view returns (uint) {

        uint count = 0;

        for (uint i = 0; i < 10; i++) {

            if (bytes(names[getAccountAtIndex(i)]).length > 0) {

                count++;

            }

        }

        return count;

    }

    

    function getAccountAtIndex(uint index) private view returns (address) {

        return address(uint160(uint(keccak256(abi.encodePacked(index)))));

    }

}

