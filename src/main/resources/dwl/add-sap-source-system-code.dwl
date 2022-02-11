%dw 2.0
fun formatDateTime(localTime: DateTime) = localTime as String{format: "yyyy-MM-dd HH:mm:ss.SSS"}
output application/json
var party = [{
    'type': vars.customerInfo[0].'type',
    accountName: vars.customerInfo[0].Name,
    phone: vars.customerInfo[0].Phone,
    accountNumber: vars.customerInfo[0].AccountNumber,
    address: [{
    	role: "billing",
    	street: vars.customerInfo[0].BillingAddress.street,
    	city: vars.customerInfo[0].BillingAddress.city,
    	state: vars.customerInfo[0].BillingAddress.state,
    	country: vars.customerInfo[0].BillingAddress.country default 'US',
    	countryCode: vars.customerInfo[0].BillingAddress.countryCode default '1',
    	postalCode: vars.customerInfo[0].BillingAddress.postalCode,
    },{
    	role: "shipping",
    	street: vars.customerInfo[0].ShippingAddress.street,
    	city: vars.customerInfo[0].ShippingAddress.city,
    	state: vars.customerInfo[0].ShippingAddress.state,
    	country: vars.customerInfo[0].ShippingAddress.country default 'US',
    	countryCode: vars.customerInfo[0].ShippingAddress.countryCode default '1',
    	postalCode: vars.customerInfo[0].ShippingAddress.postalCode,
    }
    ]
}]
---
payload update {
    case .order -> $ update {
        case .source -> '123'
        case .orderDateTime -> formatDateTime(payload.order.orderDateTime >> 'PST')
        case .receivedDateTime -> now()
        case .currentTimeZone! -> java!com::test::TimeZoneUtil::getCurrentTimeZone()
        case .party! -> party   
    }
}