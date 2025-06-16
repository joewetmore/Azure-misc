Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline

get-mailbox -ResultSize unlimited | where {($_.ForwardingsmtpAddress -ne $null)} | select Name, ForwardingsmtpAddress, DeliverToMailboxAndForward
