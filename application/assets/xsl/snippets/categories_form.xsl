<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" indent="yes" encoding="utf-8" omit-xml-declaration="yes" doctype-public="XSLT-compat"/>
<xsl:strip-space elements="*"/>

<xsl:template match="categories">
	<xsl:param name="root_id" select="category[category_slug='root']/category_id"/>
	<div class="padding15All">
		<div class="largeSectionWhite">
			<xsl:apply-templates select="category[parent_id=$root_id]" mode="category"/>
		</div>
		<div class="clearer"></div>
	</div>
</xsl:template>

<xsl:template match="category" mode="category">
	<xsl:param name="depth" select="1"/>
	<xsl:param name="category_id" select="category_id"/>
	<xsl:param name="parent_id" select="parent_id"/>
	<xsl:param name="children" select="../category[parent_id=$category_id]"/>
	<div id="{category_id}">
		<xsl:attribute name="class">
			<xsl:text>category</xsl:text>
			<xsl:if test="position()=last() or $depth > 1">
				<xsl:text> noborder</xsl:text>
			</xsl:if>
		</xsl:attribute>
		<label class="categoryTitle floatLeft" for="check-{$category_id}">
			<input type="checkbox" id="check-{$category_id}" name="categories[]" value="{$category_id}" style="margin-right: 20px;"/>
			<xsl:value-of select="category_name"/>
		</label>
		<div class="clearer"></div>
		<div class="children" style="display: block;">
			<xsl:apply-templates select="$children" mode="category">
				<xsl:with-param name="depth" select="$depth + 1"/>
			</xsl:apply-templates>
		</div>
	</div>
</xsl:template>

<xsl:template match="category" mode="href">
	<xsl:param name="parent_id" select="parent_id"/>
	<xsl:choose>
		<xsl:when test="category_slug='root'">
			<xsl:text>/listings/category/</xsl:text>
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates select="../category[category_id=$parent_id]" mode="href"/>
			<xsl:value-of select="category_slug"/>
			<xsl:text>/</xsl:text>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<!--

			<xsl:attribute name="href">
				<xsl:text>/listings/category/</xsl:text>
				<xsl:value-of select="../category[category_id=$parent_id]/category_slug"/>
				<xsl:text>/</xsl:text>
				<xsl:value-of select="category_slug"/>
				<xsl:text>#listings</xsl:text>
			</xsl:attribute>
			-->

<xsl:template match="text()"/>

</xsl:stylesheet>