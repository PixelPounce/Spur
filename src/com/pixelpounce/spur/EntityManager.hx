/*
 * Spur for NME
 *
 * Copyright (c) 2012 Pixel Pounce Pty Ltd
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 *
 * Orignal code by Adam Martin: https://github.com/adamgit/Entity-System-RDBMS-Inspired-Java
 *
 * Adapted to HaXe by Allan Bishop
 * 
 */

package com.pixelpounce.spur;
import com.pixelpounce.spur.components.Component;
import com.pixelpounce.spur.std.IntUtil;
import com.pixelpounce.spur.logging.Logger;

class EntityManager implements IServiceProvider
{
	private var _lastEntityID:Int;
	private var _entitiesIndex:Hash<Hash<Component>>;
	private var _componentsPerTypeIndex:Hash<List<Component>>;
	private var _entityNameLookup:Hash<Int>;
	private var _groups:Hash<Hash<Bool>>;
	

	public function new() 
	{
		_lastEntityID = 0;
		_entitiesIndex = new Hash < Hash<Component>>() ;
		_componentsPerTypeIndex = new Hash<List<Component>>();
		_entityNameLookup = new Hash<Int>();
		_groups = new Hash<Hash<Bool>>();
	}
	
	public function addComponent(component:Component):Void
	{
		
		if (!_entitiesIndex.exists(Std.string(component.entity)))
		{
			_entitiesIndex.set(Std.string(component.entity), new Hash<Component>());
		}
		
		var componentTypesPerEntity:Hash<Component> = _entitiesIndex.get(Std.string(component.entity));
		
		componentTypesPerEntity.set(Std.string(component.classType),component);
		
		
		//add to another collection that allows fast retrieval of components per type
		
		if (!_componentsPerTypeIndex.exists(component.classType))
		{
			_componentsPerTypeIndex.set(component.classType, new List<Component>());
		}
		
		var componentsPerType:List<Component> = _componentsPerTypeIndex.get(component.classType);
		
		componentsPerType.add(component);
	
	}
	
	public function destroyAllEntities():Void
	{
		for (entity in _entityNameLookup)
		{
			destroyEntity(entity);
		}
	}
	
	public function reset():Void
	{
		destroyAllEntities();
		_lastEntityID = 0;
		_entityNameLookup = new Hash<Int>();
		_entitiesIndex = new Hash < Hash<Component>>() ;
		_componentsPerTypeIndex = new Hash<List<Component>>();
		_groups = new Hash<Hash<Bool>>();
	}
	
	public function componentExists(entity:Int, type:Class<Dynamic>):Bool
	{
		var className = Type.getClassName(type);
		
		if (!_entitiesIndex.exists(Std.string(entity)))
		{
			return false;
		}
		
		var componentTypesPerEntity:Hash<Component> = _entitiesIndex.get(Std.string(entity));
		
		return componentTypesPerEntity.exists(className);

	}
	
	public function getComponent(entity:Int, type:Class<Dynamic>):Component
	{
		var className = Type.getClassName(type);
		
		if (!_entitiesIndex.exists(Std.string(entity)))
		{
			throw "Entity " + Std.string(entity) + " does not exist in entitiesIndex";
			//TODO throw error
		}
		
		var componentTypesPerEntity:Hash<Component> = _entitiesIndex.get(Std.string(entity));
		
		if (!componentTypesPerEntity.exists(className))
		{
			throw "Component type " +className + " does not exist in componentTypesPerEntity";
			//TODO throw error
		}
		
		return componentTypesPerEntity.get(className);
	}
	
	public function hasComponent(entity:Int, type:Class<Dynamic>):Bool
	{
		var className = Type.getClassName(type);
		
		if (!_entitiesIndex.exists(Std.string(entity)))
		{
			return false;
			//TODO throw error
		}
		
		var componentTypesPerEntity:Hash<Component> = _entitiesIndex.get(Std.string(entity));
		
		if (!componentTypesPerEntity.exists(className))
		{
			return false;
		}
		
		return true;
	}
	
