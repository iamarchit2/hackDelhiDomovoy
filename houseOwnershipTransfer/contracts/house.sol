pragma solidity 0.4.17;
contract House {
    uint public price;
    string public houseLocation;
    string[] public registryDocuments;
    string[] public serviceDocuments;
    bool public onSale;
    address public owner; //public so that javascript program can access it.
    address[] public pastOwners;
    function House(string houseLocation_) public {
        owner = msg.sender;
        houseLocation = houseLocation_;
        onSale = false;
    }
    //function getPastOwners() public restricted view returns(address[]){
      //  return pastOwners; 
    //}
    //function getRegistryDocuments() public restricted view returns(string[]){
      //  return registryDocuments; 
    //}
    //function getServiceDouments() public restricted view returns(string[]){
      //  return serviceDocuments; 
    //}
    function makeOpenForSale(uint price_) public restricted {
        onSale = true;
        price = price_;
    }
    function uploadRegistryDocument(string registryDocumentHash) public restricted {
        registryDocuments.push(registryDocumentHash);
    }
    function uploadServiceDocument(string serviceDocumentHash) public restricted {
        serviceDocuments.push(serviceDocumentHash);
    }
    function requestToBuy() public payable {
        require(msg.value >= price && onSale == true);
        
        pastOwners.push(owner);
        owner.transfer(this.balance);
        owner = msg.sender;
        onSale = false;
    }
    modifier restricted() {
        require(msg.sender == owner);
        _;
    }
}

