/* How many packages were sent from each city? */
select count(package_ID) from package_incoming 
left join client on fk_client_ID=client_ID 
left join address on fk_address_ID=address_ID 
left join city on ZIP=fk_ZIP 
group by city_name