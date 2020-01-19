# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

    Currency.where(code: 'EUR').first_or_create!(value: 1, symbol: '€')
    Currency.where(code: 'BAM').first_or_create!(value: 1.95, symbol: 'KM')
    User.where(email: 'ademdinarevic@gmail.com').first_or_create(password: 'adam123',  password_confirmation: 'adam123', first_name: 'Adem', last_name: 'Dinarević', is_admin: true, locale: 'bs' })

