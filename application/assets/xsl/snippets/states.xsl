<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:s="http://states.data" exclude-result-prefixes="s">

<xsl:output method="html" indent="yes" encoding="utf-8" omit-xml-declaration="yes" doctype-public="XSLT-compat"/>
<xsl:strip-space elements="*"/>

<s:states>
	<s:state><s:abbr></s:abbr><s:name>Select a State</s:name></s:state>
	<s:state><s:abbr>AL</s:abbr><s:name>Alabama</s:name></s:state>
	<s:state><s:abbr>AK</s:abbr><s:name>Alaska</s:name></s:state>
	<s:state><s:abbr>AZ</s:abbr><s:name>Arizona</s:name></s:state>
	<s:state><s:abbr>AR</s:abbr><s:name>Arkansas</s:name></s:state>
	<s:state><s:abbr>CA</s:abbr><s:name>California</s:name></s:state>
	<s:state><s:abbr>CO</s:abbr><s:name>Colorado</s:name></s:state>
	<s:state><s:abbr>CT</s:abbr><s:name>Connecticut</s:name></s:state>
	<s:state><s:abbr>DE</s:abbr><s:name>Delaware</s:name></s:state>
	<s:state><s:abbr>DC</s:abbr><s:name>District Of Columbia</s:name></s:state>
	<s:state><s:abbr>FL</s:abbr><s:name>Florida</s:name></s:state>
	<s:state><s:abbr>GA</s:abbr><s:name>Georgia</s:name></s:state>
	<s:state><s:abbr>HI</s:abbr><s:name>Hawaii</s:name></s:state>
	<s:state><s:abbr>ID</s:abbr><s:name>Idaho</s:name></s:state>
	<s:state><s:abbr>IL</s:abbr><s:name>Illinois</s:name></s:state>
	<s:state><s:abbr>IN</s:abbr><s:name>Indiana</s:name></s:state>
	<s:state><s:abbr>IA</s:abbr><s:name>Iowa</s:name></s:state>
	<s:state><s:abbr>KS</s:abbr><s:name>Kansas</s:name></s:state>
	<s:state><s:abbr>KY</s:abbr><s:name>Kentucky</s:name></s:state>
	<s:state><s:abbr>LA</s:abbr><s:name>Louisiana</s:name></s:state>
	<s:state><s:abbr>ME</s:abbr><s:name>Maine</s:name></s:state>
	<s:state><s:abbr>MD</s:abbr><s:name>Maryland</s:name></s:state>
	<s:state><s:abbr>MA</s:abbr><s:name>Massachusetts</s:name></s:state>
	<s:state><s:abbr>MI</s:abbr><s:name>Michigan</s:name></s:state>
	<s:state><s:abbr>MN</s:abbr><s:name>Minnesota</s:name></s:state>
	<s:state><s:abbr>MS</s:abbr><s:name>Mississippi</s:name></s:state>
	<s:state><s:abbr>MO</s:abbr><s:name>Missouri</s:name></s:state>
	<s:state><s:abbr>MT</s:abbr><s:name>Montana</s:name></s:state>
	<s:state><s:abbr>NE</s:abbr><s:name>Nebraska</s:name></s:state>
	<s:state><s:abbr>NV</s:abbr><s:name>Nevada</s:name></s:state>
	<s:state><s:abbr>NH</s:abbr><s:name>New Hampshire</s:name></s:state>
	<s:state><s:abbr>NJ</s:abbr><s:name>New Jersey</s:name></s:state>
	<s:state><s:abbr>NM</s:abbr><s:name>New Mexico</s:name></s:state>
	<s:state><s:abbr>NY</s:abbr><s:name>New York</s:name></s:state>
	<s:state><s:abbr>NC</s:abbr><s:name>North Carolina</s:name></s:state>
	<s:state><s:abbr>ND</s:abbr><s:name>North Dakota</s:name></s:state>
	<s:state><s:abbr>OH</s:abbr><s:name>Ohio</s:name></s:state>
	<s:state><s:abbr>OK</s:abbr><s:name>Oklahoma</s:name></s:state>
	<s:state><s:abbr>OR</s:abbr><s:name>Oregon</s:name></s:state>
	<s:state><s:abbr>PA</s:abbr><s:name>Pennsylvania</s:name></s:state>
	<s:state><s:abbr>RI</s:abbr><s:name>Rhode Island</s:name></s:state>
	<s:state><s:abbr>SC</s:abbr><s:name>South Carolina</s:name></s:state>
	<s:state><s:abbr>SD</s:abbr><s:name>South Dakota</s:name></s:state>
	<s:state><s:abbr>TN</s:abbr><s:name>Tennessee</s:name></s:state>
	<s:state><s:abbr>TX</s:abbr><s:name>Texas</s:name></s:state>
	<s:state><s:abbr>UT</s:abbr><s:name>Utah</s:name></s:state>
	<s:state><s:abbr>VT</s:abbr><s:name>Vermont</s:name></s:state>
	<s:state><s:abbr>VA</s:abbr><s:name>Virginia</s:name></s:state>
	<s:state><s:abbr>WA</s:abbr><s:name>Washington</s:name></s:state>
	<s:state><s:abbr>WV</s:abbr><s:name>West Virginia</s:name></s:state>
	<s:state><s:abbr>WI</s:abbr><s:name>Wisconsin</s:name></s:state>
	<s:state><s:abbr>WY</s:abbr><s:name>Wyoming</s:name></s:state>
 </s:states>

 <xsl:template name="states">
	<xsl:param name="selected" select="'OK'"/>
	<xsl:param name="blank"/>
	<xsl:for-each select="document('')/*/s:states/s:state">
		<xsl:call-template name="option">
			<xsl:with-param name="name" select="./s:name"/>
			<xsl:with-param name="value" select="./s:abbr"/>
			<xsl:with-param name="selected" select="$selected"/>
		</xsl:call-template>
	</xsl:for-each>
 </xsl:template>

<xsl:template name="option">
	<xsl:param name="name"/>
	<xsl:param name="value"/>
	<xsl:param name="selected"/>
	<option value="{$value}">
		<xsl:if test="$value = $selected">
			<xsl:attribute name="selected">selected</xsl:attribute>
		</xsl:if>
		<xsl:value-of select="$name"/>
	</option>
</xsl:template>

<xsl:template match="text()"/>

</xsl:stylesheet>