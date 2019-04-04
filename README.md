# TODO list with Trailblazer and GraphQL

A Simple Example on How to Build an API App Based on Trailblazer and GraphQL.

The related article is located by [link](https://rubygarage.org/blog/graphql-and-trailblazer-tutorial/).

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Installing

Clone the repo:
```
git clone git@github.com:rubygarage/graphql-tutorial.git
```

Install bundler
```
gem install bundler
```

Run bundle in project directory
```
bundle install
```

Create database

```
rails db:create
rails db:migrate

# or just rails db:setup
```

Run Server
```
rails s
```

### Running the tests

```
rspec
```

## FAQ

### Where is IDE for exploring GraphQL?

The in-browser IDE for exploring GraphQL is available from within app (under the http://localohost:3000/graphiql path)

## Built With

* [Rails](http://guides.rubyonrails.org/v5.2/) - The web framework used
* [Bundler](http://bundler.io/) - Dependency Management
* [Trailblazer](http://trailblazer.to/blog/2017-12-trailblazer-2-1-what-you-need-to-know.html/) - A gem for creating a high-level architecture in an application
* [GraphQL](https://graphql-ruby.org//) - A query language for getting data and declaring its structure
