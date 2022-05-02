global.pubsubManager =
{
	EventStruct : {},
	
	Subscribe : function(_id, event, func)
	{
		if (is_undefined(EventStruct[$ event]))
		{
			EventStruct[$ event] = [];
		}
		else if (IsSubscribed(_id, event) != -1)
		{
			return;
		} 
		array_push(EventStruct[$ event], [_id, func]);
	},
	
	Publish : function(event, data)
	{
		var subscriberArray = EventStruct[$ event];
		
		if (is_undefined(subscriberArray)) {
			return;
		}
		
		for (var i = (array_length(subscriberArray) - 1); i >= 0; i -= 1)
		{
			if (instance_exists(subscriberArray[i][PS_EVENT.INST_ID]))
			{ 
				subscriberArray[i][PS_EVENT.INST_FUNC](data);
			}
			else
			{
				array_delete(subscriberArray, i, 1);
			}
		}
	},
	
	IsSubscribed : function(_id, event)
	{
		for (var i = 0; i < array_length(EventStruct[$ event]); i += 1)
		{
			if (EventStruct[$ event][i][PS_EVENT.INST_ID] == _id)
			{
				return i;
			}
		}
		return -1;
	},
	
	Unsubscribe : function(_id, event)
	{
		if (is_undefined(EventStruct[$ event])) return;
	    
		var pos = IsSubscribed(_id, event);
		if (pos != -1) {
			array_delete(EventStruct[$ event], pos, 1);
		}
	},
	
	UnsubscribeAll : function(_id)
	{
		var keysArray = variable_struct_get_names(EventStruct);
		for (var i = (array_length(keysArray) - 1); i >= 0; i--) {
			Unsubscribe(_id, keysArray[i]);
		}
	},
	
	RemoveEvent : function(event)
	{
		if (variable_struct_exists(EventStruct, event))
		{
			variable_struct_remove(EventStruct, event);
		}
	},

	RemoveAllEvents : function()
	{
		delete EventStruct;
		EventStruct = {};
	},

	RemoveDeadInstances : function()
	{
		var keysArray = variable_struct_get_names(EventStruct);
		for (var i = 0; i < array_length(keysArray); i += 1)
		{
			var keysArraySubs = EventStruct[$ keysArray[i]];
			for (var j = (array_length(keysArraySubs) - 1); j >= 0; j--)
			{
				if (!instance_exists(keysArraySubs[j][0]))
				{
					array_delete(EventStruct[$ keysArray[i]], j, 1);
				}
			}
		}
	}
}

function PubsubSubscribe(event, func)
{
    with (PUBSUB_MANAGER)
	{
        Subscribe(other.id, event, func);
        return true;
    }
    return false;
}

function PubsubUnsubscribe(event)
{
    with (PUBSUB_MANAGER)
	{
        Unsubscribe(other.id, event);
        return true;
    }
    return false;
}

function PubsubUnsubscribeAll()
{
	with (PUBSUB_MANAGER)
	{
        UnsubscribeAll(other.id);
        return true;
    }
    return false;
}

function PubsubPublish(event, data = undefined)
{
    with (PUBSUB_MANAGER)
	{
        Publish(event, data);
        return true;
    }
    return false;
}
