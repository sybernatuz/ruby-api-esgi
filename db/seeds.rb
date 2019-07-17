# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user1 = User.create({
                        username: 'user',
                        password_digest: BCrypt::Password.create('user'),
                        created_at:Time.now,
                        updated_at:Time.now,
                        role: 'ROLE_USER'
                    })

user2 = User.create({
                        username: 'user2',
                        password_digest: BCrypt::Password.create('user'),
                        created_at:Time.now,
                        updated_at:Time.now,
                        role: 'ROLE_USER'
                    })

post1 = Post.create({
                         title: 'Post title of user',
                         text: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Reiciendis aliquid atque, nulla? Quos cum ex quis soluta, a laboriosam. Dicta expedita corporis animi vero voluptate voluptatibus possimus, veniam magni quis!',
                         picture: 'https://i0.wp.com/ville-saint-sauveur-le-vicomte.fr/wp-content/uploads/2016/10/riviere-750x300.jpg?fit=750%2C300&ssl=1',
                         category: 'Nature',
                         user_id: 1,
                         created_at:rand(30.days).seconds.ago,
                         updated_at:rand(30.days).seconds.ago
                     })

post2 = Post.create({
                         title: 'Post title of user',
                         text: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Reiciendis aliquid atque, nulla? Quos cum ex quis soluta, a laboriosam. Dicta expedita corporis animi vero voluptate voluptatibus possimus, veniam magni quis!',
                         picture: 'https://www.lawsen-avocats.com/wp-content/uploads/droit-et-porosite-750x300.jpg',
                         category: 'IT',
                         user_id: 1,
                         created_at:rand(30.days).seconds.ago,
                         updated_at:rand(30.days).seconds.ago
                     })

post3 = Post.create({
                         title: 'Post title of user',
                         text: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Reiciendis aliquid atque, nulla? Quos cum ex quis soluta, a laboriosam. Dicta expedita corporis animi vero voluptate voluptatibus possimus, veniam magni quis!',
                         picture: 'https://pinnacleplacement.com/wp-content/uploads/employers-750x300.jpg',
                         category: 'IT',
                         user_id: 1,
                         created_at:rand(30.days).seconds.ago,
                         updated_at:rand(30.days).seconds.ago
                     })