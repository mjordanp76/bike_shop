# Bicycle Website

A simple e-commerce website for the fictional bicycle brand Hobby Bikes, built to practice Ruby, Sinatra, ERB templating, PostgreSQL, and basic SEO principles. As this was done for practice, the site is not fully functional (there is no way to place an order, for example).

**Live Demo:** [Hobby Bikes](https://bikeshop-production-3aac.up.railway.app)

## Features
- Home page
- User registration & login/logout system
- Product catalog
- Shopping cart functionality
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

## Challenges & Lessons Learned

- Learned to manage Ruby versions with rbenv and isolate project dependencies using Bundler and a Gemfile.
- Implemented secure password hashing with bcrypt.
- Built session-based authentication in Sinatra.
- Applied some basic principles to improve SEO:
    - Title, meta, and heading tags with keywords
    - Keywords with easy/medium KD, avoiding hard KD keywords
    - Unique meta descriptions for each page to incraese click-through rates
    - Slugs instead of simple id's in URLs
    - Specifc CTAs to drive results
    - Image SEO (descriptive alt texts and file names, compressed files)
- Became more familiar with the Ruby language.
- Deployed site using Railway for public visibility.