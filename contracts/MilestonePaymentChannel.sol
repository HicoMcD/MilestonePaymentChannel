//"SPDX-License-Identifier: UNLICENSED"

pragma solidity ^0.6.0;

import "./OpenZeppelin/PullPayment.sol";

contract MilestonePaymentChannel is PullPayment {

    address public client;
    address public projectManager;
    address public contractor;
    
    bool public inspectionApproved = false;
    
    enum MilestoneState {
        DEPOSITPAYMENT,
        INSPECTION,
        PAYMENT
    }
    MilestoneState public currentState = MilestoneState.DEPOSITPAYMENT;

    constructor(address payable _client, address _projectManager, address _contractor) public payable {
        client = _client;
        projectManager = _projectManager;
        contractor = _contractor;
    }
    
    function deposit(address payable dest) public payable inState(MilestoneState.DEPOSITPAYMENT) {
        require(msg.sender == client);
        currentState = MilestoneState.INSPECTION;
        _asyncTransfer(dest, msg.value);
    }
    
    function withdrawPayment(address payable _contractor) public virtual inState(MilestoneState.PAYMENT) {
        require(msg.sender == _contractor);
        require(inspectionApproved == true);
        currentState = MilestoneState.DEPOSITPAYMENT;
        inspectionApproved = false;
        withdrawPayments(_contractor);
    }
    
    function inspection() public inState(MilestoneState.INSPECTION) {
        require(msg.sender == projectManager);
        inspectionApproved = true;
        currentState = MilestoneState.PAYMENT;
    }
    
        modifier inState(MilestoneState state)
    {
        require(currentState == state, "Unavailable in current state");
        _;
    }
}
