/* gives overview over all packages, who sent them to whom, when it was picked up
and by whom and when it was delivered and by whom) */
select CONCAT ( client.firstname, ' ', client.lastname) as `Client Name`, package_incoming.package_ID, concat(recipient.firstname, ' ', recipient.lastname) as `Recipient Name`, pickup.date as `Pickup Date`, PickupEmp.`Pickup Name`, IFNULL( delivery.date, "not yet delivered") as `Delivery Date`, DeliveryEmp.`Delivery Name` 
from package_incoming
left join pickup on fk_pickup_ID=pickup_ID
left join client on fk_client_ID=client_ID
left join package_outgoing on package_ID=fk_package_inc_ID
left join delivery on fk_delivery_ID=delivery_ID
left join (select picker_ID, concat(employee.firstname,' ',employee.lastname) as `Pickup Name` from pickup_department join employee on fk_emp_ID=emp_ID where to_date>curdate()) as PickupEmp on picker_ID=fk_picker_ID
left join (select deliverer_ID, concat(employee.firstname,' ',employee.lastname) as `Delivery Name` from delivery_department join employee on fk_emp_ID=emp_ID where to_date>curdate()) as DeliveryEmp on deliverer_ID=fk_deliverer_ID
left join recipient on fk_recipient_ID=reipient_ID
order by `Pickup Date`