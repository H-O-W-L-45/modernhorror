ITEM.name = "Morley Cigarettes"
ITEM.desc = "A box of cigarettes."
ITEM.model = "models/props_lab/box01a.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.health = 0
ITEM.price = 5
ITEM.notifylocal = "You open the packet and"
ITEM.functions.Use = {
    sound = "physics/body/body_medium_impact_soft1.wav",
    onRun = function(item)
        local client = item.player
        local r = math.random( 1 );
        
        if( r == 1 ) then
                
				client:getChar():getInv():add(item.items[1]);
            end

		if( r == 2 ) then
                
                client:getChar():getInv():add(item.items[3]);
				client:getChar():getInv():add(item.items[1]);
            end
			
        if( r == 3 ) then
                
                client:getChar():getInv():add(item.items[4]);
                client:getChar():getInv():add(item.items[1]);            
            end
			
        if( r == 4 ) then
                
                client:getChar():getInv():add(item.items[5]);
                client:getChar():getInv():add(item.items[1]);       
            end
			
        if( r == 5 ) then
                
                client:getChar():getInv():add(item.items[6]);
                client:getChar():getInv():add(item.items[1]);
				              
            end			
			
         if( r == 6 ) then
                
                client:getChar():getInv():add(item.items[7]);
                client:getChar():getInv():add(item.items[1]);
				              
            end       
			
        if( r == 7 ) then
                
                client:getChar():getInv():add(item.items[8]);
                client:getChar():getInv():add(item.items[1]);
				              
            end
			
        if( r == 8 ) then
                
                client:getChar():getInv():add(item.items[9]);
                client:getChar():getInv():add(item.items[1]);

            end
			
        if( r == 9 ) then
                
                client:getChar():getInv():add(item.items[10]);
                client:getChar():getInv():add(item.items[1]);

				              
            end
			
        if( r == 10 ) then
                
                client:getChar():getInv():add(item.items[11]);
                client:getChar():getInv():add(item.items[1]);
            end
			
        if( r == 11 ) then
                
                client:getChar():getInv():add(item.items[12]);
                client:getChar():getInv():add(item.items[1]);

            end
			
        if( r == 12 ) then
                
                client:getChar():getInv():add(item.items[13]);
                client:getChar():getInv():add(item.items[1]);

				              
            end
			
        if( r == 13 ) then
                
                client:getChar():getInv():add(item.items[14]);
                client:getChar():getInv():add(item.items[1]);
				              
            end
			
        if( r == 14 ) then
                
                client:getChar():getInv():add(item.items[15]);
                client:getChar():getInv():add(item.items[1]);
								
            end
			
        if( r == 15 ) then
                
                client:getChar():getInv():add(item.items[16]);
                client:getChar():getInv():add(item.items[1]);
				              
            end
        if( r == 16 ) then
                
                client:getChar():getInv():add(item.items[17]);
                client:getChar():getInv():add(item.items[1]);

				              
            end	
			
        if( r == 17 ) then
                
                client:getChar():getInv():add(item.items[18]);
                client:getChar():getInv():add(item.items[1]);
	
				              
            end
			
        if( r == 18 ) then
                
                client:getChar():getInv():add(item.items[19]);
                client:getChar():getInv():add(item.items[1]);

				              
            end
			
        if( r == 19 ) then
                
                client:getChar():getInv():add(item.items[20]);
                client:getChar():getInv():add(item.items[1]);
     
            end		
			
        item.player:SetHealth(item.player:Health() - item.health)
        item.player:notifyLocalized("You open the packet of cigs and sadly find only a single smoke left.") --Send message to player
    end
}
ITEM.items = {"cigarette", "card1", "card2", "card3", "card4", "card5", "card6", "card7", "card8", "card9", "card10", "card11", "card12", "card13", "card14", "card15", "card16","card17", "card18", "card19", } -- just replace it with the name of the card items in the files (without sh_ )