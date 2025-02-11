--Machine Angel Ascension
--Scripted by The Razgriz
local s,id=GetID()
function s.initial_effect(c)
	aux.AddSkillProcedure(c,1,false,s.flipcon,s.flipop,1)
end
s.listed_series={0x2093,0x124}
--Discard filter
function s.tgfilter(c)
	return c:IsType(TYPE_SPELL) and c:IsDiscardable()
end
--Filter for "Cyber Angel" Ritual Monsters or "Machine Angel" Ritual Spells to be added to hand
function s.thfilter(c)
	return (c:IsType(TYPE_RITUAL) and c:IsType(TYPE_SPELL) and c:IsSetCard(0x124)) or (c:IsType(TYPE_RITUAL) and c:IsMonster() and c:IsSetCard(0x2093)) and c:IsAbleToHand()
end
--Filter for "Cyber Angel" Ritual Monsters or "Machine Angel" Ritual Spells to be shuffled into Deck
function s.tdfilter(c)
	return (c:IsType(TYPE_RITUAL) and c:IsType(TYPE_SPELL) and c:IsSetCard(0x124)) or (c:IsType(TYPE_RITUAL) and c:IsMonster() and c:IsSetCard(0x2093)) and c:IsAbleToDeck()
end
function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
	--opd check
	local c=e:GetHandler()
	local b1=Duel.GetFlagEffect(ep,id)==0 and Duel.IsExistingMatchingCard(s.tgfilter,tp,LOCATION_HAND,0,1,nil) and Duel.IsExistingMatchingCard(s.thfilter,tp,LOCATION_DECK,0,1,nil)
	local b2=Duel.GetFlagEffect(ep,id+100)==0 and Duel.IsExistingMatchingCard(s.tdfilter,tp,LOCATION_GRAVE,0,1,nil)
	--condition
	return aux.CanActivateSkill(tp) and (b1 or b2) and Duel.GetTurnPlayer()==tp
end
function s.cfilter(c)
	return not c:IsPublic()
end
function s.flipop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
	Duel.Hint(HINT_CARD,tp,id)
	local c=e:GetHandler()
	local b1=Duel.GetFlagEffect(ep,id)==0 and Duel.IsExistingMatchingCard(s.tgfilter,tp,LOCATION_HAND,0,1,nil) and Duel.IsExistingMatchingCard(s.thfilter,tp,LOCATION_DECK,0,1,nil)
	local b2=Duel.GetFlagEffect(ep,id+100)==0 and Duel.IsExistingMatchingCard(s.tdfilter,tp,LOCATION_GRAVE,0,1,nil)
	local op=0
	if b1 and b2 then
		op=Duel.SelectOption(tp,aux.Stringid(id,0),aux.Stringid(id,1))
	elseif b1 then
		op=Duel.SelectOption(tp,aux.Stringid(id,0))
	else
		op=Duel.SelectOption(tp,aux.Stringid(id,1))
	end
	if not (b1 or b2) then return false end
	if (b1 and op==0) or Duel.GetFlagEffect(ep,id+100)>0 then
			Duel.RegisterFlagEffect(ep,id,0,0,0)
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
			local tg=Duel.SelectMatchingCard(tp,s.tfilter,tp,LOCATION_HAND,0,1,1,nil):GetFirst()
			if Duel.SendtoGrave(tg,REASON_COST+REASON_DISCARD)>0 and tg:IsLocation(LOCATION_GRAVE) then
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
				local th=Duel.SelectMatchingCard(tp,s.thfilter,tp,LOCATION_DECK,0,1,1,nil):GetFirst()
				Duel.SendtoHand(th,tp,REASON_EFFECT)
			end
	 elseif b2 and op==1 or Duel.GetFlagEffect(ep,id)>0 then
			Duel.RegisterFlagEffect(ep,id+100,0,0,0)
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
			local td=Duel.SelectMatchingCard(tp,s.tdfilter,tp,LOCATION_GRAVE,0,1,1,nil):GetFirst()
			Duel.SendtoDeck(td,tp,2,REASON_EFFECT)
	end
end
