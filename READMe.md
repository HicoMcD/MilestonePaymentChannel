# Simple Milestone Payment Channel

Leveraging on OpenZeppelin's Pull Payment contract which inherits from their Escrow contract with added utilities.

## Stakeholders:
- Client            (address[0])
- Project Manager   (address[1])
- Contractor        (address[2])

## Description
This contract is deployed with the Client's address, the Project Manager's address and the Contractor's address.

The Client is the only address that can deposit funds into the contract. Once the Client deposits the milestone payment the state of the contract changes from 'DEPOSITPAYMENT' to 'INSPECTION'.

While in the 'INSPECTION' state, the Project Manager has the opportunity to inspect the works completed by the contractor. If the Project Manager finds that the work is completed to construction specification, the Project Manager approves the payment by using the 'inspection' function. The state will then change to 'PAYMENT'.

Only while in the 'PAYMENT', the Contractor can withdraw the payment. Once the payment is witdrawn, the state will change bakc to 'DEPOSITPAYMENT' to start the sequence again.