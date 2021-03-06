/* 
'firetype' is an ActionScript 3 library which loads font files and renders characters via the GPU. 
Copyright �2013 Max Knoblich 
www.maxdid.it 
me@maxdid.it 
 
This file is part of 'firetype' by Max Did It. 
  
'firetype' is free software: you can redistribute it and/or modify 
it under the terms of the GNU Lesser General Public License as published by 
the Free Software Foundation, either version 3 of the License, or 
(at your option) any later version. 
  
'firetype' is distributed in the hope that it will be useful, 
but WITHOUT ANY WARRANTY; without even the implied warranty of 
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the 
GNU Lesser General Public License for more details. 
 
You should have received a copy of the GNU Lesser General Public License 
along with 'firetype'.  If not, see <http://www.gnu.org/licenses/>. 
*/ 
 
package de.maxdidit.hardware.font.data.tables.advanced.gdef  
{ 
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class GlyphClassDefinitionNames 
	{ 
		/////////////////////// 
		// Constants 
		/////////////////////// 
		 
		public static const BASE_GLYPH:uint = 1; 
		public static const LIGATURE_GLYPH:uint = 2; 
		public static const MARK_GLYPH:uint = 3; 
		public static const COMPONENT_GLYPH:uint = 4; 
		 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function GlyphClassDefinitionNames()  
		{ 
			throw new Error("This class should not be instantiated"); 
		} 
		 
	} 
} 
