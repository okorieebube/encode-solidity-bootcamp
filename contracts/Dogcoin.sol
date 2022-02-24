//SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

import "hardhat/console.sol";

contract LinkToken {
    string public name = "DogCoin";
    string public symbol = "DOG";
    string public version = "v1.0";
    uint256 public decimals = 18;

    uint256 public totalSupply;

    //
    address[] public currentHolders;
    uint256 public countCurrentHolders;
    mapping(address => uint256) public holderIndex;

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    constructor(uint256 _initalSupply) {
        balanceOf[msg.sender] = _initalSupply;
        currentHolders[] = msg.sender;
        totalSupply = _initalSupply;
    }

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );

    // addToHolders[recipient]
    /*
        should be called before updating state
        check if the recipient bal is zero: add to holders
     */

    function addToHolders(address recipient) internal returns (bool) {
        if (balanceOf[recipient] == 0) {
            currentHolders[countCurrentHolders + 1] = recipient;
            holderIndex[recipient] = countCurrentHolders + 1;
            countCurrentHolders++;
        }
        return true;
    }

    // removeFromHolders[msg.sender]
    /*
        should be called after updating state
        check if sender balance is zero: 
            if yes;
            get index from holderIndex mapping
            delete from holders array
            subtract from countHolders
     */

    function removeFromHolders(address sender) internal returns (bool) {}

    function transfer(address _to, uint256 _value)
        public
        returns (bool success)
    {
        require(balanceOf[msg.sender] >= _value, "Insufficient funds");
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;

        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function approve(address _spender, uint256 _value)
        public
        returns (bool success)
    {
        allowance[msg.sender][_spender] = _value;

        emit Approval(msg.sender, _spender, _value);

        return true;
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public returns (bool success) {
        require(balanceOf[_from] >= _value, "Insufficient balance");
        require(
            allowance[_from][msg.sender] >= _value,
            "Insufficient allowed funds"
        );
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        allowance[_from][msg.sender] -= _value;

        emit Transfer(_from, _to, _value);

        return true;
    }
}
