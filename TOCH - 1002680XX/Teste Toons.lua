--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,5)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--Hand
Debug.AddCard(100268002,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(15259703,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(15270885,0,0,LOCATION_HAND,0,POS_FACEDOWN)
--Monster Zones
Debug.AddCard(75878039,0,0,LOCATION_MZONE,0,4,true)
--Spell & Trap Zones
Debug.AddCard(17626381,0,0,LOCATION_SZONE,1,5)
Debug.AddCard(100268003,0,0,LOCATION_SZONE,2,10)
--Debug.AddCard(100268005,0,0,LOCATION_SZONE,0,10)
--Spell & Trap Zones
Debug.AddCard(17626381,1,1,LOCATION_SZONE,3,10)
Debug.ReloadFieldEnd()
aux.BeginPuzzle()