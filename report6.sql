/* shows how long the delivery of the packages took and the average time */
select package_ID, pickup.date as PickupDate, delivery.date as DeliveryDate, timestampdiff(DAY, pickup.date, delivery.date) as DeliveryDays, cast(X.`avg` as int) as `Avg` from package_incoming 
join pickup on pickup_ID=fk_pickup_ID
join package_outgoing  on package_ID=fk_package_inc_ID
join delivery on fk_delivery_ID=delivery_ID
cross join (select avg(timestampdiff(DAY, pickup.date, delivery.date)) as `avg`
            from package_incoming 
			join pickup on pickup_ID=fk_pickup_ID
			join package_outgoing  on package_ID=fk_package_inc_ID
			join delivery on fk_delivery_ID=delivery_ID) as X