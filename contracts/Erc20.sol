// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

contract Erc20token {
    string Coinname;
    string Coinsymbol;
    uint256 CoinSupply;

    constructor(
        string memory _name,
        string memory _symbol,
        uint256 _totalSupply
    ) {
        Coinname = _name;
        Coinsymbol = _symbol;
        CoinSupply = _totalSupply;
        balances[msg.sender] = _totalSupply;
    }

    event Transfer(
        address indexed sender,
        address indexed receiver,
        uint256 amount
    );
    event Approval(
        address indexed sender,
        address indexed receiver,
        uint256 worth
    );

    event TransferFrom(address _owner, address _receiver, uint256 _worth);

    mapping(address => uint256) public balances;
    mapping(address => mapping(address => uint256)) public _allowance;

    //name, symbol, decimal

    function name() public view returns (string memory) {
        return Coinname;
    }

    function symbol() public view returns (string memory) {
        return Coinsymbol;
    }

    function decimal() public pure returns (uint8) {
        return 18;
    }

    function totalSupply() public view returns (uint256) {
        return CoinSupply;
    }

    function balanceOf(address _user) public view returns (uint256) {
        return balances[_user];
    }

    function transfer(
        address _receiver,
        uint256 _amount
    ) public returns (bool success) {
        require(_receiver != address(0), "unavailable");
        require(
            _amount <= balances[msg.sender],
            "sorry, coin cant be disbursed"
        );
        balances[msg.sender] = balances[msg.sender] - _amount;
        balances[_receiver] = balances[_receiver] + _amount;

        //the 10% calculation
        uint256 percentageCalc = (_amount * 10) / 100;
        balances[msg.sender] =
            balances[msg.sender] -
            (_amount + percentageCalc);
        CoinSupply = CoinSupply - percentageCalc;
        emit Transfer(msg.sender, _receiver, _amount);
        return true;
    }

    function approve(
        address _receiver,
        uint256 _worth
    ) public returns (bool successful) {
        _allowance[msg.sender][_receiver] = _worth;
        emit Approval(msg.sender, _receiver, _worth);
        return true;
    }

    function allowance(
        address _owner,
        address _receiver
    ) public view returns (uint256) {
        return _allowance[_owner][_receiver];
    }

    function transferFrom(
        address __owner,
        address _receiver,
        uint256 _worth
    ) public returns (bool) {
        require(_worth <= _allowance[__owner][msg.sender]);

        uint256 percentageCalc = (_worth * 10) / 100;

        emit TransferFrom(__owner, _receiver, _worth);
        _allowance[__owner][msg.sender] -= _worth;
        balances[_receiver] += _worth;
        balances[__owner] -= _worth;
        balances[msg.sender] = balances[msg.sender] - (_worth + percentageCalc);
        CoinSupply = CoinSupply - percentageCalc;
        return true;
    }
}
