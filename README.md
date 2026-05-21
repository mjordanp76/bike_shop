# Bicycle Website

A basic website for a fictitious bicycle brand "Hobby Bikes", built to practice Ruby, ERB templates, and SEO principles.

## Features
- Home page
- User registration & login/logout system
- Product catalog
- Shopping cart functionality
- Fake order placement
- Database containing users, bicycles, carts, and orders
- Basic SEO-friendly structure

## Tech Stack
- Ruby
    - Sinatra
    - pg
    - bcrypt
    - rackup
    - puma
- ERB (Embedded Ruby)
- HTML / CSS

## TO-DO
- Add a few more bicycles to the catalog
- Add functionality to edit number of a particular item in cart
- Verify inventory before adding to cart or placing order
- Add order/purchase logic
    - Updating the database when an order is placed
    - Clear cart
    - Show order confirmation
- Security improvements
    - Password validation
    - Other input validation
- Authorization
    - Ensure user can only see THEIR cart/orders
- UX improvements