	public function hasEntity(entity:Int):Bool
	{
		return _entitiesIndex.exists(Std.string(entity));
	}
	
	public function hasEntityByName(name:String):Bool
	{
		return _entityNameLookup.exists(name);
	}

	public function getAllComponentsOfType(type:Class<Dynamic>):List<Component>
	{
		var className = Type.getClassName(type);
		if (!_componentsPerTypeIndex.exists(className))
		{
			//TODO check to see if I can just return null here or NOT
			return new List<Component>();
		}
		return _componentsPerTypeIndex.get(className);
	}
	
	public function removeComponent(component:Component):Void
	{
		
		if (!_entitiesIndex.exists(Std.string(component.entity)))
		{
			//throw error
		}
		
		var componentTypesPerEntity:Hash<Component> = _entitiesIndex.get(Std.string(component.entity));
		
		if (!componentTypesPerEntity.exists(Std.string(component.classType)))
		{
			//throw error
		}
		
		componentTypesPerEntity.remove(Std.string(component.classType));
		
		
		var componentsPerType:List<Component> = _componentsPerTypeIndex.get(component.classType);
		
		componentsPerType.remove(component);
		
		
	}
	
	public function createEntity(name:String):Int
	{
		var newEntity:Int = generateNewEntityID();
		_entityNameLookup.set(name, newEntity);
		
		return newEntity;
	}
	
	public function getEntityByName(name:String):Int
	{
		if (!_entityNameLookup.exists(name))
		{
			throw name + " entity does not exist.";
		}
		return _entityNameLookup.get(name);
	}
	
	public function destroyEntity(entity:Int):Void
	{
		_entitiesIndex.remove(Std.string(entity));
		
		for (relatedComponentTypes in _componentsPerTypeIndex)
		{
			for (component in relatedComponentTypes)
			{
				if (component.entity == entity)
				{
					relatedComponentTypes.remove(component);
				}
			}
		}
		
		removeEntityFromAllGroups(entity);
		//TODO entityNameLookup delete
	}
	
	private function generateNewEntityID():Int
	{
		if (_lastEntityID < IntUtil.MAX_VALUE)
		{
			_lastEntityID++;
			return _lastEntityID;
		}
		else
		{
			throw "ERROR: Entity ID's exhausted.";
			return -1;
		}
	}
	
	public function createGroup(name:String):Void
	{
		if (_groups.exists(name))
		{
			throw "Group " + name + " already exists.";
		}
		_groups.set(name, new Hash<Bool>());
	}
	
	public function addEntityToGroup(groupName:String, entity:Int):Void
	{
		if (!_groups.exists(groupName))
		{
			throw "Group " + groupName + " does not exist.";
		}
		var group:Hash<Bool> = _groups.get(groupName);
		group.set(Std.string(entity), true);
	}
	
	public function isEntityInGroup(groupName:String, entity:Int):Bool
	{
		if (_groups.exists(groupName))
		{
			var group:Hash<Bool> = _groups.get(groupName);
			
			if (group.exists(Std.string(entity)))
			{
				return true;
			}
		}
		return false;
	}
	
	public function removeEntityFromGroup(groupName:String, entity:Int):Void
	{	
		if (!_groups.exists(groupName))
		{
			throw "Group " + groupName + " does not exist.";
		}
		
		var group:Hash<Bool> = _groups.get(groupName);
		
		var strEntity:String = Std.string(entity);
		if (group.exists(strEntity))
		{
			group.remove(strEntity);
		}
		
	}
	
	public function removeEntityFromAllGroups(entity:Int):Void
	{
		var strEntity:String = Std.string(entity);
		for (group in _groups)
		{
			if (group.exists(strEntity))
			{
				group.remove(strEntity);
			}
		}
	}
}