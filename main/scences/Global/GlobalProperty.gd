extends Node
var Property = {
	"Coin":10
	}
	

func spend_coins(amount: int) -> bool:
	if Property["Coin"] >= amount:
		Property["Coin"] -= amount
		return true
	else:
		return false
