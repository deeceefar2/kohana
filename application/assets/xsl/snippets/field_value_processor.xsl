<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ft="urn:templates" exclude-result-prefixes="ft">

<xsl:output method="html" indent="yes" encoding="utf-8" omit-xml-declaration="yes" doctype-public="XSLT-compat"/>
<xsl:strip-space elements="*"/>

<xsl:variable name="templates" select="document('')//ft:templates" />

<xsl:template match="listing_field">
	<xsl:apply-templates select="field">
		<xsl:with-param name="field_value" select="current()"/>
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="field">
	<xsl:param name="field_value"/>

	<xsl:choose>
		<xsl:when test="field_type/field_type_slug = 'textbox'">
			<xsl:apply-templates select="current()" mode="textbox">
				<xsl:with-param name="field_value" select="$field_value"/>
			</xsl:apply-templates>
		</xsl:when>
		<xsl:when test="field_type/field_type_slug = 'textarea'">
			<xsl:apply-templates select="current()" mode="textarea">
				<xsl:with-param name="field_value" select="$field_value"/>
			</xsl:apply-templates>
		</xsl:when>
		<xsl:when test="field_type/field_type_slug = 'checkbox'">
			<xsl:apply-templates select="current()" mode="checkbox">
				<xsl:with-param name="field_value" select="$field_value"/>
			</xsl:apply-templates>
		</xsl:when>
		<xsl:when test="field_type/field_type_slug = 'select'">
			<xsl:apply-templates select="current()" mode="select">
				<xsl:with-param name="field_value" select="$field_value"/>
			</xsl:apply-templates>
		</xsl:when>
	</xsl:choose>
</xsl:template>

<xsl:template match="field" mode="textarea">
	<xsl:param name="field_value" />

	<dt class="floatLeft">
		<div class="field_name">
			<xsl:value-of select="field_display_name" />
		</div>
	</dt>
	<dd class="floatLeft">
		<xsl:value-of select="$field_value/listing_field_value" />
	</dd>
	<div class="clearer"></div>
</xsl:template>

<xsl:template match="field" mode="textbox">
	<xsl:param name="field_value" />

	<dt class="floatLeft">
		<div class="field_name">
			<xsl:value-of select="field_display_name" />
		</div>
	</dt>
	<dd class="floatLeft">
		<xsl:value-of select="$field_value/listing_field_value" />
	</dd>
	<div class="clearer"></div>
</xsl:template>

<xsl:template match="field" mode="select">
	<xsl:param name="field_value" />

	<dt class="floatLeft">
		<div class="field_name">
			<xsl:value-of select="field_display_name" />
		</div>
	</dt>
	<dd class="floatLeft">
		<xsl:value-of select="$field_value/listing_field_value" />
	</dd>
	<div class="clearer"></div>
</xsl:template>

<xsl:template match="field" mode="checkbox">
	<xsl:param name="field_value" />

	<dt class="floatLeft">
		<div class="field_name">
			<xsl:value-of select="field_display_name" />
		</div>
	</dt>
	<dd class="floatLeft">
		<xsl:value-of select="$field_value/listing_field_value" />
	</dd>
	<div class="clearer"></div>
</xsl:template>

</xsl:stylesheet>