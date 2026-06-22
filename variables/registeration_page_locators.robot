*** Variables ***
${resgistration_link}  xpath=//a[text()="Register"]
${first_name_field}  id=customer.firstName
${last_name_field}  id=customer.lastName
${address_field}  id=customer.address.street
${city_field}  id=customer.address.city
${state_field}  id=customer.address.state
${zipcode_field}  name=customer.address.zipCode
${phone_number_field}  id=customer.phoneNumber
${ssn_field}  id=customer.ssn
${username_register_field}  id=customer.username
${password_register_field}  id=customer.password
${confirm_field}  id=repeatedPassword
${register_button}  xpath=//input[@value="Register"]