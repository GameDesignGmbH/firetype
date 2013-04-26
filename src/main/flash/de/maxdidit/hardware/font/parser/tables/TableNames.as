package de.maxdidit.hardware.font.parser.tables 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class TableNames 
	{
		///////////////////////
		// Constants
		///////////////////////
		
		// required tables
		
		public static const CHARACTER_INDEX_MAPPING:String	= "cmap";
		public static const FONT_HEADER:String				= "head";
		public static const HORIZONTAL_HEADER:String		= "hhea";
		public static const HORIZONTAL_METRICS:String		= "hmtx";
		public static const MAXIMUM_PROFILE:String			= "maxp";
		public static const NAMING_TABLE:String				= "name";
		public static const OS2_WINDOWS_METRICS:String		= "OS/2";
		public static const POSTSCRIPT_INFORMATION:String	= "post";
		
		// true type tables
		
		public static const CONTROL_VALUE_TABLE:String		= "cvt "; // table names/tags *always* have 4 characters. Hence the space after the "t".
		public static const FONT_PROGRAM:String				= "fpgm";
		public static const GLYPH_DATA:String				= "glyf";
		public static const INDEX_TO_LOCATION:String		= "loca";
		public static const CVT_PROGRAM:String				= "prep";
		
		// postscript tables
		
		public static const POSTSCRIPT_FONT_PROGRAM:String	= "CFF ";
		public static const VERTICAL_ORIGIN:String			= "VORG";
		
		// bitmap glyph tables
		
		public static const EMBEDDED_BITMAP_DATA:String		= "EBDT";
		public static const EMBEDDED_BITMAP_LOCATIONS:String	= "EBLC";
		public static const EMBEDDED_BITMAP_SCALING:String	= "EBSC";
		
		// advanced typographic tables
		
		public static const BASELINE_DATA:String			= "BASE";
		public static const GLYPH_DEFINITION_DATA:String	= "GDEF";
		public static const GLYPH_POSITIONING_DATA:String	= "GPOS";
		public static const GLYPH_SUBSTITUTION_DATA:String	= "GSUB";
		public static const JUSTIFICATION_DATA:String		= "JSTF";
		
		// other opentype tables
		
		public static const DIGITAL_SIGNATURE:String		= "DSIG";
		public static const GRID_FITTING:String				= "gasp";
		public static const HORIZONTAL_DEVICE_METRICS:String	= "hdmx";
		public static const KERNING:String					= "kern";
		public static const LINEAR_THRESHOLD_DATA:String	= "LTSH";
		public static const PCL5_DATA:String				= "PCLT";
		public static const VERTICAL_DEVICE_METRICS:String	= "VDMX";
		public static const VERTICAL_METRICS_HEADER:String	= "vhea";
		public static const VERTICAL_METRICS:String			= "vmtx";
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function TableNames() 
		{
			throw new Error("This class only holds name constants. Do not instantiate it.");
		}
		
	}

}