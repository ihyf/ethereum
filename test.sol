pragma solidity ^0.4.0;
contract Test{
    address owner;
    
    constructor()public{
        owner = msg.sender;
    }
    
    modifier isOwner(){
        require(owner==msg.sender);
        _;
    }

    // 向合约打eth,用于转账
    function sendEth()public payable{
        
    }
    
    // 获取合约余额
    function getBalance() isOwner() public view returns(uint256){
        return address(this).balance;
    }
    
    //转账,每个用户转等额的eth
    function batchTransfer(address[] _users,uint256 _money) isOwner() public returns(bool){
        require(_users.length>0);
        for(uint32 i=0;i<_users.length;i++){
            _users[i].transfer(_money);
        }
        return true;
    }
    
    //转账,每个用户转对应的eth
    function anotherTransfer(address[] _users,uint256[] _money) isOwner() public returns(bool){
        require(_users.length>0);
        require(_users.length==_money.length);
        for(uint32 i=0;i<_users.length;i++){
            _users[i].transfer(_money[i]);
        }
        return true;
    }
    
    // 摧毁合约,剩余的eth转入合约归属者
    function kill() isOwner() public{
        selfdestruct(owner);
    }
    
}