# Bicycle Website

A simple e-commerce website for the fictional bicycle brand Hobby Bikes, built to practice Ruby, Sinatra, ERB templating, PostgreSQL, and basic SEO principles.

**Live Demo:** [Hobby Bikes](bikeshop-production-3aac.up.railway.app)

## Features
- Home page
- User registration & login/logout system
- Product catalog
- Shopping cart functionality
- Simulated checkout process
- Basic SEO-friendly structure
- Database containing users, bicycles, carts, and orders

## Tech Stack
- Ruby
- ERB (Embedded Ruby)
- HTML / CSS
- PostgreSQL database

### Gems
- Sinatra
- pg
- bcrypt
- dotenv
- rackup
- puma

## Future Improvements

### Catalog
- Add additional bicycles and product details

### Shopping Cart
- Allow users to update item quantities in the cart
- Verify inventory before adding items to the cart

### Orders
- Persist completed orders to the database
- Clear cart after successful checkout
- Display order confirmation page

### Security
- Improve password validation
- Add server-side input validation

### Authorization
- Restrict users to viewing only their own carts and orders

### User Experience
- Improve site navigation and overall UI/UX

### Deployment & SEO
- Deploy the application and perform SEO analysis using Ahrefs

## Challenges & Lessons Learned

- Learned to manage Ruby versions with rbenv and isolate project dependencies using Bundler and a Gemfile.
- Implemented secure password hashing with bcrypt.
- Built session-based authentication in Sinatra.
- Improved page structure and metadata with basic SEO principles.
- Became more familiar with the Ruby language.
- Deployed site using Railway for public visibility.