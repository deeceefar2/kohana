<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" indent="yes" encoding="utf-8" omit-xml-declaration="yes" doctype-public="XSLT-compat"/>
<xsl:strip-space elements="*"/>

<xsl:template match="categories">
	<div class="padding15All">
		<div class="largeSectionWhite">
			<xsl:apply-templates select="category[category_slug='root']" mode="root"/>
		</div>
		<div class="clearer"></div>
	</div>
</xsl:template>

<xsl:template match="category" mode="root">
	<xsl:param name="parent_id" select="category_id"/>
	<xsl:apply-templates select="../category[parent_id=$parent_id]" mode="top-level"/>
</xsl:template>

<xsl:template match="category" mode="top-level">
	<xsl:param name="depth" select="1"/>
	<xsl:param name="category_id" select="category_id"/>
	<xsl:param name="children" select="../category[parent_id=$category_id]"/>
	<div class="browseSearchSection">
		<xsl:if test="/root/content/crumbs/category[category_id=$category_id]/node()">
			<xsl:attribute name="class">browseSearchSection expand</xsl:attribute>
		</xsl:if>
		<xsl:if test="$children">
			<div class="expandHideSection floatRight">
				<div class="plusLarge"></div>
				<div class="minusLarge"></div>
			</div>
		</xsl:if>
		<a class="sectionName floatLeft">
			<xsl:attribute name="href">
				<xsl:text>/listings/category/</xsl:text>
				<xsl:value-of select="category_slug"/>
				<xsl:text>#listings</xsl:text>
			</xsl:attribute>
			<xsl:value-of select="category_name"/>
		</a>
		<div class="clearer"></div>
		<xsl:if test="$children">
			<div class="subSectionsContainer">
				<div class="browseSearchSubSection">
					<xsl:apply-templates select="$children" mode="child"/>
					<div class="clearer"></div>
				</div>
				<div class="clearer"></div>
			</div>
		</xsl:if>
	</div>
</xsl:template>

<xsl:template match="category" mode="child">
	<xsl:param name="category_id" select="category_id"/>
	<xsl:param name="parent_id" select="parent_id"/>
	<xsl:param name="children" select="../category[parent_id=$category_id]"/>
	<div class="browseSearchSubSection">
		<xsl:if test="/root/content/crumbs/category[category_id=$category_id]/node()">
			<xsl:attribute name="class">browseSearchSubSection expand</xsl:attribute>
		</xsl:if>
		<a class="subSectionName floatLeft">
			<xsl:attribute name="href">
				<xsl:text>/listings/category/</xsl:text>
				<xsl:value-of select="../category[category_id=$parent_id]/category_slug"/>
				<xsl:text>/</xsl:text>
				<xsl:value-of select="category_slug"/>
				<xsl:text>#listings</xsl:text>
			</xsl:attribute>
			<xsl:value-of select="category_name"/>
		</a>
		<xsl:if test="$children">
			<div class="expandHideSubSection floatRight">
				<div class="plusSmall"></div>
				<div class="minusSmall"></div>
			</div>
		</xsl:if>
		<div class="clearer"></div>
		<xsl:if test="$children">
			<div class="subSectionsContainer">
				<div class="browseSearchSubSection">
					<xsl:apply-templates select="$children" mode="child"/>
					<div class="clearer"></div>
				</div>
				<div class="clearer"></div>
			</div>
		</xsl:if>
	</div>
</xsl:template>

<xsl:template match="text()"/>

</xsl:stylesheet>