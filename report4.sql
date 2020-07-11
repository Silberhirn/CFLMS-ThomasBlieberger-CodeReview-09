/* shows who recieved how many packeges */
select firstname, lastname, count(package_outgoing.package_out_ID) from package_outgoing
left join package_incoming on fk_package_inc_ID=package_ID
join recipient on fk_recipient_ID=reipient_ID
group by reipient_ID