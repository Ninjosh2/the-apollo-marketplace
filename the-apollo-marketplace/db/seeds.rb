#Adding in some user and sale entries 

ren = User.create(name: "Ren", email: "renthepup@gmail.com", password: "puppy")

richard = User.create(name: "Richard", email: "richardthecat@gmail.com", password: "kitty")


SaleEntry.create(item: "Check out this awesome guitar!", description: "It is red and has single coil pickups.", price: 600, user_id: ren.id)

richard.sale_entries.create(item: "I'm selling this drum kit.", description: "it's just the kick and snare", price: 1000)
