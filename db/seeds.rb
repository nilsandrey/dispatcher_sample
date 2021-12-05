# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

medications = Medication.create(
  [{
     name: 'colestipol hcl',
     weight: 500,
     code: 'XBAY6Q68_32YHIU57DK6',
     image: 'https://img.medscapestatic.com/pi/features/drugdirectory/octupdate/GSO02602.jpg'
   },
   {
     name: 'dicyclomine tablet',
     weight: 20,
     code: 'FIZH8A0F7PDRG38Q55YJ',
     image: 'https://dailymed.nlm.nih.gov/dailymed/image.cfm?name=dicyclomine-hydrochloride-tablets-usp-2.jpg&id=518508'
   },
   {
     name: 'meclizine HCI',
     weight: 25,
     code: 'QQPF211I_0XW73AFNGH6',
     image: 'https://cdn.shopify.com/s/files/1/0266/2521/2488/products/51HhlcmR-WL._AC_SL1000_388x.jpg?v=1610842863'
   }
  ]
)

drones = Drone.create(
  [
    {serial_number: '2RICRPCUA43G5D',
     model: 'lightweight',
     weight_limit: 500,
     battery: 100,
     state: :idle
    },
    {serial_number: '2VBAGM9KAVQU54',
     model: :middleweight,
     weight_limit: 600,
     battery: 50,
     state: :idle,
    }
  ]
)
