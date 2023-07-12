# README

[![Contributors](https://img.shields.io/github/contributors/CrowRising/rails-engine.svg)](https://github.com/CrowRising/rails-engine/graphs/contributors)
[![Forks](https://img.shields.io/github/forks/CrowRising/rails-enginesvg)](https://github.com/CrowRising/rails-engine/forks)
[![Stargazers](https://img.shields.io/github/stars/CrowRising/rails-engine.svg)](https://githuB.com/CrowRising/rails-engine/stargazers)
[![Issues](https://img.shields.io/github/issues/CrowRising/rails-engine.svg)](https://github.com/CrowRising/rails-engine/issues)

# Rails Engine Lite

## About This Project
### Mod 3 Solo Project
You are working for a company developing an E-Commerce Application. Your team is working in a service-oriented architecture, meaning the front and back ends of this application are separate and communicate via APIs.
<br><br>
<img src= "https://imatrix.com/wp-content/uploads/sites/12/2021/03/ecommerce-1024x536.jpg">
                    
## Purpose

The purpose of this project was to expose the data the poweres the site through an API that the front end (in theory) would consume. There is no actual front end for this project.

## Built With
* ![Ruby](https://img.shields.io/badge/ruby-%23CC342D.svg?style=for-the-badge&logo=ruby&logoColor=white)
* ![Postgresql](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)
* ![Rails](https://img.shields.io/badge/rails-%23CC0000.svg?style=for-the-badge&logo=ruby-on-rails&logoColor=white)
* ![Visual Studio Code](https://img.shields.io/badge/Visual%20Studio%20Code-0078d7.svg?style=for-the-badge&logo=visual-studio-code&logoColor=white)
* ![Love](https://ForTheBadge.com/images/badges/built-with-love.svg)


## Running On
  - Rails 7.0.6
  - Ruby 3.2.2

## <b>Getting Started</b>

To get a local copy, follow these simple instructions

### <b>Installation</b>

1. Fork the Project
2. Clone the repo 
``` 
git clone git@github.com:CrowRising/rails-engine.git 
```
3. Install the gems
```
bundle install
```
4. Create the database
```
rails db:{drop,create,migrate, seed}
```
5. Check to see that your schema exists
```
there should be 6 tables
```
7. Create your Feature Branch 
```
git checkout -b feature/AmazingFeature
```
8. Commit your Changes 
```
git commit -m 'Add some AmazingFeature' 
```
9. Push to the Branch 
```
git push origin feature/AmazingFeature
```
10. Open a Pull Request

## RESTful Endpoints Used

<div style="overflow: auto; height: 200px;">
  <pre>
    <code>
      GET '/api/v1/merchants' - All Merchants
      GET '/api/v1/merchants/:id' - One Merchant
      GET '/api/v1/items' - All Items
      GET '/api/v1/item/:id' - One Item
      POST '/api/v1/items/:id' - Create Item
      PUT '/api/v1/items/:id' - Update Item
      DELETE /api/v1/items/:id - Delete Item Invoice
      GET '/api/v1/merchants/:merchant_id/items' - Merchant's Items
      GET '/api/v1/items/:item_id/merchant' - Item's Merchant
    </code>
  </pre>
</div>


## Schema
```
 create_table 'customers', force: :cascade do |t|
    t.string 'first_name'
    t.string 'last_name'
    t.datetime 'created_at', precision: nil, null: false
    t.datetime 'updated_at', precision: nil, null: false
  end

  create_table 'invoice_items', force: :cascade do |t|
    t.bigint 'item_id'
    t.bigint 'invoice_id'
    t.integer 'quantity'
    t.float 'unit_price'
    t.datetime 'created_at', precision: nil, null: false
    t.datetime 'updated_at', precision: nil, null: false
    t.index ['invoice_id'], name: 'index_invoice_items_on_invoice_id'
    t.index ['item_id'], name: 'index_invoice_items_on_item_id'
  end

  create_table 'invoices', force: :cascade do |t|
    t.bigint 'customer_id'
    t.bigint 'merchant_id'
    t.string 'status'
    t.datetime 'created_at', precision: nil, null: false
    t.datetime 'updated_at', precision: nil, null: false
    t.index ['customer_id'], name: 'index_invoices_on_customer_id'
    t.index ['merchant_id'], name: 'index_invoices_on_merchant_id'
  end

  create_table 'items', force: :cascade do |t|
    t.string 'name'
    t.string 'description'
    t.float 'unit_price'
    t.bigint 'merchant_id'
    t.datetime 'created_at', precision: nil, null: false
    t.datetime 'updated_at', precision: nil, null: false
    t.index ['merchant_id'], name: 'index_items_on_merchant_id'
  end

  create_table 'merchants', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', precision: nil, null: false
    t.datetime 'updated_at', precision: nil, null: false
  end

  create_table 'transactions', force: :cascade do |t|
    t.bigint 'invoice_id'
    t.string 'credit_card_number'
    t.string 'credit_card_expiration_date'
    t.string 'result'
    t.datetime 'created_at', precision: nil, null: false
    t.datetime 'updated_at', precision: nil, null: false
    t.index ['invoice_id'], name: 'index_transactions_on_invoice_id'
  end

  add_foreign_key 'invoice_items', 'invoices'
  add_foreign_key 'invoice_items', 'items'
  add_foreign_key 'invoices', 'customers'
  add_foreign_key 'invoices', 'merchants'
  add_foreign_key 'items', 'merchants'
  add_foreign_key 'transactions', 'invoices'
end
```

## Contributing  [![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/CrowRising/rails-engine/blob/main/spec/requests/api/v1/search_all_item_request_spec.rb)
Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!


## Authors

- Crow Rising [![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white) ](https://github.com/CrowRising) [![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white) ](https://www.linkedin.com/in/crowrising/)


