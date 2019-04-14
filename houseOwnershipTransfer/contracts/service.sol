pragma solidity 0.4.17;
contract Service {
    address private serviceProvidedBy;
    uint private index;
    bool public isServed = false;
    address public consumer;
    string public serviceRequired;
    address[] public serviceProviders;
    uint[] serviceProviderRating;
    uint[] serviceProviderCost;
    function Service(string serviceRequired_) public {
        serviceRequired = serviceRequired_;
        consumer = msg.sender;
    }
    function getServiceProviders() public view returns(address[]) {
        return serviceProviders;
    }
    function getServiceProviderRating() public view returns(uint[]) {
        return serviceProviderRating;
    }
    function getServiceProviderCost() public view returns(uint[]) {
        return serviceProviderCost;
    }
    function requestToServe(uint rating, uint cost) public {
        require(isServed == false);
        serviceProviders.push(msg.sender);
        serviceProviderRating.push(rating);
        serviceProviderCost.push(cost);
    }
    function chooseServiceProvider(uint idx) public restricted payable {
        require(msg.value >= serviceProviderCost[idx]);
        require(isServed == false);
        serviceProvidedBy = serviceProviders[idx];
        serviceProviders[idx].transfer(this.balance);
        isServed = true;
    }
    /*function pickEco() public restricted {
        require(isServed == false);
        uint min = serviceProviderCost[0];
        uint idx = 0;
        for(uint i = 0; i < serviceProviders.length; i++) {
            if(serviceProviderCost[i] < min) {
                idx = i;
                min = serviceProviderCost[i];
            }
        }
        serviceProvidedBy = serviceProviders[idx];
        serviceProviders[idx].transfer(min);
    }*/
    /*function pickHighQuality() public restricted {
        require(isServed == false);
        uint max = serviceProviderRating[0];
        uint idx = 0;
        for(uint i = 0; i < serviceProviders.length; i++) {
            if(serviceProviderRating[i] > max) {
                idx = i;
                max = serviceProviderRating[i];
            }
        }
        
        serviceProvidedBy = serviceProviders[idx];
        serviceProviders[idx].transfer(max);
    }*/
    function giveRating(uint rating) public {
        require(isServed == true);
        serviceProviderRating[index] = rating;
        
    }
    modifier restricted() {
        require(msg.sender == consumer);
        _;
    }
    
}
