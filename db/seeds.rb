# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


user1 = User.create(
    name:                  "Diego Niquefa",
    email:                 "dsniquefav@unal.edu.co",
    password:              "password",
    password_confirmation: "password" );

user2 = User.create(
    name:                  "Laura Chaparro",
    email:                 "lachaparrog@unal.edu.co",
    password:              "password",
    password_confirmation: "password" );

user3 = User.create(
    name:                  "Felipe Epía",
    email:                 "lfepiar@unal.edu.co",
    password:              "password",
    password_confirmation: "password" );

user4 = User.create(
    name:                  "Juliana Niño",
    email:                 "jucninova@unal.edu.co",
    password:              "password",
    password_confirmation: "password" );

user5 = User.create(
    name:                  "Marcela Guzman",
    email:                 "mnguzmanc@unal.edu.co",
    password:              "password",
    password_confirmation: "password" );