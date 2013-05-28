package de.maxdidit.hardware.text
{
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.GlyphPositioningTableData;
	import de.maxdidit.hardware.font.data.tables.common.features.FeatureTable;
	import de.maxdidit.hardware.font.data.tables.common.lookup.LookupTable;
	import de.maxdidit.hardware.font.data.tables.other.kern.KerningTableData;
	import de.maxdidit.hardware.font.data.tables.required.hmtx.HorizontalMetricsData;
	import de.maxdidit.hardware.font.data.tables.Table;
	import de.maxdidit.hardware.font.HardwareFont;
	import de.maxdidit.hardware.font.parser.tables.TableNames;
	import de.maxdidit.list.LinkedList;
	import flash.ui.Keyboard;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class Typesetter
	{
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function Typesetter()
		{
		
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		public function assemble(text:String, hardwareText:HardwareText, standardTextFormat:HardwareTextFormat, cache:HardwareCharacterCache):void
		{
			var font:HardwareFont = standardTextFormat.font;
			var subdivision:uint = standardTextFormat.subdivisions;
			var scriptTag:String = standardTextFormat.scriptTag;
			var languageTag:String = standardTextFormat.languageTag;
			
			var startTime:uint = getTimer();
			
			var characterInstances:LinkedList = initializeCharacterInstances(text, font);
			
			font.retrieveCharacterDefinitions(characterInstances);
			font.performCharacterSubstitutions(characterInstances, scriptTag, languageTag);
			collectGlyphs(characterInstances, hardwareText, font, subdivision, cache);
			
			// layouting
			layout(hardwareText, characterInstances, font, scriptTag, languageTag);
			
			trace("assembling time: " + (getTimer() - startTime));
		}
		
		private function layout(hardwareText:HardwareText, characterInstances:LinkedList, font:HardwareFont, scriptTag:String, languageTag:String):void
		{
			// TODO: Clean up this mess, while keeping the code fast. Somehow. Avoid duplicate code.
			
			// positioning tables
			var fontAscender:int = font.ascender;
			var fontDescender:int = font.descender;
			var hmtxData:HorizontalMetricsData = font.data.retrieveTable(TableNames.HORIZONTAL_METRICS).data as HorizontalMetricsData;
			
			var gpos:Table = font.data.retrieveTable(TableNames.GLYPH_POSITIONING_DATA);
			var gposData:GlyphPositioningTableData;
			var gposLookupTables:Vector.<LookupTable>;
			if (gpos)
			{
				gposData = gpos.data as GlyphPositioningTableData;
				gposLookupTables = gposData.retrieveFeatureLookupTables(scriptTag, languageTag)
			}
			
			var kern:Table = font.data.retrieveTable(TableNames.KERNING);
			var kernData:KerningTableData;
			if (kern)
			{
				kernData = kern.data as KerningTableData;
			}
			
			// layouting
			var xGlobal:int = 0;
			var xWord:int = 0;
			var y:int = -fontAscender;
			
			var currentWord:HardwareWord = new HardwareWord();
			
			characterInstances.gotoFirstElement()
			while (characterInstances.currentElement)
			{
				var characterInstance:HardwareCharacterInstance = (characterInstances.currentElement as HardwareCharacterInstanceListElement).hardwareCharacterInstance;
				
				if (characterInstance.charCode == Keyboard.SPACE || characterInstance.charCode == "\n".charCodeAt(0))
				{
					// place old word
					hardwareText.addChild(currentWord);
					
					xGlobal += xWord;
					if (xGlobal > hardwareText.width)
					{
						// goto next line
						xGlobal = currentWord.x = 0;
						xGlobal += xWord;
						y -= fontAscender - fontDescender;
					}
					currentWord.y = y;
					
					// create new word
					currentWord = new HardwareWord();
					currentWord.x = xGlobal;
					
					xWord = 0;
				}
				
				if (characterInstance.charCode == "\n".charCodeAt(0))
				{
					xGlobal = 0;
					y -= fontAscender - fontDescender;
				}
				
				// apply tables
				hmtxData.applyTable(characterInstances);
				
				if (gposLookupTables)
				{
					const l:uint = gposLookupTables.length;
					for (var i:uint = 0; i < l; i++)
					{
						var lookupTable:LookupTable = gposLookupTables[i];
						lookupTable.performLookup(characterInstances, gposData);
					}
				}
				
				if (kernData)
				{
					// TODO: apply kerning
				}
				
				// place character
				if (characterInstance.charCode != Keyboard.SPACE && characterInstance.charCode != "\n".charCodeAt(0))
				{
					currentWord.addChild(characterInstance);
					characterInstance.x += xWord + characterInstance.leftBearing;
					xWord += characterInstance.rightBearing;
				}
				else if (characterInstance.charCode == Keyboard.SPACE)
				{
					currentWord.x += characterInstance.rightBearing;
					xGlobal += characterInstance.rightBearing;
				}
				
				characterInstances.gotoNextElement();
			}
			
			// place last word
			hardwareText.addChild(currentWord);
			
			if (xGlobal > hardwareText.width)
			{
				// goto next line
				xGlobal = currentWord.x = 0;
				y -= fontAscender - fontDescender;
			}
			currentWord.y = y;
		}
		
		private function collectGlyphs(characterInstances:LinkedList, hardwareText:HardwareText, font:HardwareFont, subdivisons:uint, cache:HardwareCharacterCache):void
		{
			characterInstances.gotoFirstElement();
			
			while (characterInstances.currentElement)
			{
				var characterInstance:HardwareCharacterInstance = (characterInstances.currentElement as HardwareCharacterInstanceListElement).hardwareCharacterInstance;
				var character:HardwareCharacter = cache.getCachedCharacter(font, subdivisons, characterInstance.glyphID);
				if (character)
				{
					characterInstance.hardwareCharacter = character;
				}
				
				characterInstance.registerGlyphInstances(font.uniqueIdentifier, subdivisons, 0x0, cache);
				
				characterInstances.gotoNextElement();
			}
		}
		
		private function initializeCharacterInstances(text:String, font:HardwareFont):LinkedList
		{
			var characterInstances:LinkedList = new LinkedList();
			
			const l:uint = text.length;
			for (var i:uint = 0; i < l; i++)
			{
				var charCode:Number = text.charCodeAt(i);
				var glyphID:uint = font.getGlyphIndex(charCode);
				
				var hardwareCharacterInstance:HardwareCharacterInstance = new HardwareCharacterInstance(null);
				hardwareCharacterInstance.glyphID = glyphID;
				hardwareCharacterInstance.charCode = charCode;
				
				var listElement:HardwareCharacterInstanceListElement = new HardwareCharacterInstanceListElement(hardwareCharacterInstance);
				characterInstances.addElement(listElement);
			}
			
			return characterInstances;
		}
	
	}

}