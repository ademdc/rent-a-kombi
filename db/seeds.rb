# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

User.where(email: 'ademdinarevic@gmail.com').first_or_create(password: 'adam123',  password_confirmation: 'adam123', first_name: 'Adem', last_name: 'Dinarević', is_admin: true, locale: 'bs')

Currency.where(code: 'EUR').first_or_create!(value: 1, symbol: '€')
Currency.where(code: 'BAM').first_or_create!(value: 1.95, symbol: 'KM')


Category.where(name: 'Small Car').first_or_create
Category.where(name: 'Limousine').first_or_create
Category.where(name: 'Caravan').first_or_create
Category.where(name: 'Cabrio').first_or_create
Category.where(name: 'SUV').first_or_create
Category.where(name: 'Sport').first_or_create
Category.where(name: 'Caddy').first_or_create
Category.where(name: 'Van').first_or_create

PurchaseItem.where(title: '100 ducats',  price_cents: 10000).first_or_create
PurchaseItem.where(title: '250 ducats',  price_cents: 20000).first_or_create
PurchaseItem.where(title: '750 ducats',  price_cents: 50000).first_or_create

