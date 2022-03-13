//SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

import "hardhat/console.sol";

contract Dogcoin {
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
        totalSupply = _initalSupply;
        balanceOf[msg.sender] = _initalSupply;
        addToHolders(msg.sender);
    }

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );

    function addToHolders(address recipient) internal returns (bool) {
        if (balanceOf[recipient] == 0) {
            currentHolders[countCurrentHolders + 1] = recipient;
            holderIndex[recipient] = countCurrentHolders + 1;
            countCurrentHolders++;
        }
        return true;
    }

    function removeFromHolders(address sender) internal returns (bool) {
        if (balanceOf[sender] == 0) {
            address lastHolder = currentHolders[countCurrentHolders - 1];
            uint256 senderIndex = holderIndex[sender];
            currentHolders[senderIndex] = lastHolder;
            delete holderIndex[sender];
            holderIndex[lastHolder] = senderIndex;
            countCurrentHolders--;
        }
        return true;
    }

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
