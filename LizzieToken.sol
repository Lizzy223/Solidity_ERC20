// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

interface LizzieERC20 {
     function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount)
        external
        returns (bool);
    function allowance(address owner, address spender)
        external
        view
        returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount)
        external
        returns (bool);
}

contract LizzieToken {
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approve( address indexed  owner, address indexed  spender, uint256 value);

    uint256 public totalSupply;
    mapping (address =>uint256) public balanceOf;
    mapping (address => mapping(address => uint256)) public allowance;

    string public tokenName;
    string public tokenSymbol;
    uint8 public decimals;

    constructor(string memory _tokenName, string memory _tokenSymbol, uint8 _decimals){
        tokenName = _tokenName;
        tokenSymbol = _tokenSymbol;
        decimals = _decimals;
    }

    function transfer(address recipient, uint256 amount) public  returns (bool){
        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;

        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    function approve(address spender, uint256 amount) public  returns (bool){
        allowance[msg.sender][spender] = amount;
        emit Approve(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) public returns (bool){
        allowance[msg.sender][sender] -= amount;
        balanceOf[sender] -= amount;
        balanceOf[recipient] -= amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }

     function _mint(address to, uint256 amount) internal {
        balanceOf[to] += amount;
        totalSupply += amount;
        emit Transfer(address(0), to, amount);
    }

    function _burn(address from, uint256 amount) internal {
        balanceOf[from] -= amount;
        totalSupply -= amount;
        emit Transfer(from, address(0), amount);
    }

    function mint(address to, uint256 amount) external {
        _mint(to, amount);
    }


}
