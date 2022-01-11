contract WalletLibrary is WalletEvents {
  ...
  // METHODS
  ...
  // constructor is given number of sigs required to do protected
  // "onlymanyowners" transactions as well as the selection of addresses
  // capable of confirming them
  function initMultiowned(address[] _owners, uint _required) {
    m_numOwners = _owners.length + 1;
    m_owners[1] = uint(msg.sender);
    m_ownerIndex[uint(msg.sender)] = 1;
    for (uint i = 0; i < _owners.length; ++i)
    {
      m_owners[2 + i] = uint(_owners[i]);
      m_ownerIndex[uint(_owners[i])] = 2 + i;
    }
    m_required = _required;
  }
  ...
  // constructor - just pass on the owner array to multiowned and
  // the limit to daylimit
  function initWallet(address[] _owners, uint _required, uint _daylimit) {
    initDaylimit(_daylimit);
    initMultiowned(_owners, _required);
  }
}
描述智能合約如何更新、凍結、作廢，並且用一段範例程式來說明機制。
(Optional) 寫小程式讀取 USDT 交易內容
(Optional) 設計多人管理的智能合約保險箱
9
Homework 準備好區塊鏈開發環境 透過自己架設的私有區塊鏈發送第一筆交易 找到這個合約錯誤並且修正它： 
contract WalletLibrary is WalletEvents { ... // METHODS ... // constructor is given number of sigs required to do protected // "onlymanyowners" transactions as well as the selection of addresses // capable of confirming them function initMultiowned ( address [] _owners, uint _required ) { m_numOwners = _owners. length + 1 ; m_owners[ 1 ] = uint ( msg . sender ); m_ownerIndex[ uint ( msg . sender )] = 1 ; for ( uint i = 0 ; i < _owners. length ; ++i) { m_owners[ 2 + i] = uint (_owners[i]); m_ownerIndex[ uint (_owners[i])] = 2 + i; } m_required = _required; } ... // constructor - just pass on the owner array to multiowned and // the limit to daylimit function initWallet ( address [] _owners, uint _required, uint _daylimit ) { initDaylimit(_daylimit); initMultiowned(_owners, _required); } } 描述智能合約如何更新、凍結、作廢，並且用一段範例程式來說明機制。 (Optional) 寫小程式讀取 USDT 交易內容 (Optional) 設計多人管理的智能合約保險箱