event_inherited()

mask_index = s_vendor_collision

npcKey = "vendorShop"

load_dialogue()

shop = false
shopIndex = 0

shopList = ds_list_create()
shopList[| 0] = new player._create_item(item.sandwich)
shopList[| 1] = new player._create_item(item.watch)
