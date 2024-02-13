// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SHIFTER is ERC20, ERC20Burnable, ERC20Pausable, Ownable {

   uint public  totaluser;
   uint public  totalTaskCompleted;

struct Withdrawal {
    uint amount;
    uint timestamp;
}

mapping(address => Withdrawal) public withdrawDetail;

    constructor()
        ERC20("SHIFTER", "SHT")
        Ownable(msg.sender)
    {}

  function register()  public {
   mint(owner(),5000000000000000000);
   totaluser++;
  }

  function taskCompleted() public  {
   mint(owner(),2000000000000000000);
   totalTaskCompleted++;
  }
   
   function withdrawTokens(address to , uint value) public {
          _transfer(owner(), to, value);
          withdrawDetail[to].amount = value;
          withdrawDetail[to].timestamp = block.timestamp;
   }  


    function userWithdrawDeatil(address add) view public returns(Withdrawal memory) {
         Withdrawal memory data = withdrawDetail[add];
        return  data;

    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    // The following functions are overrides required by Solidity.

    function _update(address from, address to, uint256 value)
        internal
        override(ERC20, ERC20Pausable)
    {
        super._update(from, to, value);
    }
}