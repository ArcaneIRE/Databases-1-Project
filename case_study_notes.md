# Case Study - Burger Shack

## General Info

- Irish restaurant franchise
- Want a web app for booking tables and checking receipts
- Restaurant managers can use app to see details on customers, staff and managers at every branch

## Details

- Each restaurant has a unique `numeric ID`, an `address` and a `phone number`
- Customers can book `online`, by `phone` or by `talking to a manager` (who then uses the app)
- To make a `booking`:
  - The customer MUST provide: `Name`, `address`, `email address` and `age`
  - Their `age MUST be over 18`
  - The customer is assigned an ID (`customer number`)
- The main customer making the booking is assigned a `booking receipt`
  - Includes `booking ID number`, `booked time` and `number of people`
  - Max `number of people` is 8
  - A customer can have many bookings, and each booking is tied to a single customer
- Each `table` in a restaurant:
  - has a `unique number`, details on the `size` of table (`2`, `4`, `6`, `8`) and location (`window` or `interior`)

## Health Concerns

- When a party arrives at the restaurant, for each person the following details must be recorded:
  - `Table number`, `name`, `address` and `phone number`
- The details of the `waiter` and `manager` who served the table must be recorded
  - All staff have a `unique ID`
  - Each staff member is assigned to a `branch`
    - This `location` is stored as a part of their `employment record`
  - Their `name`, `address`, `phone number`, `email address`, `date of birth` and `start date` of employment must be recorded
    - All email addresses are staff email addresses ending with `@burgershack.com`
