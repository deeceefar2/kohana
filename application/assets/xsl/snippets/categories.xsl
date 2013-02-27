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
		<a>
			<xsl:attribute name="class">
				<xsl:text>categoryTitle floatLeft</xsl:text>
				<xsl:if test="/root/content/crumbs/category[category_id=$category_id]/node()">
					<xsl:text> selected</xsl:text>
				</xsl:if>
			</xsl:attribute>
			<xsl:attribute name="href">
				<xsl:apply-templates select="../category[category_id=$parent_id]" mode="href"/>
				<xsl:if test="not($children) or not(/root/content/crumbs/category[category_id=$category_id])">
				</xsl:if>
				<xsl:value-of select="category_slug"/>
				<xsl:text>/</xsl:text>
			</xsl:attribute>
			<xsl:value-of select="category_name"/>
		</a>
		<xsl:if test="$children">
			<a>
				<xsl:attribute name="class">
					<xsl:text>expandHideSection floatRight</xsl:text>
					<xsl:if test="/root/content/crumbs/category[category_id=$category_id]/node()">
						<xsl:text> selected</xsl:text>
					</xsl:if>
				</xsl:attribute>
				<xsl:attribute name="href">
					<xsl:apply-templates select="../category[category_id=$parent_id]" mode="href"/>
					<xsl:if test="not($children) or not(/root/content/crumbs/category[category_id=$category_id])">
						<xsl:value-of select="category_slug"/>
						<xsl:text>/</xsl:text>
					</xsl:if>
				</xsl:attribute>
				<div class="plusLarge"></div>
				<div class="minusLarge"></div>
			</a>
		</xsl:if>
		<div class="clearer"></div>
		<div class="children">
			<xsl:attribute name="style">
				<xsl:if test="/root/content/crumbs/category[category_id=$category_id]/node()">
					<xsl:text>display: block;</xsl:text>
				</xsl:if>
			</xsl:attribute>
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