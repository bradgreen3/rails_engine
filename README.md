### Rails Engine

Rails Engine is a JSON API which exposes the SalesEngine data schema.

### Setup

 * ```git clone git@github.com:bradgreen3/rails_engine.git```

 * Bundle gem file: ```bundle```

 * Set up database: ```rake db:{create,migrate}```

 * Seed database with ```rake import```


### Rails version
  * 5.0.0.1

### Services

#### Record Endpoints

* ``` GET /api/v1/merchants.json ``` returns an index of all merchants
* ``` GET /api/v1/merchants1.json ``` returns merchant with an id of 1

##### Single Finders

* ``` GET /api/v1/merchants/find?name=Schroeder-Jerde ```  finds merchant with name of Schroeder-Jerde

##### Multi Finders

* ``` GET /api/v1/merchants/find_all?name=Cummings-Thiel ``` finds all merchants with name of Cummings-Thiel

##### Random

* ``` api/v1/merchants/random.json ``` returns a random merchant

#### Relationship Endpoints
###### Merchants
* ``` GET /api/v1/merchants/:id/items ``` returns a collection of items associated with that merchant
* ``` GET /api/v1/merchants/:id/invoices ``` returns a collection of invoices associated with that merchant from their known orders

###### Invoices
* ``` GET /api/v1/invoices/:id/transactions ``` returns a collection of associated transactions
* ``` GET /api/v1/invoices/:id/invoice_items ``` returns a collection of associated invoice items
* ``` GET /api/v1/invoices/:id/items ``` returns a collection of associated items
* ``` GET /api/v1/invoices/:id/customer ``` returns the associated customer
* ``` GET /api/v1/invoices/:id/merchant ``` returns the associated merchant

###### Invoice Items
* ``` GET /api/v1/invoice_items/:id/invoice ``` returns the associated invoice
* ``` GET /api/v1/invoice_items/:id/item ``` returns the associated item

###### Items
* ``` GET /api/v1/items/:id/invoice_items ``` returns a collection of associated invoice items
* ``` GET /api/v1/items/:id/merchant ``` returns the associated merchant

###### Transactions
* ``` GET /api/v1/transactions/:id/invoice ``` returns the associated invoice

###### Customers
* ``` GET /api/v1/customers/:id/invoices ``` returns a collection of associated invoices
* ``` GET /api/v1/customers/:id/transactions ``` returns a collection of associated transactions

#### Business Intelligence Endpoints

###### All Merchants

* ``` GET /api/v1/merchants/most_revenue?quantity=x ``` returns the top x merchants ranked by total revenue
* ``` GET /api/v1/merchants/most_items?quantity=x ``` returns the top x merchants ranked by total number of items sold
* ``` GET /api/v1/merchants/revenue?date=x ``` returns the total revenue for date x across all merchants

##### Single Merchant

* ``` GET /api/v1/merchants/:id/revenue ``` returns the total revenue for that merchant across all transactions
* ``` GET /api/v1/merchants/:id/revenue?date=x ``` returns the total revenue for that merchant for a specific invoice date x
* ``` GET /api/v1/merchants/:id/favorite_customer ``` returns the customer who has conducted the most total number of successful transactions.

##### Items

* ``` GET /api/v1/items/most_revenue?quantity=x ``` returns the top x items ranked by total revenue generated

##### Customers

* ``` GET /api/v1/customers/:id/favorite_merchant ``` returns a merchant where the customer has conducted the most successful transactions

### Authors
Brad Green <br>
Matt DeMarteau