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
 */


package com.pixelpounce.spur.physics;
import box2D.collision.B2WorldManifold;
import box2D.dynamics.B2ContactImpulse;
import box2D.dynamics.B2ContactListener;
import box2D.common.math.B2Vec2;
import box2D.dynamics.contacts.B2Contact;
import com.pixelpounce.spur.components.CSpatialBox2D;
import com.pixelpounce.spur.logging.Logger;


class ContactListener extends B2ContactListener
{

	public function new() 
	{
		super();
	}
	
	
	override public function beginContact(contact:B2Contact):Void
	{
		var componentA:CSpatialBox2D = contact.getFixtureA().getBody().getUserData();
		var componentB:CSpatialBox2D = contact.getFixtureB().getBody().getUserData();
		
		var manifold:B2WorldManifold = new B2WorldManifold();
		contact.getWorldManifold(manifold);
		var points:Array<B2Vec2> = manifold.m_points;
		var point:B2Vec2;
		
		if (points.length > 1)
		{
			point = new B2Vec2((points[0].x + points[1].x) / 2, (points[0].y + points[1].y) / 2);
		}
		else
		{
			point = points[0];
		}
		
		var contactInformationA:ContactInformation = new ContactInformation(componentB, point, manifold.m_normal);
		var contactInformationB:ContactInformation = new ContactInformation(componentA, point, manifold.m_normal);
		
		componentA.addContact(componentB.guid, contactInformationA);
		componentB.addContact(componentA.guid, contactInformationB);

	}
	
	override public function endContact(contact:B2Contact):Void
	{
		var componentA:CSpatialBox2D = contact.getFixtureA().getBody().getUserData();
		var componentB:CSpatialBox2D = contact.getFixtureB().getBody().getUserData();

		componentA.removeContact(componentB.guid);
		componentB.removeContact(componentA.guid);
	}
	
	override public function postSolve(contact:B2Contact, impulse:B2ContactImpulse):Void
	{
		var componentA:CSpatialBox2D = contact.getFixtureA().getBody().getUserData();
		var componentB:CSpatialBox2D = contact.getFixtureB().getBody().getUserData();
		
		var contactA:ContactInformation = componentA.getContact(componentB.guid);
		var contactB:ContactInformation = componentB.getContact(componentA.guid);
		
		if (contactA != null)
		{
			contactA.impulse = impulse;
		}
		if(contactB!=null)
		{
			contactB.impulse = impulse;
		}
	}
}