# MadProps

MadProps is a simple gem to explore the Property Pattern as described by Steve
Yegge in his (massive) blog post:

[ The Universal Design Pattern
](http://steve-yegge.blogspot.com/2008/10/universal-design-pattern.html)

The Property Pattern is a deceptively simple pattern.  MadProp objects are
essentially a property list, but with a twist.  They contain a link to a
"prototype" or "base" object.  This enables the objects to inherit properties
from it's parent up the inheritance tree.

That's it.  Of course, being geeks we will overly comlicate it with caching,
recursion and YML files.  And maybe even some NoSQL to make it especially
buzzword compliant.

### Properties

Properties can be the following types:

* Float
* Int
* Boolean
* String
* Nil
* Reference (to another MadProp object)

MadProps objects can be initialized with a hash and support simple lookups.

## Usage

    randy = MadProps::Props.new {
        key: 'geek:dad',
        name: 'Randy',
        town: 'Austin',
        is:   [ 'charming', 'good looking']
    }

    wyatt = MadProps.new {
        key: 'geek:son',
        proto, 'geek:dad',
        name: 'Wyatt'
    }

    # wyatt inherits all properties from his proto property except the ones he overrides
    puts "#{wyatt.name} lives in #{wyatt.town}"
    # => Wyatt lives in Austin

    puts "#{wyatt.name} is #{wyatt.is.join(',')}"
    # => Wyatt is charming, good looking

## Special keys

The _key_ property identifies a MadProp object.  If and when caching
is introduced, it will use this unique identifier.

The _proto_ property identifies the parent to inherit from. When getting
a property, we look at the object to see if it has that property.  If not,
we use the _proto_ pointer to see if the parent has it. We do this recursively
up the inheritance tree.

We setting a property, we simply set the property on that object.  Now,
lookups will use this property.

## Caching

Obviously, the runtime lookup for properties can be speedup with some
caching.  Of course, once you add caching to anything, it gets more
complicated.

## Installation

Add this line to your application's Gemfile:

    gem 'mad_props'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mad_props

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
